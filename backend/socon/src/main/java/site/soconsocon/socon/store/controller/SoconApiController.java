package site.soconsocon.socon.store.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.dto.response.SoconInfoResponse;
import site.soconsocon.socon.store.service.SoconService;
import site.soconsocon.utils.MessageUtils;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/socons")
@RequiredArgsConstructor
public class SoconApiController {

    private final SoconService soconService;

    @GetMapping("/{socon_id}")
    public ResponseEntity getSoconInfo(Integer soconId) {

        SoconInfoResponse socon = soconService.getSoconInfo(soconId);

        return ResponseEntity.ok().body(MessageUtils.success(socon));
    }

    @GetMapping("/book")
    public ResponseEntity soconBook(
            MemberRequest memberRequest
    ) {

        Map response = soconService.getMySoconList(memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success(response));
    }


}
