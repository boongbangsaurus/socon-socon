package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import site.soconsocon.socon.store.domain.entity.jpa.MySocon;

public interface MySoconRepository extends JpaRepository<MySocon, Integer> {
}
