package site.soconsocon.socon.sogon.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.global.exception.ForbiddenException;
import site.soconsocon.socon.global.exception.badrequest.BadRequest;
import site.soconsocon.socon.global.exception.badrequest.InvalidSoconException;
import site.soconsocon.socon.global.exception.notfound.CommentNotFoundException;
import site.soconsocon.socon.global.exception.notfound.SoconNotFoundException;
import site.soconsocon.socon.global.exception.notfound.SogonNotFoundException;
import site.soconsocon.socon.sogon.domain.dto.request.AddCommentRequest;
import site.soconsocon.socon.sogon.domain.dto.request.AddSogonRequest;
import site.soconsocon.socon.sogon.domain.dto.response.CommentResponse;
import site.soconsocon.socon.sogon.domain.dto.response.SogonListResponse;
import site.soconsocon.socon.sogon.domain.dto.response.SogonResponse;
import site.soconsocon.socon.sogon.domain.entity.jpa.Comment;
import site.soconsocon.socon.sogon.domain.entity.jpa.Sogon;
import site.soconsocon.socon.sogon.repository.CommentRepository;
import site.soconsocon.socon.sogon.repository.SogonRepository;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.entity.jpa.Socon;
import site.soconsocon.socon.store.repository.SoconRepository;

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
                .orElseThrow(() -> new SoconNotFoundException("존재하지 않는 소콘, socon_id : " + request.getSoconId()));
        if(socon.getIsUsed()){
            // 이미 사용된 소콘
            throw new InvalidSoconException("사용된 소콘, socon_id : " + request.getSoconId());
        }
        if(socon.getExpiredAt().isBefore(LocalDateTime.now())){
            // 이미 만료된 소콘
            throw new InvalidSoconException("만료된 소콘, socon_id : " + request.getSoconId());
        }
        if(sogonRepository.countBySoconId(request.getSoconId()) > 0){
            // 이미 소곤에 등록된 소콘
            throw new InvalidSoconException("이미 소곤에 등록된 소콘, socon_id : " + request.getSoconId());
        }
        if(!Objects.equals(socon.getMemberId(), memberRequest.getMemberId())){
            // 본인 소유 소콘이 아님
            throw new ForbiddenException("본인 소유 소콘이 아님, socon_id : " + request.getSoconId() + " member_id : " + memberRequest.getMemberId());
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
                .createdDate(LocalDateTime.now())
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
            throw new BadRequest("만료 소곤 " + sogonId);
        }

        Comment comment = new Comment().builder()
                .content(request.getContent())
                .createdAt(LocalDateTime.now())
                .isChosen(false)
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
            throw new ForbiddenException("본인 소유 소콘 댓글 채택");
        }

        Socon socon = soconRepository.findById(sogon.getSocon().getId())
                        .orElseThrow(() -> new SoconNotFoundException("" + sogon.getSocon().getId()));

        if(socon.getIsUsed()){
            throw new BadRequest("사용된 소콘 : " + socon.getId());
        }

        // 소콘 소유권 이전
        socon.setMemberId(comment.getMemberId());
        comment.setIsChosen(true);
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
                .orElseThrow(() -> new SoconNotFoundException("" + sogon.getSocon().getId()));

        SogonResponse sogonResponse = new SogonResponse().builder()
                .id(sogon.getId())
                .title(sogon.getTitle())
                .memberName("수정필요")
                .memberImg("수정필요")
                .content(sogon.getContent())
                .image1(sogon.getImage1())
                .image2(sogon.getImage2())
                .soconImg(socon.getIssue().getImage())
                .createdAt(sogon.getCreatedDate())
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
                    .isPicked(comment.getIsChosen())
                    .build();

            commentRepsonses.add(commentResponse);
        }

        return Map.of("sogon", sogonResponse, "comments", commentRepsonses);
    }

    public List<SogonListResponse> getMySogons(MemberRequest memberRequest) {

        List<Sogon> sogons = sogonRepository.findAllByMemberId(memberRequest.getMemberId());
        List<SogonListResponse> sogonListResponses = new ArrayList<>();
        for(Sogon sogon : sogons){
            Socon socon = soconRepository.findById(sogon.getSocon().getId())
                    .orElseThrow(() -> new SoconNotFoundException("" + sogon.getSocon().getId()));

            SogonListResponse sogonListResponse = new SogonListResponse().builder()
                    .title(sogon.getTitle())
                    .soconImg(socon.getIssue().getImage())
                    .createdAt(sogon.getCreatedDate())
                    .isExpired(sogon.getIsExpired())
                    .isPicked(sogon.getIsPicked())
                    .build();

            sogonListResponses.add(sogonListResponse);
        }

        return sogonListResponses;

    }
}
