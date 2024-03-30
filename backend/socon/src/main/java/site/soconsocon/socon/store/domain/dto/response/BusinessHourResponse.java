package site.soconsocon.socon.store.domain.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Time;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class BusinessHourResponse {

    private String day;
    private Boolean isWorking;
    private Time openAt;
    private Time closeAt;
    private Boolean isBreaktime;
    private Time breaktimeStart;
    private Time breaktimeEnd;

}
