package site.soconsocon.socon.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import site.soconsocon.socon.store.domain.entity.jpa.Order;

public interface OrderRepository extends JpaRepository<Order, Integer> {
}
