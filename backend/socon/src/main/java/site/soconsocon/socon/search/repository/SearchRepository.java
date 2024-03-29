package site.soconsocon.socon.search.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import site.soconsocon.socon.store.domain.entity.jpa.Store;

public interface SearchRepository extends JpaRepository<Store, Integer>, SearchCustomRepository {
}
