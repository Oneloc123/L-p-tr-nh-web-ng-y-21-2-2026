package code.salecar.model;

public class Address {
    private int id;
    private int userId;
    private String street;
    private String commune;
    private String province;
    private String type;
    private String name;

    public Address(int id, int userId, String street, String commune, String province, String type, String name) {
        this.id = id;
        this.userId = userId;
        this.street = street;
        this.commune = commune;
        this.province = province;
        this.type = type;
        this.name = name;
    }

    public Address(){

    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCommune() {
        return commune;
    }

    public void setCommune(String commune) {
        this.commune = commune;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }
}
