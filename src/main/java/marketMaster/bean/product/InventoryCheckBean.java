package marketMaster.bean.product;

import java.time.LocalDate;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import marketMaster.bean.employee.EmpBean;

@Entity
@Table(name = "inventory_check")
public class InventoryCheckBean {

	@Id
	@Column(name = "inventory_check_id")
	private String inventoryCheckId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "employee_id")
	private EmpBean employee;

	@Column(name = "inventory_check_date")
	private LocalDate inventoryCheckDate;

	@Column(name = "verify_status")
	private boolean verifyStatus;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "verify_employee_id")
	private EmpBean verifyEmployee;

	@OneToMany(mappedBy = "inventoryCheck", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JsonManagedReference
	private List<InventoryCheckDetailsBean> details;

	public InventoryCheckBean(String inventoryCheckId, EmpBean employee, LocalDate inventoryCheckDate,
			boolean verifyStatus, EmpBean verifyEmployee, List<InventoryCheckDetailsBean> details) {
		super();
		this.inventoryCheckId = inventoryCheckId;
		this.employee = employee;
		this.inventoryCheckDate = inventoryCheckDate;
		this.verifyStatus = verifyStatus;
		this.verifyEmployee = verifyEmployee;
		this.details = details;
	}

	public InventoryCheckBean() {
		super();
	}

	public boolean isVerifyStatus() {
		return verifyStatus;
	}

	public void setVerifyStatus(boolean verifyStatus) {
		this.verifyStatus = verifyStatus;
	}

	public EmpBean getVerifyEmployee() {
		return verifyEmployee;
	}

	public void setVerifyEmployee(EmpBean verifyEmployee) {
		this.verifyEmployee = verifyEmployee;
	}

	public String getInventoryCheckId() {
		return inventoryCheckId;
	}

	public void setInventoryCheckId(String inventoryCheckId) {
		this.inventoryCheckId = inventoryCheckId;
	}

	public EmpBean getEmployee() {
		return employee;
	}

	public void setEmployee(EmpBean employee) {
		this.employee = employee;
	}

	public LocalDate getInventoryCheckDate() {
		return inventoryCheckDate;
	}

	public void setInventoryCheckDate(LocalDate inventoryCheckDate) {
		this.inventoryCheckDate = inventoryCheckDate;
	}

	public List<InventoryCheckDetailsBean> getDetails() {
		return details;
	}

	public void setDetails(List<InventoryCheckDetailsBean> details) {
		this.details = details;
	}

}
