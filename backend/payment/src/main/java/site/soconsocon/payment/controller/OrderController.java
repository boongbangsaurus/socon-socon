package site.soconsocon.payment.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import site.soconsocon.payment.domain.dto.request.OrderRequestDto;
import site.soconsocon.payment.domain.entity.jpa.Order;
import site.soconsocon.payment.service.OrderService;
import site.soconsocon.utils.MessageUtils;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/orders")
@Log4j2
public class OrderController {

    private final OrderService orderService;

    /**
     * 요청으로 받은 주문 상품들을 저장
     *
     * @param memberId
     * @param orderRequestDto
     * @return
     */
    @PostMapping("/success")
    public ResponseEntity order(@RequestHeader("X-Authorization-Id") int memberId, @RequestBody OrderRequestDto orderRequestDto) {
        try {
            orderService.saveOrder(memberId, orderRequestDto);
            log.info("결제 성공 : 주문 번호 {}", orderRequestDto.getOrderUid());
            return ResponseEntity.ok().body(MessageUtils.success());
        } catch (RuntimeException e) {
            log.info("주문 상품 환불 진행 : 주문 번호 {}", orderRequestDto.getOrderUid());
//            String token = refundService.getToken(apiKey, secretKey);
//            refundService.refundWithToken(token, orderNumber, e.getMessage());
            return ResponseEntity.status(400).body(MessageUtils.fail("400", "주문을 실패하였습니다."));
        }

        return ResponseEntity.ok().body(MessageUtils.success();
    }
}
