package code.salecar.model.product.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;

public class Discount implements Serializable {
    private int id;
    private String name;
    private DiscountValueType valueType;
    private BigDecimal value;
    private DiscountEntityType entityType;
    private int entityId;
    private Date startAt;
    private Date endAt;
    private Date createAt;
    private Date updateAt;

    private double percent;

    public Discount() {
    }

    public Discount(int id, String name, DiscountValueType valueType, BigDecimal value, DiscountEntityType entityType, int entityId, Date startAt, Date endAt, Date createAt, Date updateAt) {
        this.id = id;
        this.name = name;
        this.valueType = valueType;
        this.value = value;
        this.entityType = entityType;
        this.entityId = entityId;
        this.startAt = startAt;
        this.endAt = endAt;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }

    public enum DiscountValueType {
        RATE,
        AMOUNT
    }

    public enum DiscountEntityType {
        CATEGORY,
        PRODUCT,
        BRAND
    }

    public double getPercent() {
        return percent;
    }

    public void setPercent(double percent) {
        this.percent = percent;
    }

    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public DiscountValueType getValueType() {
        return valueType;
    }

    public void setValueType(DiscountValueType valueType) {
        this.valueType = valueType;
    }

    public BigDecimal getValue() {
        return value;
    }

    public void setValue(BigDecimal value) {
        this.value = value;
    }

    public DiscountEntityType getEntityType() {
        return entityType;
    }

    public void setEntityType(DiscountEntityType entityType) {
        this.entityType = entityType;
    }

    public int getEntityId() {
        return entityId;
    }

    public void setEntityId(int entityId) {
        this.entityId = entityId;
    }

    public Date getEndAt() {
        return endAt;
    }

    public void setEndAt(Date endAt) {
        this.endAt = endAt;
    }

    public Date getStartAt() {
        return startAt;
    }

    public void setStartAt(Date startAt) {
        this.startAt = startAt;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }
}
