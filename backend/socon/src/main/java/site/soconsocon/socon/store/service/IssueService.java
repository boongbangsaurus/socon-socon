package site.soconsocon.socon.store.service;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.global.domain.ErrorCode;
import site.soconsocon.socon.global.exception.SoconException;
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
import java.util.ArrayList;
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
            throw new SoconException(ErrorCode.FORBIDDEN);
        }
        List<Issue> issues = issueRepository.findIssueListByStoreId(storeId);
        List<IssueListResponse> issueList = new ArrayList<>();
        for (Issue issue : issues) {
            issueList.add(IssueListResponse.builder()
                    .id(issue.getId())
                    .isMain(issue.getIsMain())
                    .name(issue.getName())
                    .image(issue.getImage())
                    .issuedQuantity(issue.getIssuedQuantity())
                    .leftQuantity(issue.getMaxQuantity() - issue.getIssuedQuantity())
                    .isDiscounted(issue.getIsDiscounted())
                    .price(issue.getPrice())
                    .discountedPrice(issue.getDiscountedPrice())
                    .createdAt(issue.getCreatedAt())
                    .build());
        }
        return issueList;
    }

    // 발행 정보 등록
    public void saveIssue(AddIssueRequest request,
                          Integer storeId,
                          Integer itemId,
                          MemberRequest memberRequest) {
        if (!Objects.equals(memberRequest.getMemberId(), storeRepository.findMemberIdByStoreId(storeId))) {
            throw new SoconException(ErrorCode.FORBIDDEN);
        }
        Item item = itemRepository.findById(itemId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.ITEM_NOT_FOUND));

        issueRepository.save(Issue.builder()
                .storeName(storeRepository.findNameByStoreId(storeId))
                .name(item.getName())
                .image(item.getImage())
                .isMain(request.getIsMain())
                .isDiscounted(request.getIsDiscounted())
                .discountedPrice(request.getDiscountedPrice())
                .maxQuantity(request.getMaxQuantity())
                .issuedQuantity(0)
                .used(0)
                .period(request.getPeriod())
                .createdAt(LocalDateTime.now())
                .item(item)
                .status('A')
                .build());
    }

    // 소콘 발행
    public void saveMySocon(Integer issueId, AddMySoconRequest request, MemberRequest memberRequest) {

        Issue issue = issueRepository.findById(issueId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.ISSUE_NOT_FOUND));
        if (issue.getStatus() != 'A') {
            // 발행 중 아님
            throw new StoreException(StoreErrorCode.INVALID_ISSUE);
        }
        if (issue.getMaxQuantity() - issue.getIssuedQuantity() < request.getPurchaseQuantity()) {
            // 발행 가능 개수보다 요청한 개수가 많을 경우
            throw new StoreException(StoreErrorCode.ISSUE_MAX_QUANTITY);
        }
        for (int i = 0; i < request.getPurchaseQuantity(); i++) {
            LocalDateTime purchasedAt = LocalDateTime.now();
            soconRepository.save(Socon.builder()
                    .purchasedAt(purchasedAt)
                    .expiredAt(purchasedAt.plusDays(issue.getPeriod()))
                    .usedAt(null)
                    .status("unused")
                    .issue(issue)
                    .memberId(memberRequest.getMemberId())
                    .build());
        }
        issue.setIssuedQuantity(issue.getIssuedQuantity() + request.getPurchaseQuantity());
        issueRepository.save(issue);
    }

    // 발행 중지
    public void stopIssue(Integer issueId, MemberRequest memberRequest) {

        Issue issue = issueRepository.findById(issueId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.ISSUE_NOT_FOUND));

        if (!Objects.equals(issueRepository.findMemberIdByIssueId(issueId), memberRequest.getMemberId())) {
            // 본인 점포의 상품이 아닐 경우
            throw new SoconException(ErrorCode.FORBIDDEN);
        }
        if (issue.getStatus() != 'A') {
            // 발행 중 아님
            throw new SoconException(ErrorCode.BAD_REQUEST);
        }
        issue.setStatus('I');
        issueRepository.save(issue);
    }

    // 소콘 주문
    public void order(Integer issueId, OrderRequest request, MemberRequest memberRequest) {

        Issue issue = issueRepository.findById(issueId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.ISSUE_NOT_FOUND));

        Store store = issue.getItem().getStore();

        if (store.getClosingPlanned() != null) {
            // 가게 폐업 상태
            throw new StoreException(StoreErrorCode.ALREADY_SET_CLOSE_PLAN);
        }
        if (issue.getMaxQuantity() - issue.getIssuedQuantity() < request.getOrderQuantity()) {
            // 소콘 가능 개수보다 요청한 개수가 많을 경우
            throw new SoconException(ErrorCode.BAD_REQUEST);
        }
        if (issue.getStatus() != 'A') {
            // 발행 중 아님
            throw new SoconException(ErrorCode.BAD_REQUEST);
        }
        // 주문번호 생성
        String orderUid = LocalDate.now() + "-" + UUID.randomUUID().toString().replace("-", "");

        // 주문 엔터티 생성
        orderRepository.save(Order.builder()
                .price(request.getPrice())
                .name(issue.getName())
                .quantity(request.getOrderQuantity())
                .orderUid(orderUid)
                .orderStatus("success")
                .orderTime(LocalDateTime.now())
                .memberId(memberRequest.getMemberId())
                .build());

        // 결제 요청

    }

}
