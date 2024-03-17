package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import site.soconsocon.socon.store.domain.entity.jpa.Socon;

import java.util.List;

public interface SoconRepository extends JpaRepository<Socon, Integer> {

    @Query("SELECT s FROM SOCON s WHERE s.memberId = :memberId AND s.isUsed = false")
    List<Socon> getUnusedSoconByMemberId(Integer memberId);

    @Query("SELECT s FROM SOCON s WHERE s.memberId = :memberId AND s.isUsed = true")
    List<Socon> getUsedSoconByMemberId(Integer memberId);

}
