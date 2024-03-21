package site.soconsocon.socon.store.service;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.global.domain.ErrorCode;
import site.soconsocon.socon.global.exception.GlobalException;
import site.soconsocon.socon.store.domain.dto.request.AddIssueRequest;
import site.soconsocon.socon.store.domain.dto.request.AddMySoconRequest;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.dto.request.OrderRequest;
import site.soconsocon.socon.store.domain.dto.response.IssueListResponse;
import site.soconsocon.socon.store.domain.entity.jpa.*;
import site.soconsocon.socon.store.exception.StoreErrorCode;
import site.soconsocon.socon.store.exception.StoreException;
import site.soconsocon.socon.store.repository.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@RequiredArgsConstructor
@Service
public class IssueService {

    private final IssueRepository issueRepository;
    private final ItemRepository itemRepository;
    private final SoconRepository soconRepository;
    private final StoreRepository storeRepository;
    private final OrderRepository orderRepository;


    // 발행 목록 조회
    public List<IssueListResponse> getIssueList(Integer storeId, MemberRequest memberRequest) {

        Integer storeMemberId = storeRepository.findMemberIdByStoreId(storeId);

        if (!Objects.equals(storeMemberId, memberRequest.getMemberId())) {
            // 본인 가게 아닐 경우
            throw new GlobalException(ErrorCode.FORBIDDEN, "본인 점포 아님");
        } else {
            List<IssueListResponse> issueList = issueRepository.findIssueListByStoreId(storeId);
            if (issueList.isEmpty()) {
                return null;
            } else {
                return issueList;
            }
        }
    }

    // 발행 정보 등록
    public void saveIssue(AddIssueRequest request,
                          Integer storeId,
                          Integer itemId,
                          MemberRequest memberRequest) {
        if (!Objects.equals(memberRequest.getMemberId(), storeRepository.findById(storeId).get().getMemberId())) {
            throw new GlobalException(ErrorCode.FORBIDDEN, "본인 점포 아님");
        } else {
            Item item = itemRepository.findById(itemId)
                    .orElseThrow(() -> new StoreException(StoreErrorCode.ITEM_NOT_FOUND, "" + itemId));

            Issue issue = new Issue();
            issue.setStoreName(storeRepository.findById(storeId).get().getName());
            issue.setName(item.getName());
            issue.setImage(item.getImage());
            issue.setIsMain(request.getIsMain());
            issue.setIsDiscounted(request.getIsDiscounted());
            issue.setDiscountedPrice(request.getDiscountedPrice());
            issue.setMaxQuantity(request.getMaxQuantity());
            issue.setIssuedQuantity(0);
            issue.setUsed(0);
            issue.setPeriod(request.getPeriod());
            issue.setCreatedAt(LocalDateTime.now());
            issue.setItem(item);
            issue.setStatus('A');

            issueRepository.save(issue);
        }
    }

    // 소콘 발행
    public void saveMySocon(Integer issueId, AddMySoconRequest request, MemberRequest memberRequest) {

        Issue issue = issueRepository.findById(issueId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.ISSUE_NOT_FOUND, "" + issueId));

        if (issue.getStatus() != 'A') {
            // 발행 중 아님
            throw new GlobalException(ErrorCode.BAD_REQUEST, "발행 중지/완료된 상태. status : " + issue.getStatus());
        }

        if (issue.getMaxQuantity() - issue.getIssuedQuantity() < request.getPurchaseQuantity()) {
            // 발행 가능 개수보다 요청한 개수가 많을 경우
            throw new GlobalException(ErrorCode.BAD_REQUEST, "발행 가능 개수 초과, 남은 발행 개수 : " + (issue.getMaxQuantity() - issue.getIssuedQuantity()));
        }

        for (int i = 0; i < request.getPurchaseQuantity(); i++) {
            Socon socon = new Socon();
            socon.setPurchasedAt(LocalDateTime.now());
            socon.setExpiredAt(LocalDateTime.now().plusDays(issue.getPeriod()));
            socon.setUsedAt(null);
            socon.setIsUsed(false);
            socon.setIssue(issue);
            socon.setMemberId(memberRequest.getMemberId());

            soconRepository.save(socon);

            issue.setIssuedQuantity(issue.getIssuedQuantity() + request.getPurchaseQuantity());
            issueRepository.save(issue);

        }
    }

    // 발행 중지
    public void stopIssue(Integer issueId, MemberRequest memberRequest) {

        Issue issue = issueRepository.findById(issueId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.ISSUE_NOT_FOUND, "" + issueId));

        if (!Objects.equals(issue.getItem().getStore().getMemberId(), memberRequest.getMemberId())) {
            // 본인 점포의 상품이 아닐 경우
            throw new GlobalException(ErrorCode.FORBIDDEN, "본인 점포 아님");
        } else {
            if (issue.getStatus() != 'A') {
                // 발행 중 아님
                throw new GlobalException(ErrorCode.BAD_REQUEST, "발행 중지/완료된 상태. status : " + issue.getStatus());
            } else {
                issue.setStatus('I');
                issue.setMaxQuantity(issue.getIssuedQuantity()); // 발행 재개 없음, 최대 발행량 현재 발행량과 일치시킴
                issueRepository.save(issue);
            }
        }
    }

    // 소콘 주문
    public void order(Integer issueId, OrderRequest request, MemberRequest memberRequest) {

        Issue issue = issueRepository.findById(issueId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.ISSUE_NOT_FOUND, "" + issueId));
        Store store = issue.getItem().getStore();
        if (store.getIsClosed()) {
            throw new StoreException(StoreErrorCode.ALREADY_SET_CLOSE_PLAN, "" + store.getId());
        }
        if (issue.getMaxQuantity() - issue.getIssuedQuantity() < request.getOrderQuantity()) {
            // 소콘 가능 개수보다 요청한 개수가 많을 경우
            throw new GlobalException(ErrorCode.BAD_REQUEST, "발행 가능 개수 초과, 남은 발행 개수 : " + (issue.getMaxQuantity() - issue.getIssuedQuantity()));
        }
        if(issue.getStatus() != 'A') {
            // 발행 중 아님
            throw new GlobalException(ErrorCode.BAD_REQUEST, "발행 중지/완료된 상태. status : " + issue.getStatus());
        } else {
            // 주문번호 생성
            String orderUid = LocalDate.now() + "-" + UUID.randomUUID().toString().replace("-", "");

            // 주문 엔터티 생성
            Order order = new Order().builder()
                    .price(request.getPrice())
                    .name(issue.getName())
                    .quantity(request.getOrderQuantity())
                    .orderUid(orderUid)
                    .orderStatus("success")
                    .orderTime(LocalDateTime.now())
                    .build();

            orderRepository.save(order);

            // 결제 요청

        }
    }

}
