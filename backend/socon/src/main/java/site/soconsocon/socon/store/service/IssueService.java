package site.soconsocon.socon.store.service;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.store.domain.dto.request.AddIssueRequest;
import site.soconsocon.socon.store.domain.dto.request.AddMySoconRequest;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.dto.response.IssueListResponse;
import site.soconsocon.socon.store.domain.entity.jpa.Issue;
import site.soconsocon.socon.store.domain.entity.jpa.Item;
import site.soconsocon.socon.store.domain.entity.jpa.MySocon;
import site.soconsocon.socon.store.repository.IssueRepository;
import site.soconsocon.socon.store.repository.ItemRepository;
import site.soconsocon.socon.store.repository.MySoconRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@RequiredArgsConstructor
@Service
public class IssueService {

    private final IssueRepository issueRepository;
    private final ItemRepository itemRepository;
    private final MySoconRepository mySoconRepository;


    // 발행 목록 조회
    public List<IssueListResponse> getIssueList(Integer storeId) {

        List<IssueListResponse> issueList = issueRepository.findIssueListByStoreId(storeId);

        if(issueList.isEmpty()) {
            return null;
        }
        else{
            return issueList;
        }
    }

    // 발행 정보 등록
    public void saveIssue(AddIssueRequest request,
                          Integer storeId,
                          Integer itemId,
                          MemberRequest memberRequest)
    {

        Item item = itemRepository.findById(itemId).orElseThrow(() -> new RuntimeException("NOT FOUND BY ID : " + itemId));

        Issue issue = new Issue();
        issue.setStoreId(storeId);
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

    // 소콘 발행
    public void saveMySocon(Integer issueId, AddMySoconRequest request, MemberRequest memberRequest) {

        Issue issue = issueRepository.findById(issueId).orElseThrow(() -> new RuntimeException("NOT FOUND BY ID : " + issueId));

        for(int i = 0; i < request.getPurchaseQuantity(); i++){
            MySocon socon = new MySocon();
            socon.setPurchasedAt(LocalDateTime.now());
            socon.setExpiredAt(LocalDateTime.now().plusDays(issue.getPeriod()));
            socon.setUsedAt(null);
            socon.setIsUsed(false);
            socon.setIssue(issue);
            socon.setMemberId(memberRequest.getMemberId());

            mySoconRepository.save(socon);

        }
        issue.setIssuedQuantity(issue.getIssuedQuantity() + request.getPurchaseQuantity());

        issueRepository.save(issue);
    }
}
