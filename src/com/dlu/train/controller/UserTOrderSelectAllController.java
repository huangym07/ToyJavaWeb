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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/UserTOrderSelectAllController")
public class UserTOrderSelectAllController extends HttpServlet {
    ResultMap resultMap = new ResultMap<>();
    TrainService trainService = new TrainService();
    TOrderService tOrderService = new TOrderService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        try {
            List list = tOrderService.selectTOrderAll(username);
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
