package site.soconsocon.socon.sogon.feign.domain.dto.feign;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * private Integer memberId;
 * private String token;
 * private String deviceType;
 */
@Data
@AllArgsConstructor
public class SaveTokenRequest {
    private Integer memberId;
    private String token;
    private String deviceType;
}
