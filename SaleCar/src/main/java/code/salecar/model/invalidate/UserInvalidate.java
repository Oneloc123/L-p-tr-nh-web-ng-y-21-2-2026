package code.salecar.model.invalidate;

public class UserInvalidate {
    public static String checkPassword(String password) {
        String result = "true";
        if (password == null || password.trim().isEmpty()) {
            return "Mật khẩu không được để trống";
        }
        if (password.length() < 8) {
            return "Mật khẩu phải có ít nhất 8 ký tự";
        }
        if (password.length() > 50) {
            return "Mật khẩu không được vượt quá 50 ký tự";
        }
        if (!password.matches(".*[A-Z].*")) {
            return "Mật khẩu phải có ít nhất 1 chữ hoa";
        }
        if (!password.matches(".*[a-z].*")) {
            return "Mật khẩu phải có ít nhất 1 chữ thường";
        }
        if (!password.matches(".*[0-9].*")) {
            return "Mật khẩu phải có ít nhất 1 chữ số";
        }
        if (!password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*")) {
            return "Mật khẩu phải có ít nhất 1 ký tự đặc biệt (!@#$%^&*,...)";
        }
        if (password.contains(" ")) {
            return "Mật khẩu không được chứa khoảng trắng";
        }
        return result;
    }

    public static String checkUsername(String username) {
        String result = "true";
        if (username == null || username.trim().isEmpty()) {
            return "Tên đăng nhập không được để trống";
        }
        if (username.length() < 4) {
            return "Tên đăng nhập phải có ít nhất 4 ký tự";
        }
        if (username.length() > 30) {
            return "Tên đăng nhập không được vượt quá 30 ký tự";
        }
        if (!username.matches("^[a-zA-Z0-9_]+$")) {
            return "Tên đăng nhập chỉ được chứa chữ cái, số và dấu gạch dưới (_)";
        }
        if (username.matches("^[0-9].*")) {
            return "Tên đăng nhập không được bắt đầu bằng số";
        }
        if (username.contains(" ")) {
            return "Tên đăng nhập không được chứa khoảng trắng";
        }
        return result;
    }
    public static String checkFullname(String fullname) {
        String result = "true";
        if (fullname == null || fullname.trim().isEmpty()) {
            return "Họ và tên không được để trống";
        }
        if (fullname.trim().length() < 2) {
            return "Họ và tên phải có ít nhất 2 ký tự";
        }
        if (fullname.trim().length() > 50) {
            return "Họ và tên không được vượt quá 50 ký tự";
        }
        if (!fullname.matches("^[\\p{L} ]+$")) {
            return "Họ và tên chỉ được chứa chữ cái và khoảng trắng";
        }
        if (fullname.matches(".*\\s{2,}.*")) {
            return "Họ và tên không được chứa nhiều khoảng trắng liên tiếp";
        }
        if (fullname.trim().split("\\s+").length < 2) {
            return "Vui lòng nhập đầy đủ họ và tên";
        }
        return result;
    }

    public static String checkEmail(String email) {
        String result = "true";
        if (email == null || email.trim().isEmpty()) {
            return "Email không được để trống";
        }
        if (email.trim().length() > 100) {
            return "Email không được vượt quá 100 ký tự";
        }
        if (email.contains(" ")) {
            return "Email không được chứa khoảng trắng";
        }
        if (!email.matches("^[a-zA-Z0-9._%+\\-]+@[a-zA-Z0-9.\\-]+\\.[a-zA-Z]{2,}$")) {
            return "Email không đúng định dạng (vd: example@gmail.com)";
        }
        if (email.matches(".*\\.{2,}.*")) {
            return "Email không được chứa nhiều dấu chấm liên tiếp";
        }
        if (email.startsWith(".") || email.split("@")[0].endsWith(".")) {
            return "Phần tên email không được bắt đầu hoặc kết thúc bằng dấu chấm";
        }
        return result;
    }
    public static String checkPhonenumber(String phonenumber) {
        String result = "true";
        if (phonenumber == null || phonenumber.trim().isEmpty()) {
            return "Số điện thoại không được để trống";
        }
        if (phonenumber.contains(" ")) {
            return "Số điện thoại không được chứa khoảng trắng";
        }
        if (!phonenumber.matches("^[0-9+]+$")) {
            return "Số điện thoại chỉ được chứa chữ số và dấu +";
        }
        String normalized = phonenumber.startsWith("+84") ? "0" + phonenumber.substring(3) : phonenumber;
        if (!normalized.startsWith("0")) {
            return "Số điện thoại phải bắt đầu bằng 0 hoặc +84";
        }
        if (normalized.length() != 10) {
            return "Số điện thoại phải có đúng 10 chữ số";
        }
        if (!normalized.matches("^(03|05|07|08|09)[0-9]{8}$")) {
            return "Số điện thoại không đúng đầu số Việt Nam (03x, 05x, 07x, 08x, 09x)";
        }
        return result;
    }
}
