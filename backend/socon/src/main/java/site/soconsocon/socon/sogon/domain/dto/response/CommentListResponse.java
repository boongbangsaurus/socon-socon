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
public class CommentListResponse {

    private String title;
    private String content;
    private LocalDateTime createdAt;
    private Boolean isPicked;
}
