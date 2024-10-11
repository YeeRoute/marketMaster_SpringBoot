package marketMaster.service.restock;

import marketMaster.DTO.restock.PaymentDTO.PaymentInsertDTO;
import marketMaster.DTO.restock.PaymentDTO.PaymentRecordInsertDTO;
import marketMaster.DTO.restock.PaymentDTO.RestockDetailPaymentDTO;
import marketMaster.bean.restock.PaymentRecordsBean;
import marketMaster.bean.restock.PaymentsBean;
import marketMaster.bean.restock.RestockDetailsBean;
import marketMaster.bean.restock.SupplierAccountsBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
@Service
public class PaymentService {
    @Autowired
    private PaymentsRepository paymentsRepository;

    @Autowired
    private PaymentRecordsRepository paymentRecordsRepository;

    @Autowired
    private SupplierAccountsRepository supplierAccountsRepository;

    @Autowired
    private RestockDetailsRepository restockDetailsRepository;
    //找所有有關於SupplierId的進貨明細
    public List<RestockDetailPaymentDTO> getPaymentDetailsBySupplierId(String supplierId) {
        List<RestockDetailsBean> restockDetails = restockDetailsRepository.findBySupplierId(supplierId);
        List<RestockDetailPaymentDTO> restockDetailPaymentDTOS = new ArrayList<>();
        for (RestockDetailsBean details : restockDetails) {
            RestockDetailPaymentDTO dto = new RestockDetailPaymentDTO();
            dto.setDetailId(details.getDetailId());
            dto.setSupplierProductId(details.getSupplierProduct().getSupplierProductId());
            dto.setNumberOfRestock(details.getNumberOfRestock());
            dto.setPriceAtRestock(details.getPriceAtRestock());
            dto.setRestockTotalPrice(details.getRestockTotalPrice());

            // 檢查是否為 null
            Integer paidAmount = paymentRecordsRepository.sumPaymentAmountByDetailId(details.getDetailId());
            dto.setPaidAmount(paidAmount != null ? paidAmount : 0);  // 如果為 null，則設置為 0

            restockDetailPaymentDTOS.add(dto);
        }
        return restockDetailPaymentDTOS;
    }

    //跟插入多筆付款資訊
    @Transactional
    public void insertPayment(PaymentInsertDTO paymentInsertDTO, String supplierId) {
        // 使用 supplierId 查找 accountId
        String accountId = supplierAccountsRepository.findAccountIdBySupplierId(supplierId);
        paymentInsertDTO.setAccountId(accountId);

        // 創建並保存 Payment 實體
        PaymentsBean payment = new PaymentsBean();
        String newPaymentId = generatePaymentId();
        payment.setPaymentId(newPaymentId);

        // 設置 SupplierAccount
        SupplierAccountsBean account = supplierAccountsRepository.findById(paymentInsertDTO.getAccountId())
                .orElseThrow(() -> new RuntimeException("Supplier Account not found"));
        payment.setSupplierAccounts(account);

        payment.setPaymentDate(LocalDate.now()); // 自動設置當前日期
        payment.setPaymentMethod(paymentInsertDTO.getPaymentMethod());
        payment.setPaymentStatus(paymentInsertDTO.getPaymentStatus());

        // 計算付款總金額
        int totalAmount = paymentInsertDTO.getPaymentRecords().stream()
                .mapToInt(PaymentRecordInsertDTO::getPaymentAmount)
                .sum();
        payment.setTotalAmount(totalAmount);

        // 保存 Payment
        paymentsRepository.save(payment);

        // 插入多筆付款記錄
        for (PaymentRecordInsertDTO recordDTO : paymentInsertDTO.getPaymentRecords()) {
            PaymentRecordsBean paymentRecords = new PaymentRecordsBean();
            String newPaymentRecordsId = generateRecordId();
            paymentRecords.setRecordId(newPaymentRecordsId);
            paymentRecords.setPayment(payment); // 關聯到 PaymentsBean

            // 設置其他 PaymentRecord 屬性
            RestockDetailsBean detail = restockDetailsRepository.findById(recordDTO.getDetailId())
                    .orElseThrow(() -> new RuntimeException("Restock Detail not found"));
            paymentRecords.setRestockDetails(detail);
            paymentRecords.setPaymentAmount(recordDTO.getPaymentAmount());

            // 保存 PaymentRecord
            paymentRecordsRepository.save(paymentRecords);
        }
    }





    private String generatePaymentId() {
        PaymentsBean payment = paymentsRepository.findTopByOrderByPaymentIdDesc();

        String lastId = payment != null ? payment.getPaymentId() : null;
        // 如果是第一次插入，生成初始 ID
        if (lastId == null) {
            return "PMT001";  // 第一次插入時從 PMT001 開始
        }

        // 提取數字部分並遞增
        int idNum = Integer.parseInt(lastId.substring(3)) + 1;
        return "PMT" + String.format("%03d", idNum);
    }

    private String generateRecordId() {
        // 從資料庫中獲取最新的 recordId，如果不存在則為 null
        PaymentRecordsBean records = paymentRecordsRepository.findTopByOrderByRecordIdDesc();
        String lastId = records != null ? records.getRecordId() : null;

        // 如果是第一次插入，生成初始 ID
        if (lastId == null) {
            return "REC001";  // 第一次插入時從 REC001 開始
        }

        // 提取數字部分並遞增
        int idNum = Integer.parseInt(lastId.substring(3)) + 1;
        return "REC" + String.format("%03d", idNum);
    }
}