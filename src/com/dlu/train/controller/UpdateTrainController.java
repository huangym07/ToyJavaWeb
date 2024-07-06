package com.dlu.train.controller;

import com.alibaba.fastjson.JSON;
import com.dlu.train.pojo.Train;
import com.dlu.train.service.TOrderService;
import com.dlu.train.service.TrainService;
import com.dlu.train.util.ResultMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// 修改车次信息（trainno 主键不可以修改），需要前端传入车次的全部的 8 个信息
@WebServlet("/UpdateTrainController")
public class UpdateTrainController extends HttpServlet {
    ResultMap resultMap = new ResultMap<>();
    TrainService trainService = new TrainService();
    TOrderService tOrderService = new TOrderService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 接收参数：trainno startpos endpos startdate enddate price soldtickets availabletickets
        String trainno = request.getParameter("trainno");
        String startpos = request.getParameter("startpos");
        String endpos = request.getParameter("endpos");
        String startdate = request.getParameter("startdate");
        String enddate = request.getParameter("enddate");
        Double price = Double.parseDouble(request.getParameter("price"));
        Integer soldtickets = Integer.parseInt(request.getParameter("soldtickets"));
        Integer availabletickets = Integer.parseInt(request.getParameter("availabletickets"));
        try {
            trainService.updateTrain(new Train(trainno, startpos, endpos, startdate, enddate, price, soldtickets, availabletickets));
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
