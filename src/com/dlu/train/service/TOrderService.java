package com.dlu.train.service;

import com.dlu.train.dao.TOrderDao;
import com.dlu.train.pojo.TOrder;

import java.sql.SQLException;
import java.util.List;

public class TOrderService {
    TOrderDao tOrderDao = new TOrderDao();
    // 查询用户订单信息
    public List<TOrder> selectTOrder(String username) throws SQLException {
        return tOrderDao.selectTOrder(username);
    }

    // 购票
    public int buyTOrder(String username, String trainno) {
        int num = tOrderDao.buyTOrder(username, trainno);
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
        return num;
    }
}
