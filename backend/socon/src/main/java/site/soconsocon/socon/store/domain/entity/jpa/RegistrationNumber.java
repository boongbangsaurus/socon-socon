package site.soconsocon.socon.store.domain.entity.jpa;

import com.fasterxml.jackson.databind.annotation.JsonNaming;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity(name="REGISTRATION_NUMBER")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class RegistrationNumber {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "registration_number_id", nullable = false)
    private Integer id;

    @Column(name = "registration_number", nullable = false)
    private String RegistrationNumber;

    @Column(name = "registration_adress", nullable = false)
    private String RegistrationAddress;

    @Column(name = "member_id", nullable = false)
    private Integer memberId; // 멤버 id

}
