package site.soconsocon.socon.sogon.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import site.soconsocon.socon.sogon.domain.entity.jpa.Comment;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

    @Query("select c from COMMENT c where c.sogon.id = :sogonId")
    List<Comment> findAllBySogonId(Integer sogonId);
}
