package com.dlu.train.dao;

import com.dlu.train.pojo.TOrder;
import com.dlu.train.util.JdbcBase;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// 用户购票退票对订单表的增删改查
// 用户购票和退票 如果没买过该票，那么就是增加，如果买过该票，那么就修改已购买票的张数（增加一个）；退票的时候，如果购买票数为 0，那么删除该订单记录
//
public class TOrderDao {
    public int addTOrder(String username, String trainno, Integer tickets) {
        String sql = "insert into torder values(?, ?, ?)";
        Object[] obj = {username, trainno, tickets};
        int num = JdbcBase.updateSql(sql, obj);
        JdbcBase.close();
        return num;
    }

    public int delTOrder(String username, String trainno) {
        String sql = "delete from torder where username = ? and trainno = ?";
        Object[] obj = {username, trainno};
        int num = JdbcBase.updateSql(sql, obj);
        JdbcBase.close();
        return num;
    }

    // 查询用户订单信息
    public List<TOrder> selectTOrder(String username) throws SQLException {
        String sql = "select * from torder where username = ?";
        Object[] obj = {username};
        List<TOrder> list = new ArrayList<>();
        ResultSet rs = JdbcBase.querySql(sql, obj);
        while (rs.next()) {
            list.add(new TOrder(rs.getString("username"), rs.getString("trainno"), rs.getInt("tickets")));
        }

        JdbcBase.close();
        return list;
    }

    // 购票
    // 传入 username 和 trainno
    // 查询是否有该订单，如果有，仅把 tickets 字段增加 1 即可
    // 如果没有，新建
    public int buyTOrder(String username, String trainno) {
        String sql = "select * from torder where username = ? and trainno = ?";
        Object[] obj = {username, trainno};
        TOrder tOrder = null;
        ResultSet rs = JdbcBase.querySql(sql, obj);
        try {
            if (rs.next()) {
                tOrder = new TOrder(rs.getString("username"), rs.getString("trainno"), rs.getInt("tickets"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        int num = 0;

        if (tOrder == null) { // 如果有该订单
            String sql2 = "update torder set tickets = ? where username = ? and trainno = ?";
            Object[] obj2 = {tOrder.getTickets() + 1, tOrder.getUsername(), tOrder.getTrainno()};
            num = JdbcBase.updateSql(sql2, obj2);
        } else { // 如果没有该订单
            addTOrder(username, trainno, 1);
        }
        JdbcBase.close();
        return num;
    }

    // 退票
    // 同样传入 username 和 trainno
    // 把该订单 tickets 字段减少 1
    // 如果 tickets 变为 0，则删除该订单
    public int cancelTOrder(String username, String trainno) {
        String sql = "select * from torder where username = ? and trainno = ?";
        Object[] obj = {username, trainno};
        TOrder tOrder = null;
        ResultSet rs = JdbcBase.querySql(sql, obj);
        try {
            if (rs.next()) {
                tOrder = new TOrder(rs.getString("username"), rs.getString("trainno"), rs.getInt("tickets"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        int num = 0;

        if (tOrder.getTickets() == 1) { // 仅有一张票
            delTOrder(username, trainno);
        } else {
            String sql2 = "update train set tickets = ? where username = ? and trainno = ?";
            Object[] obj2 = {tOrder.getTickets() - 1, tOrder.getUsername(), tOrder.getTrainno()};
            num = JdbcBase.updateSql(sql2, obj2);
        }

        JdbcBase.close();
        return num;
    }
}
