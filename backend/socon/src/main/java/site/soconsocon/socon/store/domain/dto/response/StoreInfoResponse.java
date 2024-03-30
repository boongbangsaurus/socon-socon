package site.soconsocon.socon.store.domain.dto.response;

import lombok.*;

import java.time.LocalDate;
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
    private List<BusinessHourResponse> businessHours;
    private String introduction;
    private LocalDate closingPlanned;
    private Integer favoriteCount;
    private LocalDate createdAt;


    private String registrationNumber;
    private String registrationAddress;
    private String owner;


}
