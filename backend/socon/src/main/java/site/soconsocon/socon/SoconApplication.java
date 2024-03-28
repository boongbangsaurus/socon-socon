package site.soconsocon.socon;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
@EnableJpaRepositories(basePackages = {"site.soconsocon.socon.store.repository", "site.soconsocon.socon.sogon.repository"})
@EntityScan("site.soconsocon.socon")
@EnableDiscoveryClient
@EnableFeignClients
public class SoconApplication {

	public static void main(String[] args) {
		SpringApplication.run(SoconApplication.class, args);
	}

}
