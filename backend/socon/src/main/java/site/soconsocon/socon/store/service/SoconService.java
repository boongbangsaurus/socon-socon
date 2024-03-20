package site.soconsocon.socon.store.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.global.exception.ForbiddenException;
import site.soconsocon.socon.global.exception.badrequest.BadRequest;
import site.soconsocon.socon.global.exception.badrequest.InvalidSoconException;
import site.soconsocon.socon.global.exception.notfound.SoconNotFoundException;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.dto.request.SoconApprovalRequest;
import site.soconsocon.socon.store.domain.dto.response.UnusableSoconListResponse;
import site.soconsocon.socon.store.domain.dto.response.UsableSoconListResponse;
import site.soconsocon.socon.store.domain.dto.response.SoconInfoResponse;
import site.soconsocon.socon.store.domain.entity.jpa.Issue;
import site.soconsocon.socon.store.domain.entity.jpa.Item;
import site.soconsocon.socon.store.domain.entity.jpa.Socon;
import site.soconsocon.socon.store.domain.entity.jpa.Store;
import site.soconsocon.socon.store.repository.IssueRepository;
import site.soconsocon.socon.store.repository.SoconRepository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    // 소콘북 목록 조회
    public Map<String, Object> getMySoconList(
            MemberRequest memberRequest
    ) {
        List<UsableSoconListResponse> usableSocons = new ArrayList<>();
        List<UnusableSoconListResponse> unusableSocons = new ArrayList<>();

        List<Socon> unused = soconRepository.getUnusedSoconByMemberId(memberRequest.getMemberId());
        for (Socon socon : unused) {

            UsableSoconListResponse soconResponse = new UsableSoconListResponse();
            soconResponse.setSoconId(socon.getId());
            soconResponse.setItemName(socon.getIssue().getName());
            soconResponse.setStoreName(socon.getIssue().getItem().getStore().getName());
            soconResponse.setExpiredAt(socon.getExpiredAt());
            soconResponse.setIsUsed(socon.getIsUsed());
            soconResponse.setItemImage(socon.getIssue().getItem().getImage());

            usableSocons.add(soconResponse);
        }
        List<Socon> used = soconRepository.getUsedSoconByMemberId(memberRequest.getMemberId());
        for (Socon socon : used) {
            UnusableSoconListResponse soconResponse = new UnusableSoconListResponse();
            soconResponse.setSoconId(socon.getId());
            soconResponse.setItemName(socon.getIssue().getName());
            soconResponse.setStoreName(socon.getIssue().getItem().getStore().getName());
            soconResponse.setExpiredAt(socon.getExpiredAt());
            soconResponse.setIsUsed(socon.getIsUsed());
            soconResponse.setUsedAt(socon.getUsedAt());
            soconResponse.setItemImage(socon.getIssue().getItem().getImage());

            unusableSocons.add(soconResponse);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("usableSocons", usableSocons);
        response.put("unusableSocons", unusableSocons);

        return response;
    }

    // 소콘 사용 승인
    public void soconApproval(
            SoconApprovalRequest request,
            MemberRequest memberRequest
    ){
        Socon socon = soconRepository.findById(request.getSoconId())
                .orElseThrow(()-> new SoconNotFoundException("NOT FOUND BY ID : " + request.getSoconId()));

        if(socon.getIssue().getItem().getStore().getId() != memberRequest.getMemberId()){
            // 요청자가 해당 점포 주인이 아닌 경우
            throw new ForbiddenException("FORBIDDEN, request doesn't allowed to this memberId");
        }

        if(!socon.getIsUsed() && socon.getExpiredAt().isAfter(LocalDateTime.now())){
            socon.setIsUsed(true);
            socon.setUsedAt(LocalDateTime.now());
            soconRepository.save(socon);
        }
        else{
            if(socon.getIsUsed()){
                // 이미 사용된 소콘
                throw new InvalidSoconException("사용된 소콘. 사용일시 : " + socon.getUsedAt().toString());
            }
            else{
                // 만료된 소콘
                throw new InvalidSoconException("만료된 소콘. 만료일시 : " + socon.getExpiredAt().toString());
            }
        }
    }
}
