package site.soconsocon.payment.domain.entity.jpa;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "payment_id")
    private Integer id;

    @Column(nullable = false)
    private int price; //결제 금액

    @Enumerated(EnumType.STRING)
    private PaymentStatus status; //결제 상태

    private String paymentUid; //결제 고유번호

    private int cancelPrice; //취소 금액

    private String orderUid; //주문 고유번호 id

    public void changePaymentBySuccess(PaymentStatus status, String paymentUid) {
        this.status = status;
        this.paymentUid = paymentUid;
    }

}
