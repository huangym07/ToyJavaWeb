package com.dlu.train.controller;

import com.alibaba.fastjson.JSON;
import com.dlu.train.pojo.Admin;
import com.dlu.train.service.AdminService;
import com.dlu.train.util.ResultMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

// 管理员登录
@WebServlet("/AdminSignInController")
public class AdminSignInController extends HttpServlet {
    AdminService adminService = new AdminService();
    ResultMap resultMap = new ResultMap();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 接收参数：adminusername adminpassword
        String adminusername = request.getParameter("adminusername");
        String adminpassword = request.getParameter("adminpassword");

        try {
            Admin admin = adminService.signIn(adminusername, adminpassword);
            resultMap.setStatus(true);

            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            session.setAttribute("adminusername", admin.getAdminusername());
            session.setAttribute("adminpassword", admin.getAdminpassword());
        } catch (Exception e) {
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }

        String json = JSON.toJSONString(resultMap);
        response.setCharacterEncoding("utf-8");
        response.getWriter().print(json);
    }
}
