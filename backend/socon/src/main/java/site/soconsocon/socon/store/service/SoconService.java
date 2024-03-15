package site.soconsocon.socon.store.service;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.store.domain.dto.response.SoconInfoResponse;
import site.soconsocon.socon.store.domain.entity.jpa.Issue;
import site.soconsocon.socon.store.domain.entity.jpa.Item;
import site.soconsocon.socon.store.domain.entity.jpa.Socon;
import site.soconsocon.socon.store.repository.IssueRepository;
import site.soconsocon.socon.store.repository.SoconRepository;

@RequiredArgsConstructor
@Service
public class SoconService {

    private final SoconRepository soconRepository;
    private final IssueRepository issueRepository;


    // 소콘 상세 조회
    public SoconInfoResponse getSoconInfo(Integer soconId) {

        Socon socon = soconRepository.findById(soconId).orElseThrow(() -> new RuntimeException("NOT FOUND BY ID : " + soconId));

        Issue issue = socon.getIssue();

        Item item = issue.getItem();

        SoconInfoResponse soconInfoResponse = new SoconInfoResponse();
        soconInfoResponse.setItemName(issue.getName());
        soconInfoResponse.setStoreName(item.getStore().getName());
        soconInfoResponse.setPurchasedAt(socon.getPurchasedAt());
        soconInfoResponse.setExpiredAt(socon.getExpiredAt());
        soconInfoResponse.setDescription(item.getDescription());
        soconInfoResponse.setImage(item.getImage());

        return soconInfoResponse;

    }
}
