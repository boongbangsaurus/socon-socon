package site.soconsocon.auth.filter;


import com.netflix.discovery.converters.Auto;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.AuthenticationManager;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.filter.OncePerRequestFilter;
import site.soconsocon.auth.domain.entity.jpa.Member;
import site.soconsocon.auth.exception.JwtException;
import site.soconsocon.auth.repository.MemberRepository;
import site.soconsocon.auth.repository.RefreshTokenRepository;
import site.soconsocon.auth.security.MemberDetails;
import site.soconsocon.auth.util.JwtUtil;
import site.soconsocon.utils.MessageUtils;

import java.io.IOException;

/**
 * 요청 헤더에 jwt 토큰이 있는 경우, 토큰 검증 및 인증 처리 로직 정의.
 */
@Log4j2
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private RefreshTokenRepository refreshTokenRepository;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    public JwtAuthenticationFilter(AuthenticationManager authenticationManager, MemberRepository memberRepository, JwtUtil jwtUtil) {
        this.authenticationManager = authenticationManager;
        this.memberRepository = memberRepository;
        this.jwtUtil = jwtUtil;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException, IOException {
        String servletPath = request.getServletPath();
        String header = request.getHeader(jwtUtil.HEADER_STRING);

        // If header does not contain BEARER or is null delegate to Spring impl and exit
        if (header == null || !header.startsWith(jwtUtil.TOKEN_PREFIX)) {
            filterChain.doFilter(request, response);
            return;
        }

        try {
            if (servletPath.equals("/members/auth") || servletPath.equals("/members/refresh-token")) {
                filterChain.doFilter(request, response);
            } else {
                String jwt = header.replace("Bearer ", "");
                Authentication authentication = jwtUtil.getAuthentication(jwt);
//                // jwt 토큰으로 부터 획득한 인증 정보(authentication) 설정.
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal Server Error");
            return;
        }

        filterChain.doFilter(request, response);
    }


//    @Transactional(readOnly = true)
//    public Authentication getAuthentication(HttpServletRequest request) throws Exception {
//        String token = request.getHeader(jwtUtil.HEADER_STRING);
//        log.info("token: {}", token);
//
//        // 요청 헤더에 Authorization 키값에 jwt 토큰이 포함된 경우에만, 토큰 검증 및 인증 처리 로직 실행.
//
//        if (token != null) {
//            // parse the token and validate it (decode)
//            JWTVerifier verifier = jwtUtil.getVerifier();
//            jwtUtil.handleError(token);
//            DecodedJWT decodedJWT = verifier.verify(token.replace(jwtUtil.TOKEN_PREFIX, ""));
//            String memberId = decodedJWT.getSubject();
//
//
//            if (memberId != null) {
//                // jwt 토큰에 포함된 계정 정보(userId) 통해 실제 디비에 해당 정보의 계정이 있는지 조회.
//                Optional<Member> result = memberRepository.findById(Integer.parseInt(memberId));
//                if (result.get() != null) {
//                    // 식별된 정상 유저인 경우, 요청 context 내에서 참조 가능한 인증 정보(jwtAuthentication) 생성.
//                    Member member = result.get();
//                    System.out.println("-------------------------");
//                    System.out.println(member.getId());
//                    MemberDetails userDetails = new MemberDetails(member);
//                    UsernamePasswordAuthenticationToken jwtAuthentication = new UsernamePasswordAuthenticationToken(member,
//                            null, userDetails.getAuthorities());
//                    jwtAuthentication.setDetails(userDetails);
//
//                    return jwtAuthentication;
//                }
//            }
//            return null;
//        }
//        return null;
//    }

}
