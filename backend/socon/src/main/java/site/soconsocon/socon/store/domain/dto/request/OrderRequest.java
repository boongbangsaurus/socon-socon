package site.soconsocon.socon.store.domain.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
public class OrderRequest {

    private Integer orderQuantity;
    private Integer price;

}
