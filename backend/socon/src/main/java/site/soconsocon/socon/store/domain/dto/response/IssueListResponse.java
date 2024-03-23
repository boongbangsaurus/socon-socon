package site.soconsocon.socon.store.domain.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class IssueListResponse {

    private Integer issueId;
    private String name;
    private String image;
    private Boolean isMain;
    private Integer maxQuantity;
    private Integer issuedQuantity;
    private Integer price;
    private Boolean isDiscounted;
    private Integer discountedPrice;
    private LocalDateTime createdAt;
}
