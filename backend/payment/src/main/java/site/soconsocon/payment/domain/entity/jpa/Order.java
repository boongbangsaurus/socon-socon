package site.soconsocon.payment.domain.entity.jpa;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private int id;

    private String orderUid; //주문 고유번호

    private String name;

    private int price;

    private String orderStatus;

    private LocalDateTime orderTime; //주문 시간

    private int memberId; //회원 아이디

    private int issueId; // 발행 아이디

    private int paymentId; //주문 PK

}
