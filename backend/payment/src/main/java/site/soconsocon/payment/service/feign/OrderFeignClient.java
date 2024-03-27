package site.soconsocon.payment.service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import site.soconsocon.payment.service.feign.response.OrderFeignResponse;

@FeignClient(name = "socon-service", path = "/api/orders")
public interface OrderFeignClient {

    @GetMapping("/{orderUid}")
    OrderFeignResponse findOrderByOrderUid(@PathVariable String orderUid);


    @PutMapping("/{orderUid}/status")
    void updateOrderStatus(@PathVariable String orderUid, String status);
}
