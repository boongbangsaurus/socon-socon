package site.soconsocon.socon.store.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import site.soconsocon.socon.store.domain.dto.request.ChargeRequest;
import site.soconsocon.socon.store.domain.entity.feign.Member;

@FeignClient(name = "user", url = "http://localhost:8040/api/v1/members")
public interface FeignServiceClient {

    // 멤버 정보 조회
    @GetMapping("/{memberId}")
    Member getMemberInfo(@PathVariable("memberId") int memberId);

    // 출금 요청
    @GetMapping("accounts/deposit")
    void deposit(ChargeRequest request);

}
