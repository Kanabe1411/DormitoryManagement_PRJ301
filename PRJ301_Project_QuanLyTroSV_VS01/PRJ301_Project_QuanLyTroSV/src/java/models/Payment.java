package models;
import java.sql.Date;

public class Payment {
    private int id;
    private Integer contractId;
    private String contractIdStr;
    private Date date;
    private double amount;
    private String status;
    private String paymentType;
    private String description;

    public Payment() {}
    public Payment(int id, String contractId, Date date, double amount, String status) {
        this.id = id;
        this.contractIdStr = contractId;
        this.contractId = (contractId != null && !contractId.isBlank()) ? Integer.parseInt(contractId) : null;
        this.date = date;
        this.amount = amount;
        this.status = status;
    }
    public Payment(int id, Integer contractId, String contractIdStr, Date date, double amount, String status, String paymentType, String description) {
        this.id = id;
        this.contractId = contractId;
        this.contractIdStr = contractIdStr != null ? contractIdStr : (contractId != null ? String.valueOf(contractId) : "");
        this.date = date;
        this.amount = amount;
        this.status = status;
        this.paymentType = paymentType;
        this.description = description;
    }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Integer getContractId() { return contractId; }
    public void setContractId(Integer contractId) { this.contractId = contractId; }
    public String getContractIdStr() { return contractIdStr != null ? contractIdStr : (contractId != null ? String.valueOf(contractId) : ""); }
    public void setContractIdStr(String s) { this.contractIdStr = s; }
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getPaymentType() { return paymentType; }
    public void setPaymentType(String paymentType) { this.paymentType = paymentType; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}