package site.soconsocon.socon.store.domain.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class ChargeRequest {

    @JsonProperty("member_id")
    private int memberId;

    private int money;
}
