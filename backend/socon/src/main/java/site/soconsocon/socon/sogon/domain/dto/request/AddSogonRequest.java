package site.soconsocon.socon.sogon.domain.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
public class AddSogonRequest {

    private String title;
    private String content;
    private String image1;
    private String image2;
    private Double lat;
    private Double lng;
    private Integer soconId;

}
