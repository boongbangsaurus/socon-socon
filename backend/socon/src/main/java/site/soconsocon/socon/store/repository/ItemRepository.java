package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import site.soconsocon.socon.store.domain.dto.response.ItemListResponse;
import site.soconsocon.socon.store.domain.entity.jpa.Item;

import java.util.List;

public interface ItemRepository extends JpaRepository<Item, Integer> {

    @Query("SELECT i.id, i.name, i.image, i.price FROM ITEM i WHERE i.store.id = :storeId")
    List<ItemListResponse> findItemsByStoreId(Integer storeId);

    @Query("SELECT i.store.memberId FROM ITEM i WHERE i.id = :itemId")
    Integer findMemberIdByItemId(Integer itemId);
}
