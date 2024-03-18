package site.soconsocon.socon.store.domain.entity.jpa;

import jakarta.persistence.*;
import lombok.*;
import org.aspectj.bridge.MessageUtil;

import java.sql.Time;


@Entity(name="BUSINESS_HOUR")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@ToString
public class BusinessHour {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "business_hour_id", updatable = false, nullable = false)
    private Integer id;

    @Column(name = "day", nullable = false, unique = true)
    private String day;

    @Column(name = "is_working", nullable = false, columnDefinition = "boolean default false")
    private Boolean isWorking;

    @Column(name = "open_at", nullable = true)
    private Time openAt;

    @Column(name = "close_at", nullable = true)
    private Time closeAt;

    @Column(name = "breaktime_start", nullable = true)
    private Time breaktimeStart;

    @Column(name = "breaktime_end", nullable = true)
    private Time breaktimeEnd;

    @Column(name = "store_id", nullable = false)
    private Integer storeId;
}