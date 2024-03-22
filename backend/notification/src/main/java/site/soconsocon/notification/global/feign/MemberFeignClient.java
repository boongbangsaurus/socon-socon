package site.soconsocon.notification.global.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import site.soconsocon.notification.global.feign.dto.response.MemberFeignResponse;

@FeignClient(name = "user-service", path = "/api/members")
public interface MemberFeignClient {

    @GetMapping
    MemberFeignResponse findMemberByMemberEmail(@RequestParam String memberEmail);

}
