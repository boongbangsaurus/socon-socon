package site.soconsocon.socon.store.domain.entity.feign;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class Member {

        private String email;
        private String nickname;
        private String name;
        private String profileUrl;
        private String phoneNumber;

}
