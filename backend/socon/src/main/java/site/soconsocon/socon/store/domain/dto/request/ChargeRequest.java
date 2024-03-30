package site.soconsocon.socon.store.domain.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChargeRequest {

    private int memberId;
    private int money;
}
