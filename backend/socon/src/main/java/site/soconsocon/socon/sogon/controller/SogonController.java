package site.soconsocon.socon.sogon.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import site.soconsocon.socon.sogon.domain.dto.request.AddCommentRequest;
import site.soconsocon.socon.sogon.domain.dto.request.AddSogonRequest;
import site.soconsocon.socon.sogon.service.SogonService;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.utils.MessageUtils;

@RestController
@RequestMapping("/api/v1/sogons")
@RequiredArgsConstructor
public class SogonController {

    private final SogonService sogonService;

    @PostMapping("")
    public ResponseEntity<Object> saveSogon(
            AddSogonRequest request,
            MemberRequest memberRequest
    ){

        sogonService.addSogon(request, memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success());
    }

    @PostMapping("/{sogon_id}/comment/{comment_id}")
    public ResponseEntity<Object> addSogonComment(
        @PathVariable ("sogon_id") Integer sogonId,
        @PathVariable ("comment_id") Integer commentId,
        AddCommentRequest request,
        MemberRequest memberRequest
    ){

        sogonService.addSogonComment(sogonId, commentId, request, memberRequest);
    }

}
