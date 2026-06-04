package code.salecar.model;

import java.sql.Date;

public class Addresses {
    private int id;
    private String type;
    private int userId;
    private String addressLine;
    private String provinceName;
    private String wardName;
    private String fullAddress;
    private Date createAt;
    private String nameAddress;
    private String districName;

    public Addresses(){
    }

    public Addresses(int id, String type, int userId, String addressLine, String provinceName, String wardName, String fullAddress, Date createAt,String nameAddress, String districName) {
        this.id = id;
        this.type = type;
        this.userId = userId;
        this.addressLine = addressLine;
        this.provinceName = provinceName;
        this.wardName = wardName;
        this.fullAddress = fullAddress;
        this.createAt = createAt;
        this.nameAddress = nameAddress;
        this.districName = districName;
    }

    public String getNameAddress() {
        return nameAddress;
    }

    public void setNameAddress(String nameAddress) {
        this.nameAddress = nameAddress;
    }

    public String getDistricName() {
        return districName;
    }

    public void setDistricName(String distric_name) {
        this.districName = distric_name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getAddressLine() {
        return addressLine;
    }

    public void setAddressLine(String addressLine) {
        this.addressLine = addressLine;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

    public String getWardName() {
        return wardName;
    }

    public void setWardName(String wardName) {
        this.wardName = wardName;
    }

    public String getFullAddress() {
        return fullAddress;
    }

    public void setFullAddress(String fullAddress) {
        this.fullAddress = fullAddress;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }
}
