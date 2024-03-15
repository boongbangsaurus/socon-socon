package site.soconsocon.socon.store.domain.entity.jpa;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity(name="STORE")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class Store {

    @Id // id 필드를 기본키로 지정한다
    @GeneratedValue(strategy = GenerationType.IDENTITY) // 기본키를 자동으로 1씩 증가시킨다
    @Column(name = "store_id", updatable = false, nullable = false)
    private Integer id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "category", nullable = true)
    private String category; // 가게 분류

    @Column(name = "image", nullable = true)
    private String image; // 가게 대표 이미지

    @Column(name = "phone_number", nullable = true)
    private String phoneNumber; // 가게 전화번호

    @Column(name = "address", nullable = false)
    private String address; // 가게 주소

    @Column(name = "lat", nullable = false)
    private Double lat; // 위도

    @Column(name = "lng", nullable = false)
    private Double lng; // 경도

    @Column(name = "introduction", nullable = true)
    private String introduction; // 가게 설명

    @Column(name = "closing_planned", nullable = true)
    private LocalDateTime closingPlanned; // 폐업 예정 일자

    @Column(name = "is_closed", nullable = false, columnDefinition = "boolean default false")
    private Boolean isClosed; // 폐업 여부

    @Column(name = "createdAt", nullable = false)
    private LocalDateTime createdAt; // 등록일

    @Column(name = "member_id", nullable = false)
    private Integer memberId; // 멤버 id

    @ManyToOne
    @JoinColumn(name = "registration_number_id")
    private RegistrationNumber registrationNumber;

    @OneToMany(mappedBy = "store")
    private List<BusinessHour> businessHours = new ArrayList<>();


    public Store
            (String name, String category, String image, String phoneNumber, String address,
             Double lat, Double lng, String introduction, LocalDateTime closingPlanned, Boolean isClosed,
             LocalDateTime createdAt, RegistrationNumber registrationNumber, List<BusinessHour> businessHours) {

        this.name = name;
        this.category = category;
        this.image = image;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.lat = lat;
        this.lng = lng;
        this.introduction = introduction;
        this.closingPlanned = closingPlanned;
        this.isClosed = isClosed;
        this.createdAt = createdAt;
        this.registrationNumber = registrationNumber;
        this.businessHours = businessHours;
             }
}

