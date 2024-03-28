package site.soconsocon.payment.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import site.soconsocon.payment.domain.entity.jpa.Order;
import site.soconsocon.payment.domain.entity.jpa.Payment;

import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {

    @Query("select o from Order o left join fetch Payment p on p.id = o.paymentId where o.orderUid = :orderUid")
    Optional<Order> findOrderAndPayment(String orderUid);

    @Query("update Order o set o.orderStatus = :orderStatus where o.orderUid = :orderUid")
    void updateOrderStatus(String orderUid, String orderStatus);
}
