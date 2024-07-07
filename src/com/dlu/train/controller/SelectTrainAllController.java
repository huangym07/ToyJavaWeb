package com.dlu.train.controller;

import com.alibaba.fastjson.JSON;
import com.dlu.train.service.TOrderService;
import com.dlu.train.service.TrainService;
import com.dlu.train.util.ResultMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// 查询全部车次信息
@WebServlet("/SelectTrainAllController")
public class SelectTrainAllController extends HttpServlet {
    ResultMap resultMap = new ResultMap<>();
    TrainService trainService = new TrainService();
    TOrderService tOrderService = new TOrderService();


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List list = trainService.selectTrainAll();
            resultMap.setStatus(true);
            resultMap.setList(list);
            resultMap.setTotal(list.size());
        } catch (Exception e) {
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }

        String json = JSON.toJSONString(resultMap);
        response.setCharacterEncoding("utf-8");
        response.getWriter().print(json);
    }
}
