package com.dlu.train.filter;

import com.dlu.train.pojo.Admin;
import com.dlu.train.pojo.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin.jsp")
public class AdminFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        // 每次打开一个浏览器，浏览器就会自动生成 JSESSIONID
        // 服务器会接收 JSESSIONID 的 key，利用 key 生成 SESSION 缓存（后续可以利用，不用再次登录）
        // 此时如果关闭当前浏览器，打开新的浏览器，新的浏览器会生成新的 JSESSIONID，再次利用 JSESSIONID 的 key 生成缓存
        // 1、将请求与响应对象转换成带有 Http 协议的对象
        HttpServletRequest hreq = (HttpServletRequest) req;
        HttpServletResponse hresp = (HttpServletResponse) resp;
        // 2、获取 Session 对象
        HttpSession session = hreq.getSession();
        // 3、从 Session 对象中获取用户的登录信息
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) { // 用户没登录过
            // 请求重定向：不涉及任何页面之间的传值，仅跳转
            // 请求转发：可以在页面之间进行传值
            hresp.sendRedirect("login.jsp"); // 请求重定向
        } else { // 用户登录过
            // 放开过滤器，让用户访问到目标地址
            chain.doFilter(hreq, hresp);
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
