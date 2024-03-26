package site.soconsocon.socon.sogon.domain.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class GetSogonListResponse {

    private Integer id;
    private String title;
    private Integer lastTime;
    private String memberName;
    private Integer commentCount;
    private String soconImg;
    private Boolean isPicked;
}
