package code.salecar.model;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Date;
import java.util.Locale;

public class Voucher {
    private int id;
    private String code;
    private String valueType;      // percent / fixed
    private BigDecimal value;
    private BigDecimal maxDiscount;
    private BigDecimal minOrderValue;
    private int usageLimit;
    private int usedCount;
    private Date startAt;
    private Date endAt;
    private int status;
    private Date createdAt;

    private String discount;

    public Voucher() {
    }

    public Voucher(int id, String code, String valueType, BigDecimal value, BigDecimal maxDiscount, BigDecimal minOrderValue, int usageLimit, int usedCount, Date startAt, Date endAt, int status, Date createdAt) {
        this.id = id;
        this.code = code;
        this.valueType = valueType;
        this.value = value;
        this.maxDiscount = maxDiscount;
        this.minOrderValue = minOrderValue;
        this.usageLimit = usageLimit;
        this.usedCount = usedCount;
        this.startAt = startAt;
        this.endAt = endAt;
        this.status = status;
        this.createdAt = createdAt;
    }

    public String getDiscount() {
        if (valueType.equals("percent")) {
            return value + "%";
        } else {
            NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            String result = formatter.format(value);
            return result;
        }
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getValueType() {
        return valueType;
    }

    public void setValueType(String valueType) {
        this.valueType = valueType;
    }

    public BigDecimal getValue() {
        return value;
    }

    public void setValue(BigDecimal value) {
        this.value = value;
    }

    public BigDecimal getMaxDiscount() {
        return maxDiscount;
    }

    public void setMaxDiscount(BigDecimal maxDiscount) {
        this.maxDiscount = maxDiscount;
    }

    public BigDecimal getMinOrderValue() {
        return minOrderValue;
    }

    public void setMinOrderValue(BigDecimal minOrderValue) {
        this.minOrderValue = minOrderValue;
    }

    public int getUsageLimit() {
        return usageLimit;
    }

    public void setUsageLimit(int usageLimit) {
        this.usageLimit = usageLimit;
    }

    public int getUsedCount() {
        return usedCount;
    }

    public void setUsedCount(int usedCount) {
        this.usedCount = usedCount;
    }

    public Date getStartAt() {
        return startAt;
    }

    public void setStartAt(Date startAt) {
        this.startAt = startAt;
    }

    public Date getEndAt() {
        return endAt;
    }

    public void setEndAt(Date endAt) {
        this.endAt = endAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
