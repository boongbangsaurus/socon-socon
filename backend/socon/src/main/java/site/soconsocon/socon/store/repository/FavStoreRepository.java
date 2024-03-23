package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import site.soconsocon.socon.store.domain.entity.jpa.FavStore;

public interface FavStoreRepository extends JpaRepository<FavStore, Integer> {

    @Query("SELECT COUNT(*) FROM fav_store s WHERE s.storeId = :store_id")
    Integer countByStoreId(Integer storeId);
}
