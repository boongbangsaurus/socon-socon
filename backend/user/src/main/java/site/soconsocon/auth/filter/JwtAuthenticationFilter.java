package site.soconsocon.auth.filter;


import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.AuthenticationManager;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.filter.OncePerRequestFilter;
import site.soconsocon.auth.domain.entity.jpa.Member;
import site.soconsocon.auth.exception.JwtException;
import site.soconsocon.auth.repository.MemberRepository;

import site.soconsocon.auth.security.MemberDetailService;
import site.soconsocon.auth.security.MemberDetails;
import site.soconsocon.auth.util.JwtUtil;
import site.soconsocon.utils.MessageUtils;

import java.io.IOException;

/**
 * 요청 헤더에 jwt 토큰이 있는 경우, 토큰 검증 및 인증 처리 로직 정의.
 */
@Log4j2
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final MemberRepository memberRepository;
    private final JwtUtil jwtUtil;
    private final MemberDetailService memberDetailService;


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException, IOException {
        String servletPath = request.getServletPath();
        String header = request.getHeader(jwtUtil.HEADER_STRING);

        // If header does not contain BEARER or is null delegate to Spring impl and exit
        if (header == null || !header.startsWith(jwtUtil.TOKEN_PREFIX)) {
            filterChain.doFilter(request, response);
            return;
        }

//<<<<<<< Updated upstream
//        try {
//            if (servletPath.equals("/members/auth") || servletPath.equals("/members/refresh-token")) {
//                filterChain.doFilter(request, response);
//            } else {
//                String jwt = header.replace("Bearer ", "");
//                Authentication authentication = jwtUtil.getAuthentication(jwt);
////                // jwt 토큰으로 부터 획득한 인증 정보(authentication) 설정.
//                SecurityContextHolder.getContext().setAuthentication(authentication);
//            }
//
//        } catch (Exception e) {
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal Server Error");
//            return;
//=======
        if (servletPath.equals("/members/auth") || servletPath.equals("/members/refresh-token")) {
            filterChain.doFilter(request, response);
        } else {
            String token = header.substring(7);
            if (jwtUtil.validateToken(token)) {
                String userId = jwtUtil.getUsername(token);

                UserDetails userDetails = memberDetailService.loadUserByUsername(userId);

                if (userDetails != null) {
                    UsernamePasswordAuthenticationToken jwtAuthentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                    // jwt 토큰으로 부터 획득한 인증 정보(authentication) 설정.
                    SecurityContextHolder.getContext().setAuthentication(jwtAuthentication);
                }
            }
        }
        filterChain.doFilter(request, response);
    }

}
