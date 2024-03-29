package site.soconsocon.socon.store.domain.dto.request;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Time;
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class BusinessHourRequest {

    private String day;
    private Boolean isWorking;
    private Time openAt;
    private Time closeAt;
    private Boolean isBreaktime;
    private Time breaktimeStart;
    private Time breaktimeEnd;


}
