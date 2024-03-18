package site.soconsocon.socon.store.domain.entity.jpa;

import jakarta.persistence.*;
import lombok.*;

@Entity(name="ITEM")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
@ToString
public class Item {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "item_id", updatable = false, nullable = false)
    private Integer id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "image", nullable = true)
    private String image;

    @Column(name = "price", nullable = false)
    private Integer price;

    @Column(name = "summary", nullable = true)
    private String summary;

    @Column(name = "description", nullable = true)
    private String description;

    @ManyToOne
    @JoinColumn(name = "store_id")
    private Store store;

}
