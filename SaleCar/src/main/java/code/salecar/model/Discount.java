package code.salecar.model;

import java.math.BigDecimal;
import java.util.Date;

public class Discount {
    private int id;
    private String name;
    private String description;
    private String vauletype;
    private BigDecimal value;
    private String entitytype;
    private int entityid;
    private Date endat;
    private Date startat;
    private Date createat;

    public Discount(int id, String name, String description, String vauletype, BigDecimal  value, String entitytype, int entityid, Date endat, Date startat, Date createat) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.vauletype = vauletype;
        this.value = value;
        this.entitytype = entitytype;
        this.entityid = entityid;
        this.endat = endat;
        this.startat = startat;
        this.createat = createat;
    }
}
