package site.soconsocon.socon.store.domain.entity.jpa;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity(name="FAV_STORE")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id", nullable = false)
    private Integer id;

    @Column(name = "price")
    private Integer price;

    @Column(name = "name")
    private String name;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "order_uid")
    private String orderUid;

    @Column(name = "order_status")
    private String orderStatus;

    @Column(name = "order_time")
    private LocalDateTime orderTime;

    @Column(name = "member_id")
    private Integer memberId;


}
