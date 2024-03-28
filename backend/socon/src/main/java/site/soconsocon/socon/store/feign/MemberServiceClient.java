package site.soconsocon.socon.store.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import site.soconsocon.socon.sogon.domain.entity.feign.Member;

@FeignClient(name = "user-service", url = "http://localhost:8080/")
public interface MemberServiceClient {

    @GetMapping("api/v1/members/me/{memberId}")
    Member getMemberInfo(@PathVariable("memberId") int memberId);

}
