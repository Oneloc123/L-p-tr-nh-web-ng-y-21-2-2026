package code.salecar.model.category;

public class CategoryInfo {
    private long categoryId;
    private String name;

    public CategoryInfo() { }
    public CategoryInfo(Builder builder) {
        this.categoryId = builder.id;
        this.name = builder.name;
    }
    public static Builder builder() {
        return new Builder();
    }

    public long getCategoryId() {
        return categoryId;
    }
    public String getName() {
        return name;
    }

    public static class Builder {
        private long id;
        private String name;

        public Builder id(long id) {
            this.id = id;
            return this;
        }
        public Builder name(String name) {
            this.name = name;
            return this;
        }
        public CategoryInfo build() {
            return new CategoryInfo(this);
        }
    }
}
