package code.salecar.model;

import java.util.Date;

public class Brand {
    private int id;
    private String name;
    private String description;
    private String image;
    private String linkband;
    private Date createat;
    private Date updateat;

    public Brand(int id, String name, String description, String image, String linkband, Date createat, Date updateat) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.image = image;
        this.linkband = linkband;
        this.createat = createat;
        this.updateat = updateat;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getLinkband() {
        return linkband;
    }

    public void setLinkband(String linkband) {
        this.linkband = linkband;
    }

    public Date getCreateat() {
        return createat;
    }

    public void setCreateat(Date createat) {
        this.createat = createat;
    }

    public Date getUpdateat() {
        return updateat;
    }

    public void setUpdateat(Date updateat) {
        this.updateat = updateat;
    }
}
