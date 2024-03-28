package site.soconsocon.socon.sogon.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.global.domain.ErrorCode;
import site.soconsocon.socon.global.exception.SoconException;
import site.soconsocon.socon.sogon.domain.dto.request.AddCommentRequest;
import site.soconsocon.socon.sogon.domain.dto.request.AddSogonRequest;
import site.soconsocon.socon.sogon.domain.dto.response.*;
import site.soconsocon.socon.store.domain.entity.feign.Member;
import site.soconsocon.socon.sogon.domain.entity.jpa.Comment;
import site.soconsocon.socon.sogon.domain.entity.jpa.Sogon;
import site.soconsocon.socon.sogon.exception.SogonErrorCode;
import site.soconsocon.socon.sogon.exception.SogonException;
import site.soconsocon.socon.sogon.repository.CommentRepository;
import site.soconsocon.socon.sogon.repository.SogonRepository;
import site.soconsocon.socon.store.domain.entity.jpa.Socon;
import site.soconsocon.socon.store.exception.StoreErrorCode;
import site.soconsocon.socon.store.exception.StoreException;
import site.soconsocon.socon.store.feign.FeignServiceClient;
import site.soconsocon.socon.store.repository.SoconRepository;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@RequiredArgsConstructor
@Service
public class SogonService {

    private final SoconRepository soconRepository;
    private final SogonRepository sogonRepository;
    private final CommentRepository commentRepository;
    private final FeignServiceClient feignServiceClient;


    // 소곤 작성
    public void addSogon(AddSogonRequest request, int memberId) {

        // 유효한 소콘인지 체크
        Socon socon = soconRepository.findById(request.getSoconId())
                .orElseThrow(() -> new StoreException(StoreErrorCode.SOCON_NOT_FOUND));
        if (!Objects.equals(socon.getStatus(), "unused") || // 사용가능한 소콘이 아닐 경우
                socon.getExpiredAt().isBefore(LocalDateTime.now()) // 만료된 소콘일 경우
        ) {
            throw new StoreException(StoreErrorCode.INVALID_SOCON);
        }

        if (!Objects.equals(socon.getMemberId(), memberId)) {
            // 본인 소유 소콘이 아님
            throw new SoconException(ErrorCode.FORBIDDEN);
        }

        LocalDateTime now = LocalDateTime.now();
        now = now.plusHours(24);

        if (now.isAfter(socon.getExpiredAt())) {
            now = socon.getExpiredAt();
        }

        socon.setStatus("sogon"); // 소콘의 상태를 "sogon"으로 업데이트
        soconRepository.save(socon);

        sogonRepository.save(Sogon.builder()
                .title(request.getTitle())
                .content(request.getContent())
                .createdAt(LocalDateTime.now())
                .expiredAt(now)
                .isExpired(false)
                .isPicked(false)
                .image1(request.getImage1())
                .image2(request.getImage2())
                .memberId(memberId)
                .lat(request.getLat())
                .lng(request.getLng())
                .socon(socon)
                .build());
    }


    // 댓글 작성
    public void addSogonComment(Integer sogonId,
                                AddCommentRequest request,
                                int memberId) {

        Sogon sogon = sogonRepository.findById(sogonId)
                .orElseThrow(() -> new SogonException(SogonErrorCode.SOGON_NOT_FOUND));

        if (sogon.getIsExpired()) {
            throw new SogonException(SogonErrorCode.INVALID_SOGON);
        }

        commentRepository.save(Comment.builder()
                .content(request.getContent())
                .createdAt(LocalDateTime.now())
                .isPicked(false)
                .sogon(sogon)
                .memberId(memberId)
                .build());
    }

    // 소곤 댓글 채택
    public void pickSogonComment(Integer sogonId, Integer commentId, int memberId) {

        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new SogonException(SogonErrorCode.COMMENT_NOT_FOUND));

        Sogon sogon = sogonRepository.findById(sogonId)
                .orElseThrow(() -> new SogonException(SogonErrorCode.SOGON_NOT_FOUND));

        if (sogon.getMemberId().equals(memberId)) {
            throw new SoconException(ErrorCode.FORBIDDEN);
        }

        Socon socon = soconRepository.findById(sogon.getSocon().getId())
                .orElseThrow(() -> new StoreException(StoreErrorCode.SOCON_NOT_FOUND));

        if (!Objects.equals(socon.getStatus(), "unused")) {
            throw new StoreException(StoreErrorCode.INVALID_SOCON);
        }

        // 소콘 소유권 이전
        socon.setMemberId(comment.getMemberId());
        comment.setIsPicked(true);
        sogon.setIsPicked(true);

        soconRepository.save(socon);
        commentRepository.save(comment);
        sogonRepository.save(sogon);
    }

    // 소곤 상세 조회
    public Map<String, Object> getSogon(Integer id) {

        Sogon sogon = sogonRepository.findById(id)
                .orElseThrow(() -> new SogonException(SogonErrorCode.SOGON_NOT_FOUND));

        if(sogon.getExpiredAt().isAfter(LocalDateTime.now())){
            sogon.setIsExpired(true);
            sogonRepository.save(sogon);
        }

        Socon socon = soconRepository.findById(sogon.getSocon().getId())
                .orElseThrow(() -> new StoreException(StoreErrorCode.SOCON_NOT_FOUND));


        Member sogonOwner = feignServiceClient.getMemberInfo(sogon.getMemberId());

        List<CommentResponse> commentRepsonses = new ArrayList<>();
        List<Comment> comments = commentRepository.findAllBySogonId(id);
        for (Comment comment : comments) {

            Member commentOwner = feignServiceClient.getMemberInfo(comment.getMemberId());

            commentRepsonses.add(CommentResponse.builder()
                    .id(comment.getId())
                    .content(comment.getContent())
                    .memberName(commentOwner.getNickname())
                    .memberImg(commentOwner.getProfileUrl())
                    .isPicked(comment.getIsPicked())
                    .build());
        }

        return Map.of("sogon", SogonResponse.builder()
                        .id(sogon.getId())
                        .title(sogon.getTitle())
                        .memberName(sogonOwner.getNickname())
                        .memberImg(sogonOwner.getProfileUrl())
                        .content(sogon.getContent())
                        .image1(sogon.getImage1())
                        .image2(sogon.getImage2())
                        .soconImg(socon.getIssue().getImage())
                        .createdAt(sogon.getCreatedAt())
                        .expiredAt(sogon.getExpiredAt())
                        .isExpired(sogon.getIsExpired())
                        .build(),
                "comments", commentRepsonses);
    }

    // 작성 소곤 목록 조회
    public List<SogonListResponse> getMySogons(int memberId) {

        List<Sogon> sogons = sogonRepository.findAllByMemberId(memberId);
        List<SogonListResponse> sogonListResponses = new ArrayList<>();
        for (Sogon sogon : sogons) {
            Socon socon = soconRepository.findById(sogon.getSocon().getId())
                    .orElseThrow(() -> new StoreException(StoreErrorCode.SOCON_NOT_FOUND));

            if(sogon.getExpiredAt().isAfter(LocalDateTime.now())){
                sogon.setIsExpired(true);
                sogonRepository.save(sogon);
            }
            sogonListResponses.add(SogonListResponse.builder()
                    .title(sogon.getTitle())
                    .soconImg(socon.getIssue().getImage())
                    .createdAt(sogon.getCreatedAt())
                    .isExpired(sogon.getIsExpired())
                    .isPicked(sogon.getIsPicked())
                    .build());
        }

        return sogonListResponses;

    }

    // 작성 댓글 목록 조회
    public List<CommentListResponse> getMyComments(int memberId) {

        List<Comment> comments = commentRepository.findAllByMemberId(memberId);
        List<CommentListResponse> commentListResponses = new ArrayList<>();
        for (Comment comment : comments) {

            commentListResponses.add(CommentListResponse.builder()
                    .title(comment.getSogon().getTitle())
                    .content(comment.getContent())
                    .createdAt(comment.getCreatedAt())
                    .isPicked(comment.getIsPicked())
                    .build());
        }
        return commentListResponses;
    }

    // 범위 내 소곤 리스트 조회
    public Object getSogonList(Double x, Double y) {
        // 중심 좌표와 반경 1.5km 이내에 있는 Sogon 리스트 반환

        double radius = 1.5;
        double radiusInRadians = radius / 6371.0;

        if (x == null || y == null) {
            throw new IllegalArgumentException("Center coordinates cannot be null");
        }

        // 중심 좌표의 위도 경도 값
        double centerXInRadians = Math.toRadians(x);
        double centerYInRadians = Math.toRadians(y);

        // 반경 1.5km 이내의 위도 범위 계산
        double minLatitude = Math.toDegrees(centerXInRadians - radiusInRadians);
        double maxLatitude = Math.toDegrees(centerXInRadians + radiusInRadians);

        // 반경 1.5km 이내의 경도 범위 계산
        double minLongitude = Math.toDegrees(centerYInRadians - radiusInRadians / Math.cos(centerXInRadians));
        double maxLongitude = Math.toDegrees(centerYInRadians + radiusInRadians / Math.cos(centerXInRadians));

        // 중심 좌표를 중심으로 반경 1.5km 이내에 있는 sogon을 조회
        List<Sogon> sogons = sogonRepository.findByLatBetweenAndLngBetween(
                minLatitude, maxLatitude, minLongitude, maxLongitude);

        List<GetSogonListResponse> sogonListResponses = new ArrayList<>();

        for (Sogon sogon : sogons) {

            LocalDateTime createdAt = sogon.getCreatedAt();
            LocalDateTime expiredAt = sogon.getExpiredAt();

            Duration duration = Duration.between(createdAt, expiredAt);

            Member member = feignServiceClient.getMemberInfo(sogon.getMemberId());

            sogonListResponses.add(GetSogonListResponse.builder()
                    .id(sogon.getId())
                    .title(sogon.getTitle())
                    .lastTime((int) duration.toHours())
                    .memberName(member.getNickname())
                    .commentCount(commentRepository.countBySogonId(sogon.getId()))
                    .soconImg(sogon.getSocon().getIssue().getImage())
                    .isPicked(sogon.getIsPicked())
                    .build()
            );
        }

        return sogonListResponses;

    }
}
