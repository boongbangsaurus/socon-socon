package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import site.soconsocon.socon.store.domain.entity.jpa.Store;

import java.util.List;

public interface StoreRepository extends JpaRepository<Store, Integer> {
    @Query("SELECT s.id, s.name, s.category, s.image, s.createdAt FROM STORE s WHERE s.memberId = :memberId")
    List<Store> findStoresByMemberId(Integer memberId);

    @Query("SELECT s.memberId FROM STORE s WHERE s.id = :storeId")
    Integer findMemberIdByStoreId(Integer storeId);

}

