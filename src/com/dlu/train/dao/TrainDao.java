package com.dlu.train.dao;

import com.dlu.train.pojo.Train;
import com.dlu.train.pojo.User;
import com.dlu.train.util.JdbcBase;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// 管理员对车次的增删改查
public class TrainDao {
    // 增加车次
    // 如果已经存在，那么增加失败
    public int addTrain(Train train) {
        String sql = "select * from train where trainno = ?";
        Object[] obj = {train.getTrainno()};
        Train resTrain = null;
        ResultSet rs = JdbcBase.querySql(sql, obj);
        try {
            if (rs.next()) {
                resTrain = new Train(rs.getString("trainno"), rs.getString("startpos"), rs.getString("endpos"), rs.getString("startdate"), rs.getString("enddate"), rs.getDouble("price"), rs.getInt("soldtickets"), rs.getInt("availabletickets"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        int num = 0;
        if (resTrain == null) { // 没有的话可以注册
            sql = "insert into train value(?, ?, ?, ?, ?, ?, ?, ?)";
            Object[] obj2 = {train.getTrainno(), train.getStartpos(), train.getEndpos(), train.getStartdate(), train.getEnddate(), train.getPrice(), 0, train.getAvalibletickets()};
            num = JdbcBase.updateSql(sql, obj2);
        }
        JdbcBase.close();
        return num;
    }

    // 删除车次，仅需传入 trainno
    public int delTrain(String trainno) {
        String sql = "delete from train where trainno = ?";
        Object[] obj = {trainno};
//        System.out.println(trainno);
        int num = JdbcBase.updateSql(sql, obj);
        JdbcBase.close();
        return num;
    }

    // 修改车次信息（trainno 主键不可修改）
    public int updateTrain(Train train) {
        String sql = "update train set startpos = ?, endpos = ?, startdate = ?, enddate = ?, price = ?, soldtickets = ?, availabletickets = ? where trainno = ?";
        Object[] obj = {train.getStartpos(), train.getEndpos(), train.getStartdate(), train.getEnddate(), train.getPrice(), train.getSoldtickets(), train.getAvalibletickets(), train.getTrainno()};
        int num = JdbcBase.updateSql(sql, obj);
        JdbcBase.close();
        return num;
    }

    // 售出票 += value1，剩余票 += value2
    public int changeTickets(String trainno, int value1, int value2) {
        String sql = "select * from train where trainno = ?";
        Object[] obj = {trainno};
        ResultSet rs = JdbcBase.querySql(sql, obj);
        Train train = null;
        try {
            if (rs.next()) {
                train = new Train(rs.getString("trainno"), rs.getString("startpos"), rs.getString("endpos"), rs.getString("startdate"), rs.getString("enddate"), rs.getDouble("price"), rs.getInt("soldtickets"), rs.getInt("availabletickets"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        int num = 0;
        if (train != null) {
            String sql2 = "update train set soldtickets = ?, availabletickets = ? where trainno = ?";
            Object[] obj2 = {train.getSoldtickets() + value1, train.getAvalibletickets() + value2, train.getTrainno()};
            num = JdbcBase.updateSql(sql2, obj2);
        }
        JdbcBase.close();
        return num;
    }

    // 分页查询
    // 传入当前页和页大小
    public List<Train> selectTrainAll(Integer currentPage, Integer pageSize) throws SQLException {
        String sql = "select * from train limit ?, ?";
        Object[] obj = {(currentPage - 1) * pageSize, pageSize};
        List<Train> list = new ArrayList<>();
        ResultSet rs = JdbcBase.querySql(sql, obj);
        while (rs.next()) {
            Train train = new Train(rs.getString("trainno"), rs.getString("startpos"), rs.getString("endpos"), rs.getString("startdate"), rs.getString("enddate"), rs.getDouble("price"), rs.getInt("soldtickets"), rs.getInt("availabletickets"));
            list.add(train);
        }
        JdbcBase.close();
        return list;
    }

    // 查询全部
    public List<Train> selectTrainAll() throws SQLException {
        String sql = "select * from train";
        Object[] obj = {};
        List<Train> list = new ArrayList<>();
        ResultSet rs = JdbcBase.querySql(sql, obj);
        while (rs.next()) {
            Train train = new Train(rs.getString("trainno"), rs.getString("startpos"), rs.getString("endpos"), rs.getString("startdate"), rs.getString("enddate"), rs.getDouble("price"), rs.getInt("soldtickets"), rs.getInt("availabletickets"));
            list.add(train);
        }
        JdbcBase.close();
        return list;
    }
}
