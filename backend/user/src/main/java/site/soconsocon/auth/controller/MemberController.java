package site.soconsocon.auth.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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
import site.soconsocon.auth.repository.MemberRepository;
import site.soconsocon.auth.repository.RefreshTokenRepository;
import site.soconsocon.auth.security.MemberDetailService;
import site.soconsocon.auth.security.MemberDetails;
import site.soconsocon.auth.service.MemberService;
import site.soconsocon.auth.util.JwtUtil;
import site.soconsocon.utils.MessageUtils;

import java.io.IOException;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/members")
@Log4j2
public class MemberController {

    private final MemberService memberService;
    private final MemberDetailService memberDetailService;
    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;
    private final RefreshTokenRepository refreshTokenRepository;

    /**
     * 회원가입
     *
     * @param registerDto
     * @return
     */
    @PostMapping("")
    public ResponseEntity register(@RequestBody MemberRegisterRequestDto registerDto) throws MemberException {
        log.info(registerDto);
        return ResponseEntity.ok().body(MessageUtils.success(memberService.register(registerDto)));
    }

    /**
     * 로그인
     *
     * @param loginDto
     * @return
     */
    @PostMapping("/auth")
    public ResponseEntity login(@RequestBody MemberLoginRequestDto loginDto) throws IOException, MemberException {
        String email = loginDto.getEmail();
        String password = loginDto.getPassword();
        String fcmToken = loginDto.getFcmToken();
        log.info(loginDto);

        Member member = memberService.getMemberByEmail(email);
        String memberId = String.valueOf(member.getId());

        // 로그인 요청한 유저로부터 입력된 패스워드 와 디비에 저장된 유저의 암호화된 패스워드가 같은지 확인.(유효한 패스워드인지 여부 확인)
        if (passwordEncoder.matches(password, member.getPassword())) {
            // 유효한 패스워드가 맞는 경우, 로그인 성공으로 응답.(액세스 토큰을 포함하여 응답값 전달)
            MemberDetails memberDetails = (MemberDetails) memberDetailService.loadUserByUsername(memberId);
            String accessToken = jwtUtil.generateToken(memberDetails);
            String refreshToken = jwtUtil.generateRefreshToken(memberDetails);
            RefreshToken redis = new RefreshToken(member.getId(), refreshToken);
            refreshTokenRepository.save(redis);
            MemberLoginResponseDto memberLoginResponseDto = new MemberLoginResponseDto(accessToken, refreshToken, member.getNickname());

            //FCM 토큰 발급
//            deleteAndSaveFCMToken(memberId, fcmToken);
//
//            if (fcmRepository.findByMember(member).isEmpty()) {
//                fcmRepository.save(FCMToken.builder().member(member).fireBaseToken(fcmToken).build());
//            } else { //이미 fcm 토큰이 있는 유저라면
//                fcmRepository.findByMember(member).orElseThrow().update(fcmToken);
//            }
            return ResponseEntity.ok().body(MessageUtils.success(memberLoginResponseDto));
        }
        // 유효하지 않는 패스워드인 경우, 로그인 실패로 응답.
        return ResponseEntity.status(401).body(MessageUtils.fail("401", "Invalid Password"));
    }

    //마이페이지
    @GetMapping("/mypage")
    public ResponseEntity getUserInfo(@RequestHeader("X-Authorization-Id") int memberId) {
        return ResponseEntity.ok().body(MessageUtils.success(memberService.getUserInfo(memberId)));

    }

    /**
     * 리프레시 토큰을 가지고 액세스 토큰 재발급
     *
     * @param refreshToken
     * @return
     */
    @PostMapping("/access-token")
    public ResponseEntity<?> generateAccessToken(@RequestBody RefreshToken refreshToken, Authentication authentication) throws IOException {
        MemberDetails memberDetails = (MemberDetails) authentication.getDetails();
        String memberId = memberDetails.getUsername();

        return ResponseEntity.ok().body(MessageUtils.success(memberService.createAccessToken(memberDetails, refreshToken.getRefreshToken())));

    }

    @PostMapping("/refresh-token")
    public ResponseEntity<?> generateRefreshToken(Authentication authentication) {
        MemberDetails memberDetails = (MemberDetails) authentication.getDetails();

        return ResponseEntity.ok().body(MessageUtils.success(memberService.createRefreshToken(memberDetails)));

    }

    @GetMapping("/user")
    public ResponseEntity<Member> getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        Optional<Member> member = memberRepository.findMemberById(Integer.parseInt(username));
        if (member.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(member.get());
    }


    @GetMapping("/id")
    public MemberFeignResponse getMemberByMemberId(@RequestHeader("X-Authorization-Id") int memberId) {
        log.info("open feign communication success!");
        return memberService.findMemberByMemberId(memberId);
    }

    @GetMapping("")
    public ResponseEntity getMemberByEmail(@RequestParam("email") String email) throws MemberException {
        return ResponseEntity.ok().body(MessageUtils.success(memberService.getMemberByEmail(email)));
    }


}
