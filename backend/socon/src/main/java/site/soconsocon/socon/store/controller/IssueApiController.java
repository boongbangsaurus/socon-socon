package site.soconsocon.socon.store.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import site.soconsocon.socon.store.domain.dto.request.AddMySoconRequest;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.service.IssueService;
import site.soconsocon.socon.store.service.ItemService;
import site.soconsocon.socon.store.service.StoreService;
import site.soconsocon.utils.MessageUtils;

@RestController
@RequestMapping("/api/v1/issues")
@RequiredArgsConstructor
public class IssueApiController {

    private StoreService storeService;
    private IssueService issueService;
    private ItemService itemService;

    @PostMapping("/{issue_id}")
    public ResponseEntity saveMySocon(
            @PathVariable("issue_id") Integer issueId,
            AddMySoconRequest request,
            MemberRequest memberRequest
    ){


        return ResponseEntity.ok().body(MessageUtils.success(null));
    }

    @PutMapping("/{issue_id}")
    public ResponseEntity stopIssue(
            @PathVariable("issue_id") Integer issueId,
            MemberRequest memberRequest
    ){

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }
}
