package code.salecar.model.brand;

public class BrandInfo {
    private Long brandId;
    private String name;
    private String link;
    private String logo;

    public BrandInfo() {
    }
    public BrandInfo(Builder builder) {
        this.brandId = builder.id;
        this.name = builder.name;
        this.link = builder.link;
        this.logo = builder.logo;
    }
    public static Builder builder() {
        return new Builder();
    }

    public String getLogo() {
        return logo;
    }
    public String getLink() {
        return link;
    }
    public String getName() {
        return name;
    }
    public Long getBrandId() {
        return brandId;
    }

    public void setName(String name) {
        this.name = name;
    }
    public void setLink(String link) {
        this.link = link;
    }
    public void setLogo(String logo) {
        this.logo = logo;
    }

    public static class Builder {
        private Long id;
        private String name;
        private String link;
        private String logo;

        public Builder id(Long id) {
            this.id = id;
            return this;
        }
        public Builder name(String name) {
            this.name = name;
            return this;
        }
        public Builder link(String link) {
            this.link = link;
            return this;
        }
        public Builder logo(String logo) {
            this.logo = logo;
            return this;
        }
        public BrandInfo build() {
            return new BrandInfo(this);
        }
    }
}
