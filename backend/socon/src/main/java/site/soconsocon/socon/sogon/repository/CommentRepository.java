package site.soconsocon.socon.sogon.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import site.soconsocon.socon.sogon.domain.entity.jpa.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

}
