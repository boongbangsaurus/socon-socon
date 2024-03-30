package site.soconsocon.socon.store.domain.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
public class AddItemRequest {

    private String name;
    private String image;
    private String summary;
    private Integer price;
    private String description;

}
