package com.dlu.train.util;

import java.sql.*;

public class JdbcBase {
    static Connection con = null;
    static ResultSet rs = null;
    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    // 建立连接
    public static Connection getConnection() {
        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/train/?characterEncoding=utf8&serverTimezone=GMT%288", "root", "rootmysql");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return con;
    }
    // 执行查询 sql 语句
    public static ResultSet querySql(String sql, Object[] obj) { // obj 用来给占位符赋值
        PreparedStatement pstm = null;
        try {
            con = getConnection();
            pstm = con.prepareStatement(sql);
            // 判断 sql 是否需要参数
            for (int i = 0; i < obj.length; i++) {
                if (obj[i] != null) {
                    pstm.setObject(i + 1, obj[i]);
                }
            }
            // 执行 sql
            rs = pstm.executeQuery(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    // 执行增删改的方法
    public static int updateSql(String sql, Object[] obj) {
        int num = 0;
        PreparedStatement pstm = null;
        try {
            con = getConnection();
            pstm = con.prepareStatement(sql);
            // 判断 sql 是否需要参数
            for (int i = 0; i < obj.length; i++) {
                if (obj[i] != null) {
                    pstm.setObject(i + 1, obj[i]);
                }
            }
            // 执行 sql
            num = pstm.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return num;
    }

    // 关闭流
    public static void close() {
        try {
            con.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
