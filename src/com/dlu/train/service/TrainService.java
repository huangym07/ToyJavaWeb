package com.dlu.train.service;

import com.dlu.train.dao.TrainDao;
import com.dlu.train.pojo.Train;

import java.sql.SQLException;
import java.util.List;

public class TrainService {
    TrainDao trainDao = new TrainDao();
    // 对车次的增删改，分页查询
    public int addTrain(Train train) {
        int num = trainDao.addTrain(train);
        if (num == 0) {
            throw new RuntimeException("车次增加失败，请联系管理员");
        }
        return num;
    }

    public int delTrain(String trainno) {
        int num = trainDao.delTrain(trainno);
        if (num == 0) {
            throw new RuntimeException("车次删除失败，请联系管理员");
        }
        return num;
    }
    // 主键 trainno 不可修改
    public int updateTrain(Train train) {
        int num = trainDao.updateTrain(train);
        if (num == 0) {
            throw new RuntimeException("车次修改失败，请联系管理员");
        }
        return num;
    }

    public List<Train> selectTrainAll(Integer currentPage, Integer pageSize) throws SQLException {
        return trainDao.selectTrainAll(currentPage, pageSize);
    }
}
