package site.soconsocon.socon.store.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import site.soconsocon.socon.store.domain.dto.request.AddMySoconRequest;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.dto.request.OrderRequest;
import site.soconsocon.socon.store.service.IssueService;
import site.soconsocon.utils.MessageUtils;

@RestController
@RequestMapping("/api/v1/issues")
@RequiredArgsConstructor
public class IssueApiController {

    private final IssueService issueService;

    // 소콘 발행(생성)
    @PostMapping("/{issue_id}")
    public ResponseEntity<Object> saveMySocon(
            @PathVariable("issue_id") Integer issueId,
            AddMySoconRequest request,
            MemberRequest memberRequest
    ){
        issueService.saveMySocon(issueId, request, memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }

    // 소콘 발행 중지
    @PutMapping("/{issue_id}")
    public ResponseEntity<Object> stopIssue(
            @PathVariable("issue_id") Integer issueId,
            MemberRequest memberRequest
    ){
        issueService.stopIssue(issueId, memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }

    // 소콘 주문
    @PostMapping("/{issue_id}/order")
    public ResponseEntity<Object> order(
            @PathVariable("issue_id") Integer issueId,
            OrderRequest request,
            MemberRequest memberRequest
    ){
        issueService.order(issueId, request, memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }
}
