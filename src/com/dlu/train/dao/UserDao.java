package com.dlu.train.dao;

import com.dlu.train.pojo.User;
import com.dlu.train.util.JdbcBase;

import java.sql.ResultSet;
import java.sql.SQLException;

// 需要对用户表操作的相关功能
public class UserDao {
    // 用户登录
    public User signIn(String username, String password) {
        String sql = "select * from user where username = ? and password = ?";
        Object[] obj = {username, password};
        User user = null;
        ResultSet rs = JdbcBase.querySql(sql, obj);
        try {
            if (rs.next()) {
                user = new User(rs.getString("username"), rs.getString("password"), rs.getString("name"), rs.getString("phonenumber"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        JdbcBase.close();
        return user;
    }

    // 用户注册
    // 前端传入 User
    // 判断是否已经存在相同的 username; true -> 注册成功 false -> 注册失败
    public Boolean signUp(User user) {
        String sql = "select * from user where username = ?";
        Object[] obj = {user.getUsername()};
        User resUser = null;
        ResultSet rs = JdbcBase.querySql(sql, obj);
        try {
            if (rs.next()) {
                resUser = new User(rs.getString("username"), rs.getString("password"), rs.getString("name"), rs.getString("phonenumber"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        boolean res = false;
        if (resUser == null) { // 没有的话可以注册
            sql = "insert into user value(?, ?, ?, ?)";
            Object[] obj2 = {user.getUsername(), user.getPassword(), user.getName(), user.getPhonenumber()};
            int num = JdbcBase.updateSql(sql, obj2);
            if (num >= 1) res = true;
            else res = false;
        } else { // 注册失败
            res = false;
        }
        JdbcBase.close();
        return res;
    }

    // 用户修改密码
    // 前端传入原密码和新密码
    // 原密码正确，那么修改成功 返回 true 否则返回 false
    public Boolean updatePassword(String username, String newPass) {
        boolean res = false;
        String sql = "update user set password = ? where username = ";
        Object[] obj = {username, newPass};
        int num = JdbcBase.updateSql(sql, obj);
        if (num >= 1) res = true;
        else res = false;
        JdbcBase.close();
        return res;
    }
}
