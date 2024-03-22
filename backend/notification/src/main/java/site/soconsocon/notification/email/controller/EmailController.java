package site.soconsocon.notification.email.controller;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import site.soconsocon.notification.email.domain.dto.request.EmailConfirmRequest;
import site.soconsocon.notification.email.domain.dto.request.EmailRequest;
import site.soconsocon.notification.email.service.EmailService;
import site.soconsocon.utils.MessageUtils;


@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/email")
public class EmailController {

    private final EmailService emailService;

    @PostMapping("/join-code")
    public ResponseEntity sendCodeEmail(
            @RequestBody EmailRequest emailRequest
    ){
        emailService.sendJoinCodeMail(emailRequest.getEmail());
        return ResponseEntity.ok(MessageUtils.success());
    }

    @PostMapping("/code")
    public ResponseEntity<MessageUtils> codeEmail(
            @RequestBody EmailRequest emailRequest
    ){
        emailService.sendCodeMail(emailRequest.getEmail());
        return ResponseEntity.ok(MessageUtils.success());
    }


    @PostMapping("/confirm")
    public ResponseEntity<MessageUtils> confirmNumber(
            @RequestBody EmailConfirmRequest confirmRequest
    ){
        emailService.confirmCode(confirmRequest.getEmail(), confirmRequest.getCode());
        return ResponseEntity.ok(MessageUtils.success());
    }


}