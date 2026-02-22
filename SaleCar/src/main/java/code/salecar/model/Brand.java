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
}
