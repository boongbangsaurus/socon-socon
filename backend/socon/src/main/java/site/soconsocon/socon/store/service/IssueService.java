package site.soconsocon.socon.store.service;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.store.domain.dto.response.IssueListResponse;
import site.soconsocon.socon.store.repository.IssueRepository;

import java.util.List;

@RequiredArgsConstructor
@Service
public class IssueService {

    private final IssueRepository issueRepository;


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
}
