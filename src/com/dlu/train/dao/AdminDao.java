package com.dlu.train.dao;

import com.dlu.train.pojo.Admin;
import com.dlu.train.pojo.User;
import com.dlu.train.util.JdbcBase;

import java.sql.ResultSet;
import java.sql.SQLException;

// 对 admin 表操作
// 管理员仅支持登录，不支持注册和修改密码等操作
public class AdminDao {
    public Admin signIn(String username, String password) {
        String sql = "select * from admin where adminusername = ? and adminpassword = ?";
        Object[] obj = {username, password};
        Admin admin = null;
        ResultSet rs = JdbcBase.querySql(sql, obj);
        try {
            if (rs.next()) {
                admin = new Admin(rs.getString("adminusername"), rs.getString("adminpassword"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        JdbcBase.close();
        return admin;
    }
}
