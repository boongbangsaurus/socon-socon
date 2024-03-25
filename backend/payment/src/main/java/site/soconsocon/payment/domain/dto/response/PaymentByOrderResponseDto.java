package site.soconsocon.payment.domain.dto.response;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PaymentByOrderResponseDto {

    private int id;

    private String paymentUid;

    private int price;

    private String orderUid;

    private String itemName;


}
