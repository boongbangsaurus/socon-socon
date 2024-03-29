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
public class SogonResponse {

    private Integer id;
    private String title;
    private String memberName;
    private String memberImg;
    private String content;
    private String image1;
    private String image2;
    private String soconImg;
    private LocalDateTime createdAt;
    private LocalDateTime expiredAt;
    private boolean isExpired;
}
