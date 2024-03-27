package site.soconsocon.config;

import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Base64;

@Component
public class PrivateKeyConfig {

    @Value("${SPRING_CLOUD_CONFIG_SERVER_GIT_PRIVATE_KEY}")
    private String encodedKey;

    private String decodedKey;

    @PostConstruct
    public void init() {
        decodedKey = new String(Base64.getDecoder().decode(encodedKey));
        // 이제 decodedKey를 사용하여 필요한 설정을 할 수 있습니다.
    }
}