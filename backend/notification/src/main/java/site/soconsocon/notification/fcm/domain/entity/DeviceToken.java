package site.soconsocon.notification.fcm.domain.entity;

import jakarta.persistence.*;
import lombok.*;
import site.soconsocon.notification.fcm.domain.dto.request.Member;

/**
 * 사용자에게 Firebase Cloud Message 알람을 송신하기 위한 엔티티
 * id(int)- 12
 */
@Entity
@Getter @Setter
@Table(name="device_token", indexes = @Index(columnList="memberId"))
@ToString(of = {})
public class DeviceToken {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "device_id", nullable = false)
    private Integer Id;

    @Column(name = "member_id", nullable = false)
    private Integer memberId;

    @Transient
    private Member member;

    @Enumerated(EnumType.STRING)
    private DeviceType deviceType;

    @Column(name = "device_token",nullable = true, length = 256, unique = true)
    private String deviceToken;

}
