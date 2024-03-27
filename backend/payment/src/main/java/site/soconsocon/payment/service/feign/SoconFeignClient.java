package site.soconsocon.payment.service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import site.soconsocon.payment.service.feign.request.AddMySoconRequest;

@FeignClient(name = "socon-service", path = "/api/v1/issues")
public interface SoconFeignClient {

    @PostMapping("/{issue_id}")
    void saveMySocon(@PathVariable("issue_id") Integer issueId, @RequestBody AddMySoconRequest addMySoconRequest);
}
