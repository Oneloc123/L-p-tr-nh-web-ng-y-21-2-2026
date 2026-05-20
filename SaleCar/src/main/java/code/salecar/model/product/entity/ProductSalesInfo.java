package code.salecar.model.product.entity;

public class ProductSalesInfo {
    private int quantity;
    private int soldQuantity;

    public ProductSalesInfo() { }
    public ProductSalesInfo(int quantity, int soldQuantity) {
        this.quantity = quantity;
        this.soldQuantity = soldQuantity;
    }

    public int getQuantity() {
        return quantity;
    }
    public int getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(int soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
