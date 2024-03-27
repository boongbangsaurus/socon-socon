package site.soconsocon.payment.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.payment.domain.dto.request.OrderRequestDto;
import site.soconsocon.payment.domain.entity.jpa.Order;
import site.soconsocon.payment.domain.entity.jpa.Payment;
import site.soconsocon.payment.domain.entity.jpa.PaymentStatus;
import site.soconsocon.payment.repository.OrderRepository;
import site.soconsocon.payment.repository.PaymentRepository;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final PaymentRepository paymentRepository;

    public Order order(int memberId, OrderRequestDto orderRequestDto) {
        Payment payment = Payment.builder()
                .price(orderRequestDto.getPrice())
                .status(PaymentStatus.READY)
                .build();

        paymentRepository.save(payment);

        Order order = Order.builder()
                .orderUid(UUID.randomUUID().toString())
                .itemName(orderRequestDto.getItemName())
                .price(orderRequestDto.getPrice())
                .memberId(memberId)
                .issueId(orderRequestDto.getIssueId())
                .paymentId(payment.getId())
                .build();

        return orderRepository.save(order);
    }

}
