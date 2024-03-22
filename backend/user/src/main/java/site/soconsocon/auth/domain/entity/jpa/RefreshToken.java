package site.soconsocon.auth.domain.entity.jpa;

import lombok.Builder;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.TimeToLive;

@Getter
@Builder
@RedisHash(value = "refreshToken")
public class RefreshToken {
    @Id
    private int memberId;

    private String refreshToken;

    public RefreshToken(int memberId, String refreshToken) {
        this.memberId = memberId;
        this.refreshToken = refreshToken;
    }
}
