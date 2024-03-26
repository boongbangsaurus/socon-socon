package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import site.soconsocon.socon.store.domain.entity.jpa.RegistrationNumber;

public interface RegistrationNumberRepository extends JpaRepository<RegistrationNumber, Integer> {


}
