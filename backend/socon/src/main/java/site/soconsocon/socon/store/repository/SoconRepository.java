package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import site.soconsocon.socon.store.domain.entity.jpa.Socon;

import java.util.List;

public interface SoconRepository extends JpaRepository<Socon, Integer> {

    @Query("SELECT s FROM SOCON s WHERE s.memberId = :memberId AND (s.status = 'unused' OR s.status = 'sogon') ORDER BY s.expiredAt ASC")
    List<Socon> getUnusedSoconByMemberId(Integer memberId);

    @Query("SELECT s FROM SOCON s WHERE s.memberId = :memberId AND (s.status = 'used' OR s.status = 'expired') ORDER BY FUNCTION('TIMEDIFF', CURRENT_TIMESTAMP, s.usedAt) ASC")
    List<Socon> getUsedSoconByMemberId(Integer memberId);

    @Query("SELECT s FROM SOCON s WHERE s.memberId = :memberId AND s.issue.storeName = :storeName AND s.status = 'unused' ORDER BY FUNCTION('TIMEDIFF', CURRENT_TIMESTAMP, s.expiredAt) ASC")
    List<Socon> getSoconByMemberIdAndStoreName(Integer memberId, String storeName);

    @Query("SELECT s FROM SOCON s WHERE s.memberId = :memberId AND s.issue.item.name = :itemName AND s.status = 'unused' ORDER BY FUNCTION('TIMEDIFF', CURRENT_TIMESTAMP, s.expiredAt) ASC")
    List<Socon> getSoconByMemberIdAndItemName(Integer memberId, String itemName);

    @Query("SELECT s FROM SOCON s WHERE s.id = :issueId AND (s.status = 'unused' OR s.status = 'sogon')")
    List<Socon> getUnusedSoconByIssueId(Integer issueId);
    @Query("SELECT s FROM SOCON s WHERE s.issue.item.store.id = :storeId AND s.status IN ('unused', 'sogon')")
    List<Socon> getSoconByStoreId(Integer storeId);
}
