package site.soconsocon.payment.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import site.soconsocon.payment.domain.entity.jpa.Order;
import site.soconsocon.payment.domain.entity.jpa.Payment;

import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {

    @Query("select o from Order o where o.orderUid = :orderUid")
    Optional<Order> findOrderByOrderUid(@Param("orderUid") String orderUid);

    Optional<Order> findOrderByImpUid(@Param("impUid") String impUid);

    @Query("update Order o set o.orderStatus = :orderStatus where o.orderUid = :orderUid")
    void updateOrderStatus(String orderUid, String orderStatus);

}
