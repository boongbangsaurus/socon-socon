package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import site.soconsocon.socon.store.domain.dto.response.BusinessHourResponse;
import site.soconsocon.socon.store.domain.entity.jpa.BusinessHour;

import java.util.List;

public interface BusinessHourRepository extends JpaRepository<BusinessHour, Integer> {

    @Query("SELECT b.day, b.isWorking, b.openAt, b.closeAt, b.isBreaktime, b.breaktimeStart, b.breaktimeEnd FROM BUSINESS_HOUR b WHERE b.store.id = :storeId")
    List<BusinessHourResponse> findBusinessHourResponseByStoreId(Integer storeId);


    List<BusinessHour> findByStoreId(Integer storeId);
}
