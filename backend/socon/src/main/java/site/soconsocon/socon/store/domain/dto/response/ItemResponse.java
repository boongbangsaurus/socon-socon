package site.soconsocon.socon.store.domain.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
public class ItemResponse {

    private Integer id;
    private String name;
    private String image;
    private Integer price;
    private String summary;
    private String description;


}
