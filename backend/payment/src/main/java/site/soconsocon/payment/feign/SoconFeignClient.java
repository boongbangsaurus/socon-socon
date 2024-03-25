package site.soconsocon.payment.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import site.soconsocon.payment.feign.request.MySoconFeignRequest;

@FeignClient(name = "socon-service", path = "/api/socons")
public interface SoconFeignClient {

    @PostMapping("/socons")
    void saveMySocon(@RequestBody MySoconFeignRequest mySoconFeignRequest);
}
