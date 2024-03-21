package site.soconsocon.payment.service;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestHeader;
import site.soconsocon.payment.domain.dto.request.PaymentCallbackRequestDto;
import site.soconsocon.payment.feign.SoconFeignClient;
import site.soconsocon.payment.feign.request.MySoconFeignRequest;
import site.soconsocon.payment.feign.response.OrderFeignResponse;
import site.soconsocon.payment.domain.entity.jpa.PaymentStatus;
import site.soconsocon.payment.feign.MemberFeignClient;
import site.soconsocon.payment.feign.OrderFeignClient;
import site.soconsocon.payment.feign.PaymentOrderFeignClient;
import site.soconsocon.payment.repository.PaymentRepository;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final PaymentRepository paymentRepository;

    private final PaymentOrderFeignClient paymentOrderFeignClient;

    private final MemberFeignClient memberFeignClient;

    private final OrderFeignClient orderFeignClient;

    private final SoconFeignClient soconFeignClient;

    private final IamportClient iamportClient;

//    public PaymentByOrderResponseDto findOrderByPaymentId(String paymentUid) {
//        //결제 정보 가져오기
//        Optional<site.soconsocon.payment.domain.entity.jpa.Payment> findPayment = paymentRepository.findPaymentByPaymentUid(paymentUid);
//
//        if (findPayment.isPresent()) {
//            site.soconsocon.payment.domain.entity.jpa.Payment payment = findPayment.get();
//            // Order에 feign을 사용해서 API 요청
//            Order order = paymentOrderFeignClient.getOrderByPaymentId(paymentUid);
//            PaymentByOrderResponseDto paymentByOrderResponseDto = PaymentByOrderResponseDto.builder()
//                    .id(payment.getId())
//                    .paymentUid(payment.getPaymentUid())
//                    .orderUid(payment.getOrderUid())
//                    .itemName()
//                    .build();
//
//        }

    //    }
    public IamportResponse<Payment> paymentByCallback(PaymentCallbackRequestDto request) {
        try {
            // 결제 단건 조회(아임포트)
            // 결제 ImpUid Check
            IamportResponse<Payment> iamportResponse = iamportClient.paymentByImpUid(request.getPaymentUid());
            // 주문내역 조회
            // feign을 통해 주문 정보 가져오기
            OrderFeignResponse orderFeignResponse = orderFeignClient.findOrderByOrderUid(request.getOrderUid());
            site.soconsocon.payment.domain.entity.jpa.Payment payment = paymentRepository.findPaymentByPaymentUid(orderFeignResponse.getPaymentUid());

//            Order order = orderRepository.findOrderAndPayment(request.getOrderUid())
//                    .orElseThrow(() -> new IllegalArgumentException("주문 내역이 없습니다."));

            // 결제 완료가 아니면
            if (!iamportResponse.getResponse().getStatus().equals("paid")) {
                // 주문, 결제 삭제
                orderFeignClient.updateOrderStatus(orderFeignResponse.getOrderUid(), "FAIL"); //Fail로 변경
                paymentRepository.delete(payment);

//                orderRepository.delete(order);
//                paymentRepository.delete(order.getPayment());

                throw new RuntimeException("결제 미완료");
            }

            // DB에 저장된 결제 금액
            int price = orderFeignResponse.getPrice();
//            int price = order.getPayment().getPrice();
            // 실 결제 금액
            int iamportPrice = iamportResponse.getResponse().getAmount().intValue();

            // 결제 금액 검증
            if (iamportPrice != price) {
                // 주문, 결제 삭제
                orderFeignClient.updateOrderStatus(orderFeignResponse.getOrderUid(), "FAIL"); //Fail로 변경
                paymentRepository.delete(payment);

                // 결제금액 위변조로 의심되는 결제금액을 취소(아임포트)
                iamportClient.cancelPaymentByImpUid(new CancelData(iamportResponse.getResponse().getImpUid(), true, new BigDecimal(iamportPrice)));

                throw new RuntimeException("결제금액 위변조 의심");
            }
            //결제 성공 로직

            // 결제 상태 변경
//            order.getPayment().changePaymentBySuccess(PaymentStatus.OK, iamportResponse.getResponse().getImpUid());
            payment.changePaymentBySuccess(PaymentStatus.PAID, iamportResponse.getResponse().getImpUid());
            orderFeignClient.updateOrderStatus(orderFeignResponse.getOrderUid(), "SUCCESS"); //Success 변경
            MySoconFeignRequest mySoconFeignRequest = MySoconFeignRequest.builder()
                    .purchaseAt(LocalDateTime.now())
                    .expiredAt(LocalDateTime.now().plusDays(30))
                    .usedAt(null)
                    .status("unused")
                    .memberId(orderFeignResponse.getMemberId())
                    .issueId(orderFeignResponse.getIssueId())
                    .build();

            soconFeignClient.saveMySocon(mySoconFeignRequest); //feign을 통해 사용자의 쿠폰북에 저장

            return iamportResponse;


        } catch (IamportResponseException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

//    public void chargePoint(int amount, Member member) {
//
//    }
}
