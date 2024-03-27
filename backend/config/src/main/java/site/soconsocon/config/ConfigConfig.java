package site.soconsocon.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ConfigConfig {

    @Value("${spring.cloud.config.server.git.private-key}")
    private String configPrivateKey;

    public String getPrivateKey() {
        // "\n" 문자열을 실제 줄바꿈으로 변환
        return configPrivateKey.replace("\\n", "\n");
    }
}
