package site.soconsocon.socon.store.domain.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
public class UpdateStoreInfoRequest {

    private String image;
    private String phoneNumber;
    private String address;
    private Double lat;
    private Double lng;
    private String introduction;
    private List<BusinessHourRequest> businessHours;

}
