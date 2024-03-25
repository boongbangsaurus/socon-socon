package site.soconsocon.socon.store.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.global.domain.ErrorCode;
import site.soconsocon.socon.global.exception.SoconException;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.dto.response.SoconListResponse;
import site.soconsocon.socon.store.domain.dto.response.SoconInfoResponse;
import site.soconsocon.socon.store.domain.entity.jpa.Issue;
import site.soconsocon.socon.store.domain.entity.jpa.Item;
import site.soconsocon.socon.store.domain.entity.jpa.Socon;
import site.soconsocon.socon.store.exception.StoreErrorCode;
import site.soconsocon.socon.store.exception.StoreException;
import site.soconsocon.socon.store.repository.SoconRepository;

import java.time.LocalDateTime;
import java.util.*;

@RequiredArgsConstructor
@Service
public class SoconService {

    private final SoconRepository soconRepository;


    // 소콘 상세 조회
    public SoconInfoResponse getSoconInfo(Integer soconId) {

        Socon socon = soconRepository.findById(soconId).orElseThrow(() -> new StoreException(StoreErrorCode.SOCON_NOT_FOUND));
        Issue issue = socon.getIssue();
        Item item = issue.getItem();

        return SoconInfoResponse.builder()
                .itemName(issue.getName())
                .storeName(item.getStore().getName())
                .purchasedAt(socon.getPurchasedAt())
                .expiredAt(socon.getExpiredAt())
                .description(item.getDescription())
                .image(item.getImage())
                .build();
    }

    // 소콘북 목록 조회
    public Map<String, Object> getMySoconList(
            MemberRequest memberRequest
    ) {
        List<SoconListResponse> usableSocons = new ArrayList<>();
        List<SoconListResponse> unusableSocons = new ArrayList<>();

        List<Socon> unused = soconRepository.getUnusedSoconByMemberId(memberRequest.getMemberId());
        for (Socon socon : unused) {
            Issue issue = socon.getIssue();
            Item item = issue.getItem();

            usableSocons.add(SoconListResponse.builder()
                    .soconId(socon.getId())
                    .itemName(issue.getName())
                    .storeName(item.getStore().getName())
                    .expiredAt(socon.getExpiredAt())
                    .status(socon.getStatus())
                    .itemImage(socon.getIssue().getItem().getImage())
                    .build());
        }
        List<Socon> used = soconRepository.getUsedSoconByMemberId(memberRequest.getMemberId());
        for (Socon socon : used) {
            Issue issue = socon.getIssue();
            Item item = issue.getItem();

            unusableSocons.add(SoconListResponse.builder()
                    .soconId(socon.getId())
                    .itemName(issue.getName())
                    .storeName(item.getStore().getName())
                    .expiredAt(socon.getExpiredAt())
                    .status(socon.getStatus())
                    .itemImage(socon.getIssue().getItem().getImage())
                    .build());
        }

        Map<String, Object> response = new HashMap<>();
        response.put("usableSocons", usableSocons);
        response.put("unusableSocons", unusableSocons);

        return response;
    }

    // 소콘 사용 승인
    public void soconApproval(
            Integer soconId,
            MemberRequest memberRequest
    ) {
        Socon socon = soconRepository.findById(soconId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.SOCON_NOT_FOUND));

        if (!Objects.equals(socon.getIssue().getItem().getStore().getId(), memberRequest.getMemberId())) {
            // 요청자가 해당 점포 주인이 아닌 경우
            throw new SoconException(ErrorCode.FORBIDDEN);
        }

        if (Objects.equals(socon.getStatus(), "usused") && socon.getExpiredAt().isAfter(LocalDateTime.now())) {
            socon.setStatus("used");
            socon.setUsedAt(LocalDateTime.now());
            soconRepository.save(socon);
        } else {
            throw new StoreException(StoreErrorCode.INVALID_SOCON);
        }

    }

    // 소콘북 검색
    public List<SoconListResponse> searchSocon(
            String category,
            String keyword,
            MemberRequest memberRequest
    ) {
        if (Objects.equals(category, "store")) {
            return soconRepository.getSoconByMemberIdAndStoreName(memberRequest.getMemberId(), keyword);
        } else if (Objects.equals(category, "item")) {
            return soconRepository.getSoconByMemberIdAndItemName(memberRequest.getMemberId(), keyword);
        } else {
            throw new SoconException(ErrorCode.BAD_REQUEST);
        }
    }
}
