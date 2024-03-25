package site.soconsocon.socon.store.domain.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class UnusableSoconListResponse {

    private Integer soconId;
    private String itemName;
    private String storeName;
    private LocalDateTime expiredAt;
    private Boolean isUsed;
    private LocalDateTime usedAt;
    private String itemImage;
}
