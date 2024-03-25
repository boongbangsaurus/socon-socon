package site.soconsocon.payment.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import site.soconsocon.payment.feign.response.MemberFeignResponse;

@FeignClient(name = "user-service", path = "/api/members")
public interface MemberFeignClient {

    @GetMapping
    MemberFeignResponse findMemberIdByMemberId(@RequestHeader("X-Authorization-Id") int memberId);

}
