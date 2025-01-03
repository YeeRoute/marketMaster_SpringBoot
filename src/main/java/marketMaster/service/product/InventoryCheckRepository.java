package marketMaster.service.product;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import marketMaster.bean.product.InventoryCheckBean;

@Repository
public interface InventoryCheckRepository extends JpaRepository<InventoryCheckBean, String> {
	
	@Query("SELECT MAX(ic.inventoryCheckId) FROM InventoryCheckBean ic")
	String findMaxId();
	
//	@Query("SELECT EXISTS(SELECT 1 FROM InventoryCheckBean ic WHERE ic.details.product.productId = :productId AND ic.verifyStatus = :verifyStatus)")
//	boolean findVerifyByProductId(@Param("productId") String productId ,@Param("verifyStatus") boolean verifyStatus);
}
