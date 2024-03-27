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
@RequestMapping("/payments")
@Log4j2
public class PaymentController {

    private final PaymentService paymentService;
    private IamportClient iamportClient;

    /**
     * imp_uid(결제 고유 ID) 값을 받아 결제 상세 내역을 조회
     *
     * @param impUid
     * @return
     * @throws IamportResponseException
     * @throws IOException
     */
    @PostMapping("/validate/{impUid}")
    public ResponseEntity<IamportResponse<Payment>> validationPayment(@PathVariable String impUid) throws IamportResponseException, IOException {
        IamportResponse<Payment> iamportResponse = iamportClient.paymentByImpUid(impUid);

        log.info("결제 응답: {}", iamportResponse.getResponse().toString());
        log.info("결제 요청 응답. 결제 내역 - 주문 번호: {}", iamportResponse.getResponse().getMerchantUid());

        return new ResponseEntity<>(iamportResponse, HttpStatus.OK);
    }
}
