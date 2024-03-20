package site.soconsocon.socon.sogon.domain.entity;

import jakarta.persistence.*;
import lombok.*;
import site.soconsocon.socon.store.domain.entity.jpa.Socon;

import java.time.LocalDateTime;

@Entity(name="SOGON")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
@ToString
public class Sogon {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sogon_id", nullable = false)
    private Integer id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "content", nullable = false)
    private String content;

    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate;

    @Column(name = "is_expired", nullable = false, columnDefinition = "boolean default false")
    private LocalDateTime isExpired; // 만료 일시

    @Column(name = "is_picked", nullable = false, columnDefinition = "boolean default false")
    private Boolean isPicked; // 채택 소곤 여부

    @Column(name = "image1", nullable = true)
    private String image1; // 이미지 1

    @Column(name = "image2", nullable = true)
    private String image2; // 이미지 2

    @Column(name = "lat", nullable = false)
    private Double lat; // 위도

    @Column(name = "lng", nullable = false)
    private Double lng; // 경도

    @Column(name = "member_id", nullable = false)
    private Integer memberId; // 멤버 id

    @OneToOne
    @JoinColumn(name = "socon_id")
    private Socon socon;
}