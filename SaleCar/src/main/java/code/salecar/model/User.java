package code.salecar.model;

import java.sql.Date;

public class User {
    private int id;
    private String username;
    private String password;
    private String fullname;
    private String email;
    private String description;
    private String phonenumber;
    private String addressid;
    private String role;
    private boolean status;
    private Date createdat;
    private Date updatedat;
    private String imgURL;
    private String authProvider;
    private String googleId;

    public User(){

    }
    public User(int id, String username, String password, String fullname, String email, String phonenumber, String description, String addressid, String role, boolean status, Date createdat, Date updatedat) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.phonenumber = phonenumber;
        this.description = description;
        this.addressid = addressid;
        this.role = role;
        this.status = status;
        this.createdat = createdat;
        this.updatedat = updatedat;
    }

    public User(int id, String username, String password, String fullname, String email, String description, String phonenumber, String addressid, String role, boolean status, Date createdat, Date updatedat, String imgURL) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.description = description;
        this.phonenumber = phonenumber;
        this.addressid = addressid;
        this.role = role;
        this.status = status;
        this.createdat = createdat;
        this.updatedat = updatedat;
        this.imgURL = imgURL;
    }

    public String getAuthProvider() {
        return authProvider;
    }

    public void setAuthProvider(String authProvider) {
        this.authProvider = authProvider;
    }

    public String getGoogleId() {
        return googleId;
    }

    public void setGoogleId(String googleId) {
        this.googleId = googleId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddressid() {
        return addressid;
    }

    public void setAddressid(String addressid) {
        this.addressid = addressid;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getCreatedat() {
        return createdat;
    }

    public void setCreatedat(Date createdat) {
        this.createdat = createdat;
    }

    public Date getUpdatedat() {
        return updatedat;
    }

    public void setUpdatedat(Date updatedat) {
        this.updatedat = updatedat;
    }

    public boolean isStatus() {
        return status;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }
}
