package site.soconsocon.payment.domain.dto.request;

import lombok.Data;

@Data
public class PaymentCallbackRequestDto {

    private String paymentUid; // 결제 고유 번호

    private String orderUid; // 주문 고유 번호
}
