package site.soconsocon.socon.sogon.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import site.soconsocon.socon.sogon.domain.entity.jpa.Sogon;

import java.util.List;

public interface SogonRepository extends JpaRepository<Sogon, Integer> {

    @Query("select count(s) from SOGON s where s.socon.id = :soconId")
    Integer countBySoconId(Integer soconId);

    @Query("select s from SOGON s where s.memberId = :memberId")
    List<Sogon> findAllByMemberId(Integer memberId);


    List<Sogon> findByLatBetweenAndLngBetween(double minLatitude, double maxLatitude, double minLongitude, double maxLongitude);
}
