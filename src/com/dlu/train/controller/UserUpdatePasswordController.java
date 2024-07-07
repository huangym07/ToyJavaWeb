package com.dlu.train.controller;

import com.alibaba.fastjson.JSON;
import com.dlu.train.service.UserService;
import com.dlu.train.util.ResultMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UserUpdatePasswordController")
public class UserUpdatePasswordController extends HttpServlet {
    UserService userService = new UserService();
    ResultMap resultMap = new ResultMap<>();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String newPass = request.getParameter("password");
        System.out.println(username + ", " + newPass);
        try {
            boolean res = userService.updatePassword(username, newPass);
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
