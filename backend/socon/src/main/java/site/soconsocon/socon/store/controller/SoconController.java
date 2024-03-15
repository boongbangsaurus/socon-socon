package site.soconsocon.socon.store.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import site.soconsocon.socon.store.domain.dto.response.SoconInfoResponse;
import site.soconsocon.socon.store.domain.entity.jpa.Socon;
import site.soconsocon.socon.store.service.SoconService;
import site.soconsocon.utils.MessageUtils;

@RestController
@RequestMapping("/api/v1/socons")
@RequiredArgsConstructor
public class SoconController {

    private final SoconService soconService;

    @GetMapping("/{socon_id}")
    public ResponseEntity getSoconInfo(Integer soconId) {

        SoconInfoResponse socon = soconService.getSoconInfo(soconId);

        return ResponseEntity.ok().body(MessageUtils.success(socon));


    }



}
