package com.dlu.train.service;

import com.dlu.train.dao.AdminDao;
import com.dlu.train.pojo.Admin;
import com.dlu.train.pojo.User;

public class AdminService {
    AdminDao adminDao = new AdminDao();

    public Admin signIn(String username, String password) {
        Admin admin = adminDao.signIn(username, password);
        if (admin == null) {
            throw new RuntimeException("账号或密码输入错误");
        }
        return admin;
    }
}
