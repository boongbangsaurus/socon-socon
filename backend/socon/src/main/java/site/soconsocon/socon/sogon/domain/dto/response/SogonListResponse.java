package site.soconsocon.socon.sogon.domain.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class SogonListResponse {

    private String title;
    private String soconImg;
    private LocalDateTime createdAt;
    private Boolean isExpired;
    private boolean isPicked;

}
