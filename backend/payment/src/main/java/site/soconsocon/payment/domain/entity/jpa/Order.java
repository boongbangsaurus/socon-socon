package site.soconsocon.payment.domain.entity.jpa;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class Order {

    private int id;

    private String orderUid; //주문 고유번호

    private String name;

    private String orderStatus;

    private LocalDateTime orderTime; //주문 시간

    private int memberId; //회원 아이디

    private int issueId; // 발행 아이디

}
