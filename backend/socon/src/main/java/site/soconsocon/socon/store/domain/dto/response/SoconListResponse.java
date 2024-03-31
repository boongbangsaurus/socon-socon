package site.soconsocon.socon.store.domain.dto.response;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.*;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class SoconListResponse {

    private Integer soconId;
    private String itemName;
    private String storeName;
    private LocalDateTime expiredAt;
    private String status;
    private String itemImage;
}
