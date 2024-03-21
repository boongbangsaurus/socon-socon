package site.soconsocon.socon.store.domain.dto.response;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import site.soconsocon.socon.store.domain.entity.jpa.BusinessHour;

import java.time.LocalDateTime;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class StoreListResponse {

    private Integer id;
    private String name;
    private String category;
    private String image;
    private LocalDateTime createdAt;

}
