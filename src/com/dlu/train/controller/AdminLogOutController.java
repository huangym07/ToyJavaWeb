package com.dlu.train.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

// 管理员退出登录，跳转到普通用户登录的界面 login.jsp
@WebServlet("/AdminLogOutController")
public class AdminLogOutController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("admin");
        session.removeAttribute("adminusername");
        session.removeAttribute("adminpassword");

        session.invalidate();
        response.sendRedirect("login.jsp");
    }
}
