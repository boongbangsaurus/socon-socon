package site.soconsocon.socon.sogon.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.global.domain.ErrorCode;
import site.soconsocon.socon.global.exception.SoconException;
import site.soconsocon.socon.sogon.exception.CommentNotFoundException;
import site.soconsocon.socon.sogon.exception.SogonNotFoundException;
import site.soconsocon.socon.sogon.domain.dto.request.AddCommentRequest;
import site.soconsocon.socon.sogon.domain.dto.request.AddSogonRequest;
import site.soconsocon.socon.sogon.domain.dto.response.*;
import site.soconsocon.socon.sogon.domain.entity.jpa.Comment;
import site.soconsocon.socon.sogon.domain.entity.jpa.Sogon;
import site.soconsocon.socon.sogon.repository.CommentRepository;
import site.soconsocon.socon.sogon.repository.SogonRepository;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.entity.jpa.Socon;
import site.soconsocon.socon.store.exception.StoreErrorCode;
import site.soconsocon.socon.store.exception.StoreException;
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


    public void addSogon(AddSogonRequest request, MemberRequest memberRequest) {

        // 유효한 소콘인지 체크
        Socon socon = soconRepository.findById(request.getSoconId())
                .orElseThrow(() -> new StoreException(StoreErrorCode.SOCON_NOT_FOUND, "" + request.getSoconId()));
        if(!Objects.equals(socon.getStatus(), "unused")){
            // 이미 사용된 소콘
            throw new StoreException(StoreErrorCode.INVALID_SOCON, "사용된 소콘, socon_id : " + request.getSoconId());
        }
        if(socon.getExpiredAt().isBefore(LocalDateTime.now())){
            // 이미 만료된 소콘
            throw new StoreException(StoreErrorCode.INVALID_SOCON, "만료된 소콘, socon_id : " + request.getSoconId());
        }
        if(sogonRepository.countBySoconId(request.getSoconId()) > 0){
            // 이미 소곤에 등록된 소콘
            throw new StoreException(StoreErrorCode.INVALID_SOCON, "이미 소곤에 등록된 소콘, socon_id : " + request.getSoconId());
        }
        if(!Objects.equals(socon.getMemberId(), memberRequest.getMemberId())){
            // 본인 소유 소콘이 아님
            throw new SoconException(ErrorCode.FORBIDDEN, "본인 소유 소콘이 아님");
        }

        LocalDateTime now = LocalDateTime.now();
        if(now.isAfter(socon.getExpiredAt())){
            now = socon.getExpiredAt();
        }
        else{
            now = now.plusHours(24);
        }

        Sogon sogon = new Sogon().builder()
                .title(request.getTitle())
                .content(request.getContent())
                .createdAt(LocalDateTime.now())
                .expiredAt(now)
                .isExpired(false)
                .isPicked(false)
                .image1(request.getImage1())
                .image2(request.getImage2())
                .memberId(memberRequest.getMemberId())
                .lat(request.getLat())
                .lng(request.getLng())
                .socon(socon)
                .build();

        sogonRepository.save(sogon);
    }

    public void addSogonComment(Integer sogonId,
                                AddCommentRequest request,
                                MemberRequest memberRequest) {

        Sogon sogon = sogonRepository.findById(sogonId)
                .orElseThrow(() -> new SogonNotFoundException("" + sogonId));

        if(!sogon.getIsExpired()){
            throw new StoreException(StoreErrorCode.INVALID_SOCON, "만료된 소콘");
        }

        Comment comment = new Comment().builder()
                .content(request.getContent())
                .createdAt(LocalDateTime.now())
                .isPicked(false)
                .sogon(sogon)
                .memberId(memberRequest.getMemberId())
                .build();

        commentRepository.save(comment);
    }

    // 소곤 댓글 채택
    public void pickSogonComment(Integer sogonId, Integer commentId, MemberRequest memberRequest) {

        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new CommentNotFoundException("" + commentId));

        Sogon sogon = sogonRepository.findById(sogonId)
                .orElseThrow(() -> new SogonNotFoundException("" + sogonId));

        if(sogon.getMemberId().equals(memberRequest.getMemberId())){
            throw new SoconException(ErrorCode.FORBIDDEN, "본인 소유 소콘 댓글 채택");
        }

        Socon socon = soconRepository.findById(sogon.getSocon().getId())
                        .orElseThrow(() -> new StoreException(StoreErrorCode.SOCON_NOT_FOUND, "" + sogon.getSocon().getId()));

        if(!Objects.equals(socon.getStatus(), "unused")){
            throw new StoreException(StoreErrorCode.INVALID_SOCON, "사용된 소콘 : " + socon.getId());
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
                .orElseThrow(() -> new SogonNotFoundException("" + id));

        Socon socon = soconRepository.findById(sogon.getSocon().getId())
                .orElseThrow(() -> new StoreException(StoreErrorCode.SOCON_NOT_FOUND,"" + sogon.getSocon().getId()));

        SogonResponse sogonResponse = new SogonResponse().builder()
                .id(sogon.getId())
                .title(sogon.getTitle())
                .memberName("수정필요")
                .memberImg("수정필요")
                .content(sogon.getContent())
                .image1(sogon.getImage1())
                .image2(sogon.getImage2())
                .soconImg(socon.getIssue().getImage())
                .createdAt(sogon.getCreatedAt())
                .expiredAt(sogon.getExpiredAt())
                .isExpired(sogon.getIsExpired())
                .build();

        List<CommentResponse> commentRepsonses = new ArrayList<>();
        List<Comment> comments = commentRepository.findAllBySogonId(id);
        for(Comment comment : comments){
            CommentResponse commentResponse = new CommentResponse().builder()
                    .id(comment.getId())
                    .content(comment.getContent())
                    .memberName("수정필요")
                    .memberImg("수정필요")
                    .isPicked(comment.getIsPicked())
                    .build();

            commentRepsonses.add(commentResponse);
        }

        return Map.of("sogon", sogonResponse, "comments", commentRepsonses);
    }

    // 작성 소곤 목록 조회
    public List<SogonListResponse> getMySogons(MemberRequest memberRequest) {

        List<Sogon> sogons = sogonRepository.findAllByMemberId(memberRequest.getMemberId());
        List<SogonListResponse> sogonListResponses = new ArrayList<>();
        for(Sogon sogon : sogons){
            Socon socon = soconRepository.findById(sogon.getSocon().getId())
                    .orElseThrow(() -> new StoreException(StoreErrorCode.SOCON_NOT_FOUND,"" + sogon.getSocon().getId()));

            SogonListResponse sogonListResponse = new SogonListResponse().builder()
                    .title(sogon.getTitle())
                    .soconImg(socon.getIssue().getImage())
                    .createdAt(sogon.getCreatedAt())
                    .isExpired(sogon.getIsExpired())
                    .isPicked(sogon.getIsPicked())
                    .build();

            sogonListResponses.add(sogonListResponse);
        }

        return sogonListResponses;

    }

    // 작성 댓글 목록 조회
    public List<CommentListResponse> getMyComments(MemberRequest memberRequest) {

        List<Comment> comments = commentRepository.findAllByMemberId(memberRequest.getMemberId());
        List<CommentListResponse> commentListResponses = new ArrayList<>();
        for(Comment comment : comments ){

            CommentListResponse commentListResponse = new CommentListResponse().builder()
                    .title(comment.getSogon().getTitle())
                    .content(comment.getContent())
                    .createdAt(comment.getCreatedAt())
                    .isPicked(comment.getIsPicked())
                    .build();

            commentListResponses.add(commentListResponse);
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
        List<Sogon> sogons = sogonRepository.findByLatitudeBetweenAndLongitudeBetween(
                minLatitude, maxLatitude, minLongitude, maxLongitude);

        List<GetSogonListResponse> sogonListResponses = new ArrayList<>();

        for(Sogon sogon: sogons){

            LocalDateTime createdAt = sogon.getCreatedAt();
            LocalDateTime expiredAt = sogon.getExpiredAt();

            Duration duration = Duration.between(createdAt, expiredAt);


            GetSogonListResponse response = new GetSogonListResponse().builder()
                    .id(sogon.getId())
                    .title(sogon.getTitle())
                    .lastTime((int)duration.toHours())
                    .memberName("수정필요")
                    .commentCount(commentRepository.countBySogonId(sogon.getId()))
                    .soconImg(sogon.getSocon().getIssue().getImage())
                    .isPicked(sogon.getIsPicked())
                    .build();

            sogonListResponses.add(response);
        }

        return sogonListResponses;

    }
}
