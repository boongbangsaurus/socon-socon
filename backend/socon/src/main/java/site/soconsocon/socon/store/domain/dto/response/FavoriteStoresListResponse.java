package site.soconsocon.socon.store.domain.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class FavoriteStoresListResponse {

    private Integer storeId;
    private String name;
    private String image;
    private String mainMenu;

}
