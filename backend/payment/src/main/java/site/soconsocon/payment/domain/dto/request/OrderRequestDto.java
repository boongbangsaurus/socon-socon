package site.soconsocon.payment.domain.dto.request;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class OrderRequestDto {

    private String orderUid; //주문 고유번호

    private String name;

    private int price;

    private String orderStatus;

    private int memberId; //회원 아이디

    private int issueId; // 발행 아이디

}
