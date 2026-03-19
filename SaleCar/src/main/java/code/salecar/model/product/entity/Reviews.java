package code.salecar.model.product.entity;

import java.util.Date;

public class Reviews {
    private int id;
    private int userId;
    private int productId;
    private int rating;
    private String comment;
    private Date CreateAt;
    private Date UpdateAt;
    private String userName;
    private String avatar = null;



    public Reviews(int id, int userId, int productId, String comment, Date createAt, Date updateAt) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.comment = comment;
        CreateAt = createAt;
        UpdateAt = updateAt;
    }

    public Reviews() {
    }

    public Reviews(int userId, int rating, String comment, Date createAt) {
        this.userId = userId;
        this.rating = rating;
        this.comment = comment;
        CreateAt = createAt;
    }


    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
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

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getCreateAt() {
        return CreateAt;
    }

    public void setCreateAt(Date createAt) {
        CreateAt = createAt;
    }

    public Date getUpdateAt() {
        return UpdateAt;
    }

    public void setUpdateAt(Date updateAt) {
        UpdateAt = updateAt;
    }
}
