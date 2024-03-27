package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import site.soconsocon.socon.store.domain.dto.response.BusinessHourResponse;
import site.soconsocon.socon.store.domain.entity.jpa.Store;

import java.util.List;

public interface StoreRepository extends JpaRepository<Store, Integer> {
    @Query("SELECT s.id, s.name, s.category, s.image, s.createdAt FROM STORE s WHERE s.memberId = :memberId")
    List<Store> findStoresByMemberId(Integer memberId);

    @Query("SELECT s.name FROM STORE s WHERE s.id = :storeId")
    String findNameByStoreId(Integer storeId);

    @Query("SELECT s.memberId FROM STORE s WHERE s.id = :storeId")
    Integer findMemberIdByStoreId(Integer storeId);

    @Query("SELECT COUNT(s) FROM STORE s WHERE s.name = :name AND s.registrationNumber.id = :registrationNumberId AND s.lat = :lat AND s.lng = :lng")
    Integer checkStoreDuplication(String name, Integer registrationNumberId, Double lat, Double lng);


    @Query("SELECT s FROM STORE s WHERE s.closingPlanned != null AND s.isClosed = false")
    List<Store> storesScheduledToClose();

}

