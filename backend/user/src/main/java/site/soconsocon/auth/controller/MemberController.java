package site.soconsocon.auth.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import site.soconsocon.auth.domain.dto.request.MemberLoginRequestDto;
import site.soconsocon.auth.domain.dto.request.MemberRegisterRequestDto;
import site.soconsocon.auth.domain.dto.response.MemberFeignResponse;
import site.soconsocon.auth.domain.dto.response.MemberLoginResponseDto;
import site.soconsocon.auth.domain.dto.response.MemberResponseDto;
import site.soconsocon.auth.domain.entity.jpa.Member;
import site.soconsocon.auth.domain.entity.jpa.RefreshToken;
import site.soconsocon.auth.exception.MemberException;
import site.soconsocon.auth.repository.RefreshTokenRepository;
import site.soconsocon.auth.security.MemberDetailService;
import site.soconsocon.auth.security.MemberDetails;
import site.soconsocon.auth.service.MemberService;
import site.soconsocon.auth.util.JwtUtil;
import site.soconsocon.utils.MessageUtils;

import java.io.IOException;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/members")
@Log4j2
public class MemberController {

    private final MemberService memberService;
    /**
     * 회원가입
     *
     * @param registerDto
     * @return
     */
    @PostMapping("")
    public ResponseEntity register(@RequestBody MemberRegisterRequestDto registerDto) throws MemberException{
        Member member = memberService.register(registerDto);
        return ResponseEntity.ok().body(MessageUtils.success(member));
    }

    /**
     * 로그인
     *
     * @param loginDto
     * @return
     */
    @PostMapping("/auth")
    public ResponseEntity login(@RequestBody MemberLoginRequestDto loginDto) throws MemberException{
        memberService.login(loginDto);
        // 유효하지 않는 패스워드인 경우, 로그인 실패로 응답.
        return ResponseEntity.ok().body(MessageUtils.success());
    }

    //마이페이지
    @GetMapping("/mypage")
    public ResponseEntity getUserInfo(@RequestHeader("X-Authorization-Id") int memberId) throws MemberException {
        MemberResponseDto memberResponseDto = memberService.getUserInfo(memberId);
        return ResponseEntity.ok().body(MessageUtils.success(memberResponseDto));
    }

    /**
     * 리프레시 토큰을 가지고 액세스 토큰 재발급
     *
     * @param refreshToken
     * @return
     */
    @PostMapping("/access-token")
    public ResponseEntity<?> generateAccessToken(@RequestBody RefreshToken refreshToken, Authentication authentication) {
        MemberDetails memberDetails = (MemberDetails) authentication.getDetails();
        String accessToken = memberService.createAccessToken(memberDetails, refreshToken.getRefreshToken()))
        return ResponseEntity.ok().body(MessageUtils.success(accessToken));
    }

    @PostMapping("/refresh-token")
    public ResponseEntity<?> generateRefreshToken(Authentication authentication) {
        MemberDetails memberDetails = (MemberDetails) authentication.getDetails();
        String refreshToken = memberService.createRefreshToken(memberDetails);

        return ResponseEntity.ok().body(MessageUtils.success(refreshToken));

    }


    /**
     * Gateway에서 가져오는 memberId로 Member 조회
     *
     * @param memberId
     * @return
     * @throws MemberException
     */
    @GetMapping("/me")
    public ResponseEntity getMember(@RequestHeader("X-Authorization-Id") int memberId) throws MemberException {
        log.info("gateway success!");
        MemberFeignResponse member = memberService.findMemberByMemberId(memberId);
        return ResponseEntity.ok().body(MessageUtils.success(member));
    }

    @GetMapping("/email")
    public ResponseEntity getMemberByEmail(@RequestParam("email") String email) throws MemberException {
        Member member = memberService.getMemberByEmail(email);
        return ResponseEntity.ok().body(MessageUtils.success(member));
    }

    @GetMapping("/{memberId}")
    public MemberFeignResponse getMemberByMemberId(@PathVariable int memberId) throws MemberException {
        log.info("open feign communication success!");
        log.info("getMemberByMemberId() 메소드 호출");
        return memberService.findMemberByMemberId(memberId);
    }

}
