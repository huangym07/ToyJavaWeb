package com.dlu.train.pojo;

import java.io.Serializable;

public class Admin implements Serializable {
    private String adminusername;
    private String adminpassword;

    public Admin() {
    }

    public Admin(String adminusername, String adminpassword) {
        this.adminusername = adminusername;
        this.adminpassword = adminpassword;
    }

    public String getAdminusername() {
        return adminusername;
    }

    public void setAdminusername(String adminusername) {
        this.adminusername = adminusername;
    }

    public String getAdminpassword() {
        return adminpassword;
    }

    public void setAdminpassword(String adminpassword) {
        this.adminpassword = adminpassword;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "adminusername='" + adminusername + '\'' +
                ", adminpassword='" + adminpassword + '\'' +
                '}';
    }
}
