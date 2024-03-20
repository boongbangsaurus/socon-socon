package site.soconsocon.socon.store.domain.entity.jpa;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity(name="ORDER")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id", updatable = false, nullable = false)
    private Integer id;

    @Column(name = "price", nullable = false)
    private Integer price;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    @Column(name = "order_uid", nullable = true)
    private String orderUid;

    @Column(name = "order_status", nullable = true)
    private String orderStatus;

    @Column(name = "order_time", nullable = false)
    private LocalDateTime orderTime;

    @Column(name = "member_id", nullable = false)
    private Integer memberId;

    }
