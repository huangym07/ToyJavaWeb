package com.dlu.train.service;

import com.dlu.train.dao.TOrderDao;
import com.dlu.train.dao.TrainDao;
import com.dlu.train.pojo.TOrder;
import com.dlu.train.pojo.Train;

import java.sql.SQLException;
import java.util.List;

public class TOrderService {
    TOrderDao tOrderDao = new TOrderDao();
    TrainDao trainDao = new TrainDao();
    // 删除所有 trainno 的订单信息
    public int delTrainno(String trainno) {
        int num = tOrderDao.delTrainno(trainno);
        if (num == 0) {
            throw new RuntimeException("编号为 " + trainno + " 相关的订单删除失败，请联系管理员");
        }
        return num;
    }
    // 分页查询用户订单信息
    public List<TOrder> selectTOrder(String username, Integer currentPage, Integer pageSize) throws SQLException {
        return tOrderDao.selectTOrder(username, currentPage, pageSize);
    }
    // 查询全部用户订单信息
    public List<TOrder> selectTOrderAll(String username) throws SQLException {
        return tOrderDao.selectTOrderAll(username);
    }


    // 购票
    public int buyTOrder(String username, String trainno) {
//        System.out.println("到达 Service");
        int num = tOrderDao.buyTOrder(username, trainno);
//        System.out.println("num is " + num);
        if (num == 0) {
            throw new RuntimeException("购票失败，请联系管理员");
        }
        num = trainDao.changeTickets(trainno, 1, -1);
        if (num == 0) {
            throw new RuntimeException("购票失败，请联系管理员");
        }
        return num;
    }

    // 退票
    public int cancelTOrder(String username, String trainno) {
        int num = tOrderDao.cancelTOrder(username, trainno);
        if (num == 0) {
            throw new RuntimeException("退票失败，请联系管理员");
        }
        num = trainDao.changeTickets(trainno, -1, 1);
        if (num == 0) {
            throw new RuntimeException("退票失败，请联系管理员");
        }
        return num;
    }
}
