package site.soconsocon.socon.store.domain.dto.response;

import lombok.*;
import site.soconsocon.socon.store.domain.entity.jpa.BusinessHour;

import java.time.LocalDateTime;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class StoreInfoResponse {

    private Integer storeId;
    private String name;
    private String category;
    private String image;
    private String address;
    private String phoneNumber;
    private List<BusinessHour> businessHours;
    private String introduction;
    private LocalDateTime closingPlanned;
    private Integer favoriteCount;
    private LocalDateTime createdAt;


    private String registrationNumber;
    private String registrationAddress;
    private String owner;


}
