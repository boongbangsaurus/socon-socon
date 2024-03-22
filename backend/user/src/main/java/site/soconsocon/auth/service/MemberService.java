package site.soconsocon.auth.service;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import site.soconsocon.auth.domain.dto.request.MemberRegisterRequestDto;
import site.soconsocon.auth.domain.dto.response.MemberFeignResponse;
import site.soconsocon.auth.domain.dto.response.MemberResponseDto;
import site.soconsocon.auth.domain.entity.jpa.Member;
import site.soconsocon.auth.domain.entity.jpa.RefreshToken;
import site.soconsocon.auth.domain.entity.jpa.UserRole;
import site.soconsocon.auth.exception.ErrorCode;
import site.soconsocon.auth.exception.MemberException;
import site.soconsocon.auth.repository.MemberRepository;
import site.soconsocon.auth.repository.RefreshTokenRepository;
import site.soconsocon.auth.util.JwtUtil;
import site.soconsocon.utils.MessageUtils;

import java.io.IOException;
import java.util.Optional;


@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    private final RefreshTokenRepository refreshTokenRepository;

    private final PasswordEncoder passwordEncoder;

    private final JwtUtil jwtUtil;

    /**
     * 회원가입
     *
     * @param requestDto
     * @return
     */
    public Member register(MemberRegisterRequestDto requestDto) throws MemberException {
        //이메일 중복체크
        if (!dupleEmailCheck(requestDto.getEmail())) {
            throw new MemberException(ErrorCode.USER_EMAIL_ALREADY_EXISTED); //이미 있는 이메일
        }
        Member member = Member.builder()
                .email(requestDto.getEmail())
                .password(passwordEncoder.encode(requestDto.getPassword()))
                .name(requestDto.getName())
                .nickname(requestDto.getNickname())
                .role(UserRole.USER)
                .phoneNumber(requestDto.getPhoneNumber())
                .isAgreed(requestDto.isAgreed())
                .build();

        return memberRepository.save(member);
    }

    /**
     * 이메일 중복검사
     *
     * @param email
     */
    public boolean dupleEmailCheck(String email) {
        if (memberRepository.findMemberByEmail(email).isPresent()) {
            return false;
        }
        return true;
    }

    /**
     * 액세스 토큰 재발급
     *
     * @param memberId     :현재 접속한 멤버 PK
     * @param refreshToken
     * @return
     */
    public String createAccessToken(int memberId, String refreshToken) throws IOException{
        //Redis에 저장된 리프레시 토큰 가져오기
        RefreshToken refreshToken1 = refreshTokenRepository.findRefreshTokenByMemberId(memberId);
        String rt = refreshToken1.getRefreshToken();
        Optional<Member> result = memberRepository.findMemberById(memberId);

        if (result.isPresent()) {
            Member member = result.get();
            //request 리프레시 토큰과 Redis에 있는 리프레시 토큰이 같다면
            if (rt.equals(refreshToken)) {
                //리프레시 토큰의 유효시간이 남아있다면
                if (!jwtUtil.isRefreshTokenExpired(String.valueOf(memberId))) {
                    return jwtUtil.generateToken(member);
                }
            }
        }
        return null;
    }

    /**
     * 리프레시 토큰 재발급
     *
     * @param memberId
     * @return
     */
    public String createRefreshToken(int memberId) {
        Optional<Member> result = memberRepository.findMemberById(memberId);
        if (result.isPresent()) {
            Member member = result.get();
            //리프레시 토큰의 유효시간이 남아있다면
            if (!jwtUtil.isRefreshTokenExpired(String.valueOf(memberId))) {
                return jwtUtil.generateRefreshToken(member);
            }
        }
        return null;
    }

    public MemberResponseDto getUserInfo(int memberId) {
        Optional<Member> result = memberRepository.findMemberById(memberId);
        MemberResponseDto memberResponseDto = new MemberResponseDto();

        if (result.isPresent()) {
            Member member = result.get();
            memberResponseDto.setEmail(member.getEmail());
            memberResponseDto.setNickname(member.getNickname());
            memberResponseDto.setName(member.getName());
            memberResponseDto.setPhoneNumber(member.getPhoneNumber());
            memberResponseDto.setSoconMoney(member.getSoconMoney());
            memberResponseDto.setSoconPassword(member.getSoconPassword());

        }
        return memberResponseDto;
    }

    public Member getMemberByEmail(String email) throws MemberException {
        Optional<Member> result = memberRepository.findMemberByEmail(email);
        if (result.isEmpty()) {
            throw new MemberException(ErrorCode.USER_NOT_FOUND);
        }
        return result.get();
    }

    public MemberFeignResponse findMemberByMemberId(int memberId) {
        Optional<Member> result = memberRepository.findMemberById(memberId);
        MemberFeignResponse memberFeignResponse = new MemberFeignResponse();

        if (result.isPresent()) {
            Member member = result.get();
            memberFeignResponse.setMemberId(memberId);
            memberFeignResponse.setEmail(member.getEmail());
            memberFeignResponse.setNickname(member.getNickname());
            memberFeignResponse.setSoconMoney(member.getSoconMoney());
            memberFeignResponse.setSoconPassword(member.getSoconPassword());
        }
        return memberFeignResponse;
    }

    /**
     * 회원 정보 수정
     */
//    public void modifyMember(MemberModifyRequestDto requestDto) {
//        memberRepository.updateMember(requestDto.getName(), requestDto.getNickname(), requestDto.getMemo(), requestDto.getProfileUrl());
//    }
}
