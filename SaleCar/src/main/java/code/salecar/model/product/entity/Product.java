package code.salecar.model.product.entity;

import code.salecar.model.enumeration.Status;

import java.time.LocalDateTime;

public class Product {
    private long id;
    private String name;
    private double price;
    private double finalPrice;
    private double discountPercent;
    private LocalDateTime discountUpdatedAt;
    private int brandId;
    private int categoryId;
    private String description;
    private String ratio;
    private String size;
    private String material;
    private String origin;
    private Status status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // 1. Constructor mặc định
    public Product() {
    }
    // 2. Constructor với tất cả tham số
    public Product(long id, String name, double price, double finalPrice,
                   double discountPercent, LocalDateTime discountUpdatedAt,
                   int brandId, int categoryId, String description, String ratio,
                   String size, String material, String origin, Status status,
                   LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.finalPrice = finalPrice;
        this.discountPercent = discountPercent;
        this.discountUpdatedAt = discountUpdatedAt;
        this.brandId = brandId;
        this.categoryId = categoryId;
        this.description = description;
        this.ratio = ratio;
        this.size = size;
        this.material = material;
        this.origin = origin;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    // 3. Constructor nhận Builder (private)
    private Product(Builder builder) {
        this.id = builder.id;
        this.name = builder.name;
        this.price = builder.price;
        this.finalPrice = builder.finalPrice;
        this.discountPercent = builder.discountPercent;
        this.discountUpdatedAt = builder.discountUpdatedAt;
        this.brandId = builder.brandId;
        this.categoryId = builder.categoryId;
        this.description = builder.description;
        this.ratio = builder.ratio;
        this.size = builder.size;
        this.material = builder.material;
        this.origin = builder.origin;
        this.status = builder.status;
        this.createdAt = builder.createdAt;
        this.updatedAt = builder.updatedAt;
    }

    // 4. Getter và Setter
    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public double getFinalPrice() {
        return finalPrice;
    }
    public void setFinalPrice(double finalPrice) {
        this.finalPrice = finalPrice;
    }
    public double getDiscountPercent() {
        return discountPercent;
    }
    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }
    public LocalDateTime getDiscountUpdatedAt() {
        return discountUpdatedAt;
    }
    public void setDiscountUpdatedAt(LocalDateTime discountUpdatedAt) {
        this.discountUpdatedAt = discountUpdatedAt;
    }
    public int getBrandId() {
        return brandId;
    }
    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }
    public int getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getRatio() {
        return ratio;
    }
    public void setRatio(String ratio) {
        this.ratio = ratio;
    }
    public String getSize() {
        return size;
    }
    public void setSize(String size) {
        this.size = size;
    }
    public String getMaterial() {
        return material;
    }
    public void setMaterial(String material) {
        this.material = material;
    }
    public String getOrigin() {
        return origin;
    }
    public void setOrigin(String origin) {
        this.origin = origin;
    }
    public Status getStatus() {
        return status;
    }
    public void setStatus(Status status) {
        this.status = status;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public static Builder builder() {
        return new Builder();
    }

    public static class Builder {
        private long id;
        private String name;
        private double price;
        private double finalPrice;
        private double discountPercent;
        private LocalDateTime discountUpdatedAt;
        private int brandId;
        private int categoryId;
        private String description;
        private String ratio;
        private String size;
        private String material;
        private String origin;
        private Status status;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;

        public Builder id(long id) {
            this.id = id;
            return this;
        }
        public Builder name(String name) {
            this.name = name;
            return this;
        }
        public Builder price(double price) {
            this.price = price;
            return this;
        }
        public Builder finalPrice(double finalPrice) {
            this.finalPrice = finalPrice;
            return this;
        }
        public Builder discountPercent(double discountPercent) {
            this.discountPercent = discountPercent;
            return this;
        }
        public Builder discountUpdatedAt(LocalDateTime discountUpdatedAt) {
            this.discountUpdatedAt = discountUpdatedAt;
            return this;
        }
        public Builder brandId(int brandId) {
            this.brandId = brandId;
            return this;
        }
        public Builder categoryId(int categoryId) {
            this.categoryId = categoryId;
            return this;
        }
        public Builder description(String description) {
            this.description = description;
            return this;
        }
        public Builder ratio(String ratio) {
            this.ratio = ratio;
            return this;
        }
        public Builder size(String size) {
            this.size = size;
            return this;
        }
        public Builder material(String material) {
            this.material = material;
            return this;
        }
        public Builder origin(String origin) {
            this.origin = origin;
            return this;
        }
        public Builder status(Status status) {
            this.status = status;
            return this;
        }
        public Builder createdAt(LocalDateTime createdAt) {
            this.createdAt = createdAt;
            return this;
        }
        public Builder updatedAt(LocalDateTime updatedAt) {
            this.updatedAt = updatedAt;
            return this;
        }

        public Product build() {
            // Validation cơ bản
            if (name == null || name.isEmpty()) {
                throw new IllegalArgumentException("Tên sản phẩm không được để trống");
            }
            if (price < 0) {
                throw new IllegalArgumentException("Giá không được âm");
            }
            if (finalPrice < 0) {
                throw new IllegalArgumentException("Giá cuối cùng không được âm");
            }
            if (discountPercent < 0 || discountPercent > 100) {
                throw new IllegalArgumentException("Phần trăm giảm phải từ 0 đến 100");
            }
            if (brandId <= 0) {
                throw new IllegalArgumentException("BrandId không hợp lệ");
            }
            if (categoryId <= 0) {
                throw new IllegalArgumentException("CategoryId không hợp lệ");
            }
            return new Product(this);
        }
    }

    // 6. toString (tuỳ chọn)
    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", finalPrice=" + finalPrice +
                ", discountPercent=" + discountPercent +
                ", discountUpdatedAt=" + discountUpdatedAt +
                ", brandId=" + brandId +
                ", categoryId=" + categoryId +
                ", description='" + description + '\'' +
                ", ratio='" + ratio + '\'' +
                ", size='" + size + '\'' +
                ", material='" + material + '\'' +
                ", origin='" + origin + '\'' +
                ", status=" + status +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}