package site.soconsocon.socon.store.domain.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class SoconInfoResponse {

    private String itemName;
    private String storeName;
    private LocalDateTime purchasedAt;
    private LocalDateTime expiredAt;
    private String status;
    private String description;
    private String image;

}
