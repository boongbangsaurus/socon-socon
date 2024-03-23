package site.soconsocon.auth.repository;

import io.lettuce.core.dynamic.annotation.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import site.soconsocon.auth.domain.entity.jpa.Member;

import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Integer> {

    Optional<Member> findMemberById(int memberId); //이메일로 유저찾기

    Optional<Member> findMemberByEmail(String email); //이메일로 유저찾기

    @Query("select m from Member m where m.nickname = :nickname")
    Optional<Member> findMemberByNickname(String nickname); //닉네임으로 유저찾기

    @Query("select m from Member m where m.nickname = :nickname")
    int findByNickname(@Param("nickname") String nickname);



}
