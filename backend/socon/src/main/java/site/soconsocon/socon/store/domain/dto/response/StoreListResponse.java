package site.soconsocon.socon.store.domain.dto.response;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class StoreListResponse {

    private Integer id;
    private String name;
    private String category;
    private String image;
    private LocalDate createdAt;

}
