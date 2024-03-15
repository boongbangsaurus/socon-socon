package site.soconsocon.socon.store.domain.entity.jpa;

import java.time.LocalDateTime;
import jakarta.persistence.*;
import lombok.*;

@Entity(name = "MY_SOCON")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class MySocon {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "socon_id", updatable = false, nullable = false)
    private Integer id;

    @Column (name="purchased_at", nullable = false)
    private LocalDateTime purchasedAt;

    @Column (name="expired_at", nullable = false)
    private LocalDateTime expiredAt;

    @Column (name="used_at", nullable = true)
    private LocalDateTime usedAt;

    @Column (name="is_used", nullable = false, columnDefinition = "boolean default false")
    private Boolean isUsed;

    @Column(name = "member_id", nullable = false)
    private Integer memberId; // 멤버 id

    @ManyToOne
    @JoinColumn(name = "issue_id")
    private Issue issue;

}