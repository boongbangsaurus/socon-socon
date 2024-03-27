package site.soconsocon.payment.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
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

    @PostMapping("")
    public ResponseEntity order(@RequestHeader("X-Authorization-Id") int memberId, @RequestBody OrderRequestDto orderRequestDto) {
        return ResponseEntity.ok().body(MessageUtils.success(orderService.order(memberId, orderRequestDto)));
    }
}
