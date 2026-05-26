package code.salecar.model.product.entity;

import code.salecar.model.User;

import java.time.LocalDateTime;
import java.util.Date;

public class ActivityLog {
    private int id;
    private String action;
    private Date timestamp;
    private String user;
    private String details;

    public ActivityLog(Builder builder) {
        this.id = builder.id;
        this.action = builder.action;
        this.timestamp = builder.timestamp;
        this.user = builder.user;
        this.details = builder.details;
    }
    public ActivityLog(){}
    public static Builder builder(){
        return new Builder();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public static class Builder{
        private int id;
        private String action;
        private Date timestamp;
        private String user;
        private String details;

        public Builder id(int id){this.id = id; return this;}
        public Builder action(String action){this.action = action; return this;}
        public Builder timestamp(Date timestamp){this.timestamp = timestamp; return this;}
        public Builder user(String user){this.user = user; return this;}
        public Builder details(String details){this.details = details; return this;}
        public ActivityLog build(){return new  ActivityLog(this);}
    }

}
