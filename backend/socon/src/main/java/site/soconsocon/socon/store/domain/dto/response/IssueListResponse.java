package site.soconsocon.socon.store.domain.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class IssueListResponse {

    private Integer id;
    private Boolean isMain;
    private String name;
    private String image;
    private Integer issuedQuantity;
    private Integer leftQuantity;
    private Boolean isDiscounted;
    private Integer price;
    private Integer discountedPrice;
    private LocalDateTime createdAt;
}
