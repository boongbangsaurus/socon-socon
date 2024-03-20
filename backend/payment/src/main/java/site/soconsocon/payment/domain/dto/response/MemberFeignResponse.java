package site.soconsocon.payment.domain.dto.response;

import lombok.Data;

@Data
public class MemberFeignResponse {

    private int memberId;

    private String email;

    private String nickname;

    private int soconMoney;

    private String soconPassword;

}
