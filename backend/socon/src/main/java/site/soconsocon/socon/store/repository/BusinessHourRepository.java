package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import site.soconsocon.socon.store.domain.entity.jpa.BusinessHour;

import java.util.List;

public interface BusinessHourRepository extends JpaRepository<BusinessHour, Integer> {

    List<BusinessHour> findByStoreId(Integer storeId);


}
