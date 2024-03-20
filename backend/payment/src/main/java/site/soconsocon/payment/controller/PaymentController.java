package site.soconsocon.payment.controller;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import site.soconsocon.payment.domain.dto.request.PaymentCallbackRequestDto;
import site.soconsocon.payment.service.PaymentService;

import java.io.IOException;

@RestController
@RequiredArgsConstructor
@RequestMapping("/payment-service")
@Log4j2
public class PaymentController {

    private final PaymentService paymentService;
    private IamportClient iamportClient;

    @PostMapping("/{orderId}/processPayment")
    public ResponseEntity<String> processPayment(@PathVariable int orderId) {
        // 주문 PK를 이용한 결제 처리 로직
        boolean paymentResult = paymentService.processPaymentForOrder(orderId);

        if (paymentResult) {
            return new ResponseEntity<>("Payment processed successfully for order " + orderId, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("Payment processing failed for order " + orderId, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    //Iamport로 결제 완료했을 때
    @PostMapping("/verifyIamport/{imp_uid}")
    public IamportResponse<Payment> paymentByImpUid(@PathVariable("imp_uid") String imp_uid) throws IamportResponseException, IOException {
        return iamportClient.paymentByImpUid(imp_uid);
    }

    @PostMapping("/payment")
    public ResponseEntity<IamportResponse<Payment>> validationPayment(@RequestBody PaymentCallbackRequestDto request) {
        IamportResponse<Payment> iamportResponse = paymentService.paymentByCallback(request);

        log.info("결제 응답: {}", iamportResponse.getResponse().toString());

        return new ResponseEntity<>(iamportResponse, HttpStatus.OK);
    }



}
