package site.soconsocon.auth.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import site.soconsocon.auth.domain.dto.request.DepositRequestDto;
import site.soconsocon.auth.domain.dto.request.WithdrawRequestDto;
import site.soconsocon.auth.exception.AccountException;
import site.soconsocon.auth.exception.MemberException;
import site.soconsocon.auth.repository.MemberRepository;
import site.soconsocon.auth.service.AccountService;
import site.soconsocon.utils.MessageUtils;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/accounts")
@Log4j2
public class AccountController {

    private final AccountService accountService;

    //소콘머니 증가
    @PostMapping("/deposit")
    public ResponseEntity deposit(@RequestBody DepositRequestDto depositRequestDto) throws MemberException, AccountException {
        accountService.deposit(depositRequestDto);
        return ResponseEntity.ok().body(MessageUtils.success());
    }


    //소콘머니 출금
    @PostMapping("/withdraw")
    public ResponseEntity withdraw(@RequestBody WithdrawRequestDto withdrawRequestDto) throws AccountException, MemberException {
        accountService.withdraw(withdrawRequestDto);
        return ResponseEntity.ok().body(MessageUtils.success());

    }
}

