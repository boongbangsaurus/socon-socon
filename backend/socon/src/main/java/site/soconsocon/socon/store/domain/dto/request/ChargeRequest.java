package site.soconsocon.socon.store.domain.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class ChargeRequest {

    private int memberId;
    private int money;
}
