package site.soconsocon.payment.service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import site.soconsocon.payment.service.feign.response.MemberFeignResponse;

@FeignClient(name = "user-service", path = "/api/v1/members")
public interface MemberFeignClient {

    @GetMapping
    MemberFeignResponse findMemberIdByMemberId(@PathVariable int memberId);

}
