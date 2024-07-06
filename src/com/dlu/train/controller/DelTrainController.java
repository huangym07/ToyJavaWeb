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

// 删除车次信息（删除的同时，删除订单表中所有该车次的订单）
@WebServlet("/DelTrainController")
public class DelTrainController extends HttpServlet {
    ResultMap resultMap = new ResultMap<>();
    TrainService trainService = new TrainService();
    TOrderService tOrderService = new TOrderService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 接收参数：trainno
        String trainno = request.getParameter("trainno");
        try {
            // 先删 torder 表中的 trainno 相关的项（因为它作为外键，关联 train 表，所以 train 表中的 trainno 相关的项后删除）
            tOrderService.delTrainno(trainno);
            trainService.delTrain(trainno);
            resultMap.setStatus(true);
        } catch (Exception e) {
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }

        String json = JSON.toJSONString(resultMap);
        response.setCharacterEncoding("utf-8");
        response.getWriter().print(json);
    }
}
