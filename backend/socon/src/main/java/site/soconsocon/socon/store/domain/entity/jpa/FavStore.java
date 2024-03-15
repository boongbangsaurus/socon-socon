package site.soconsocon.socon.store.domain.entity.jpa;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity(name="FAV_STORE")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class FavStore {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "favorite_id", nullable = false)
    private Integer id;

    @Column(name = "member_id", nullable = false)
    private Integer memberId; // 멤버 id

    @JoinColumn(name = "store_id")
    private Integer storeId;

}