package code.salecar.model.enumeration;

public enum DiscountEntityType {
    PRODUCT(1),
    CATEGORY(2),
    BRAND(3);

    private int code;
    DiscountEntityType(int code) {this.code = code;}

    public int getCode() {return code;}

    public static DiscountEntityType fromCode(int code) {
        for (DiscountEntityType discountEntityType : DiscountEntityType.values()) {
            if (discountEntityType.getCode() == code) {
                return discountEntityType;
            }
        }
        throw new IllegalArgumentException();
    }

    public static DiscountEntityType fromString(String str) {
        if (str == null) return PRODUCT;
        switch (str.toLowerCase()) {
            case "product": return PRODUCT;
            case "category": return CATEGORY;
            case "brand": return BRAND;
            default: throw new IllegalArgumentException();
        }
    }

}
