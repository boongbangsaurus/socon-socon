package site.soconsocon.socon.store.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.global.domain.ErrorCode;
import site.soconsocon.socon.global.exception.SoconException;
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
                .status(socon.getStatus())
                .description(item.getDescription())
                .image(item.getImage())
                .build();
    }

    // 소콘북 목록 조회
    public Map<String, Object> getMySoconList(
            int memberId
    ) {
        List<SoconListResponse> usableSocons = new ArrayList<>();
        List<SoconListResponse> unusableSocons = new ArrayList<>();

        List<Socon> unused = soconRepository.getUnusedSoconByMemberId(memberId);
        for (Socon socon : unused) {
            Issue issue = socon.getIssue();
            Item item = issue.getItem();

            if(socon.getExpiredAt().isAfter(LocalDateTime.now())) {
                socon.setStatus("expired");
                soconRepository.save(socon);
            }
            else{
                usableSocons.add(SoconListResponse.builder()
                        .soconId(socon.getId())
                        .itemName(issue.getName())
                        .storeName(item.getStore().getName())
                        .expiredAt(socon.getExpiredAt())
                        .status(socon.getStatus())
                        .itemImage(socon.getIssue().getItem().getImage())
                        .build());
                }
            }

        List<Socon> used = soconRepository.getUsedSoconByMemberId(memberId);
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
        response.put("usable", usableSocons);
        response.put("unusable", unusableSocons);

        return response;
    }

    // 소콘 사용 승인
    public void soconApproval(
            Integer soconId,
            int memberId
    ) {
        Socon socon = soconRepository.findById(soconId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.SOCON_NOT_FOUND));

        if (!Objects.equals(socon.getIssue().getItem().getStore().getId(), memberId)) {
            // 요청자가 해당 점포 주인이 아닌 경우
            throw new SoconException(ErrorCode.FORBIDDEN);
        }

        if (Objects.equals(socon.getStatus(), "usused") && socon.getExpiredAt().isAfter(LocalDateTime.now())) {
            socon.setStatus("used");
            socon.setUsedAt(LocalDateTime.now());
            soconRepository.save(socon);
        } else {
            // 소곤에 등록된 경우, 만료 기간이 지난 경우, 사용된 상태인 경우 등등.
            throw new StoreException(StoreErrorCode.INVALID_SOCON);
        }

    }

    // 소콘북 검색
    public List<SoconListResponse> searchSocon(String category, String keyword, int memberId) {
        List<Socon> socons;
        if (Objects.equals(category, "store")) {
            socons = soconRepository.getSoconByMemberIdAndStoreName(memberId, keyword);
        } else if (Objects.equals(category, "item")) {
            socons = soconRepository.getSoconByMemberIdAndItemName(memberId, keyword);
        } else {
            throw new SoconException(ErrorCode.BAD_REQUEST);
        }

        List<SoconListResponse> soconListResponses = new ArrayList<>();
        for (Socon socon : socons) {
            soconListResponses.add(SoconListResponse.builder()
                    .soconId(socon.getId())
                    .itemImage(socon.getIssue().getName())
                    .storeName(socon.getIssue().getStoreName())
                    .expiredAt(socon.getExpiredAt())
                    .status(socon.getStatus())
                    .itemImage(socon.getIssue().getImage())
                    .build());
        }
        return soconListResponses;
    }
}
