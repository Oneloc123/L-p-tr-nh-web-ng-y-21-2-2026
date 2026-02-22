package code.salecar.model;

import java.sql.Date;

public class WishListItem {
    private int id;
    private int userId;
    private int productId;
    private Date CreateAt;

    public WishListItem(int id, int userId, int productId, Date createAt) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        CreateAt = createAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Date getCreateAt() {
        return CreateAt;
    }

    public void setCreateAt(Date createAt) {
        CreateAt = createAt;
    }
}
