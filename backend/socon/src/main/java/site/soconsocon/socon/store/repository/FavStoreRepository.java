package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import site.soconsocon.socon.store.domain.entity.jpa.FavStore;

import java.util.List;

public interface FavStoreRepository extends JpaRepository<FavStore, Integer> {

    @Query("SELECT COUNT(*) FROM FAV_STORE s WHERE s.storeId = :store_id")
    Integer countByStoreId(Integer storeId);


    @Query("SELECT s FROM FAV_STORE s WHERE s.memberId = :member_id AND s.storeId = :store_id")
    FavStore findByMemberIdAndStoreId(Integer memberId, Integer storeId);


    @Query("SELECT s FROM FAV_STORE s WHERE s.memberId = :member_id")
    List<FavStore> findByMemberId(Integer memberId);
}
