package site.soconsocon.payment.service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import site.soconsocon.payment.domain.entity.jpa.Order;

// 발신지: payment, 목적지: order
// order service쪽으로 요청
// name은 유레카 기준 발신지를 작성, path는 게이트웨이기준,
@FeignClient(name = "order-service", path = "order-service")
public interface PaymentOrderFeignClient {

    @GetMapping("/orders/{paymentUid}")
    public Order getOrderByPaymentId(@PathVariable String paymentUid);
}
