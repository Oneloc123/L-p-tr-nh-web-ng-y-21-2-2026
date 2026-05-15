package code.salecar.model.enumeration;

public enum Status {
    INACTIVE(0),
    ACTIVE(1);

    /*
    Brand, Category, Product, Voucher dùng private Status status;
    Getter trả về Status, getter trả về int nếu cần (dùng status.getCode()).
    Setter nhận Status hoặc int (chuyển đổi an toàn)
    */

    private final int code;

    Status(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static Status fromCode(int code) {
        for (Status s : values()) {
            if (s.code == code) return s;
        }
        throw new IllegalArgumentException("Invalid status code: " + code);
    }

    public static Status fromString(String str) {
        if (str == null) return INACTIVE;
        return str.equalsIgnoreCase("active") ? ACTIVE : INACTIVE;
    }
}
