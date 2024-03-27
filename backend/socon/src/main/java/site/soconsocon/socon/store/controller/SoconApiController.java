package site.soconsocon.socon.store.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import site.soconsocon.socon.store.domain.dto.response.SoconInfoResponse;
import site.soconsocon.socon.store.service.SoconService;
import site.soconsocon.utils.MessageUtils;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/socons")
@RequiredArgsConstructor
public class SoconApiController {

    private final SoconService soconService;

    // 소콘 상세 조회
    @GetMapping("/{socon_id}")
    public ResponseEntity<Object> getSoconInfo(
            @PathVariable("socon_id") Integer soconId
    ) {
        SoconInfoResponse socon = soconService.getSoconInfo(soconId);

        return ResponseEntity.ok().body(MessageUtils.success(socon));
    }

    // 소콘북 목록 조회
    @GetMapping("/book")
    public ResponseEntity<Object> soconBook(
            @RequestHeader("X-Authorization-Id") int memberId
    ) {
        Map<String, Object> response = soconService.getMySoconList(memberId);
        return ResponseEntity.ok().body(MessageUtils.success(response));
    }

    // 소콘 사용 승인
    @PostMapping("/{socon_id}/approval")
    public ResponseEntity<Object> soconApproval(
            @PathVariable("socon_id") Integer soconId,
            @RequestHeader("X-Authorization-Id") int memberId) {

        soconService.soconApproval(soconId, memberId);

        return ResponseEntity.ok().body(MessageUtils.success());
    }

    // 소콘북 검색
    @PostMapping("/book/search?category={category}&keyword={keyword}")
    public ResponseEntity<Object> soconBookSearch(
            @PathVariable("category") String category,
            @PathVariable("keyword") String keyword,
            @RequestHeader("X-Authorization-Id") int memberId
    ) {


        return ResponseEntity.ok().body(MessageUtils.success(soconService.searchSocon(category, keyword, memberId)));
    }


}
