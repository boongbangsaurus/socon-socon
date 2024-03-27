package site.soconsocon.payment.service.feign.request;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class AddMySoconRequest {

    private LocalDateTime purchaseAt; //구매 일시

    private LocalDateTime expiredAt; //만료 일시

    private LocalDateTime usedAt; //사용 일시

    private String status; //상태 (unused, sogon, used, expired)

    private int memberId; //회원 번호

    private int issueId; //발행 번호

    private int purchasedQuantity; //구매 수량

}
