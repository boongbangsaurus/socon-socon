package site.soconsocon.socon.store.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import site.soconsocon.socon.store.domain.dto.request.ChargeRequest;
import site.soconsocon.socon.store.domain.entity.feign.Member;

@FeignClient(name = "user-service", url = "http://localhost:8080/")
public interface FeignServiceClient {

    // 멤버 정보 조회
    @GetMapping("api/v1/members/me/{memberId}")
    Member getMemberInfo(@PathVariable("memberId") int memberId);

    // 출금 요청
    @GetMapping("api/v1/accounts/deposit")
    void deposit(ChargeRequest request);

}
