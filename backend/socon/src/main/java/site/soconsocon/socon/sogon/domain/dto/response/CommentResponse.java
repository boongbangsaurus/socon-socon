package site.soconsocon.socon.sogon.domain.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class CommentResponse {

    private Integer id;
    private String content;
    private String memberName;
    private String memberImg;
    private Boolean isPicked;

}
