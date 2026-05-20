package code.salecar.model.enumeration;

public enum DiscountValueType {
    PERCENT(1),
    AMOUNT(2);

    private int code;
    DiscountValueType(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static DiscountValueType fromCode(int code) {
        for (DiscountValueType discountValueType : DiscountValueType.values()) {
            if (discountValueType.getCode() == code) {
                return discountValueType;
            }
        }
        throw new IllegalArgumentException();
    }

    public static DiscountValueType fromString(String str) {
        if (str == null) return PERCENT;
        switch (str.toLowerCase()) {
            case "rate": return PERCENT;
            case "amount": return AMOUNT;
            default: throw new IllegalArgumentException();
        }
    }

}
