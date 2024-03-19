package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import site.soconsocon.socon.store.domain.dto.response.IssueListResponse;
import site.soconsocon.socon.store.domain.entity.jpa.Issue;

import java.util.List;

public interface IssueRepository extends JpaRepository<Issue, Integer> {

    @Query("SELECT i.id, i.name, i.image, i.isMain, i.maxQuantity, i.issuedQuantity, i.price, i.isDiscounted, i.discountedPrice, i.createdAt FROM ISSUE i WHERE i.item.store.id = :storeId")
    List<IssueListResponse> findIssueListByStoreId(Integer storeId);

    @Query("SELECT i.name FROM ISSUE i WHERE i.item.store.id = :storeId AND i.isMain = true AND i.status = 'A' LIMIT 1")
    String findMainIssueNameByStoreId(Integer storeId);
}
