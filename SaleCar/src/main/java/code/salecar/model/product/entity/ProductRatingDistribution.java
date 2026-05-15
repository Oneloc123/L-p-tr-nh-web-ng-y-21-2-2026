package code.salecar.model.product.entity;

public class ProductRatingDistribution {
    private int oneStar;
    private int twoStar;
    private int threeStar;
    private int fourStar;
    private int fiveStar;

    // 1. Constructor mặc định (nếu cần)
    public ProductRatingDistribution() {
    }
    // 2. Constructor với tất cả tham số (dùng cho Builder)
    public ProductRatingDistribution(int oneStar, int twoStar, int threeStar, int fourStar, int fiveStar) {
        this.oneStar = oneStar;
        this.twoStar = twoStar;
        this.threeStar = threeStar;
        this.fourStar = fourStar;
        this.fiveStar = fiveStar;
    }
    // 3. Constructor nhận Builder
    private ProductRatingDistribution(Builder builder) {
        this.oneStar = builder.oneStar;
        this.twoStar = builder.twoStar;
        this.threeStar = builder.threeStar;
        this.fourStar = builder.fourStar;
        this.fiveStar = builder.fiveStar;
    }

    // 4. Getter và Setter
    public int getOneStar() {
        return oneStar;
    }
    public void setOneStar(int oneStar) {
        this.oneStar = oneStar;
    }
    public int getTwoStar() {
        return twoStar;
    }
    public void setTwoStar(int twoStar) {
        this.twoStar = twoStar;
    }
    public int getThreeStar() {
        return threeStar;
    }
    public void setThreeStar(int threeStar) {
        this.threeStar = threeStar;
    }
    public int getFourStar() {
        return fourStar;
    }
    public void setFourStar(int fourStar) {
        this.fourStar = fourStar;
    }
    public int getFiveStar() {
        return fiveStar;
    }
    public void setFiveStar(int fiveStar) {
        this.fiveStar = fiveStar;
    }

    // 5. Builder pattern
    public static Builder builder() {
        return new Builder();
    }
    public static class Builder {
        private int oneStar;
        private int twoStar;
        private int threeStar;
        private int fourStar;
        private int fiveStar;

        // Các method setter trả về chính Builder (fluent style)
        public Builder oneStar(int oneStar) {
            this.oneStar = oneStar;
            return this;
        }

        public Builder twoStar(int twoStar) {
            this.twoStar = twoStar;
            return this;
        }

        public Builder threeStar(int threeStar) {
            this.threeStar = threeStar;
            return this;
        }

        public Builder fourStar(int fourStar) {
            this.fourStar = fourStar;
            return this;
        }

        public Builder fiveStar(int fiveStar) {
            this.fiveStar = fiveStar;
            return this;
        }

        // Phương thức build() tạo đối tượng ProductRatingDistribution
        public ProductRatingDistribution build() {
            // Có thể thêm validation nếu cần (ví dụ các số không âm)
            if (oneStar < 0 || twoStar < 0 || threeStar < 0 || fourStar < 0 || fiveStar < 0) {
                throw new IllegalArgumentException("Số lượng đánh giá không được âm");
            }
            return new ProductRatingDistribution(this);
        }
    }

    // 6. Override toString() để dễ in ra
    @Override
    public String toString() {
        return "ProductRatingDistribution{" +
                "oneStar=" + oneStar +
                ", twoStar=" + twoStar +
                ", threeStar=" + threeStar +
                ", fourStar=" + fourStar +
                ", fiveStar=" + fiveStar +
                '}';
    }
}
