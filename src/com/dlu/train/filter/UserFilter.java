package com.dlu.train.filter;

import com.dlu.train.pojo.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

// 只要访问此地址，就要走过滤器去拦截请求
@WebFilter("/usermain.jsp")
public class UserFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
//        System.out.println("初始化");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        // 每次打开一个浏览器，浏览器就会自动生成 JSESSIONID
        // 服务器会接收 JSESSIONID 的 key，利用 key 生成 SESSION 缓存（后续可以利用，不用再次登录）
        // 此时如果关闭当前浏览器，打开新的浏览器，新的浏览器会生成新的 JSESSIONID，再次利用 JSESSIONID 的 key 生成缓存
        // 1、将请求与响应对象转换成带有 Http 协议的对象
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        // 2、获取 Session 对象
        HttpSession session = req.getSession();
        // 3、从 Session 对象中获取用户的登录信息
        User user = (User) session.getAttribute("user");
        if (user == null) { // 用户没登录过
            // 请求重定向：不涉及任何页面之间的传值，仅跳转
            // 请求转发：可以在页面之间进行传值
            resp.sendRedirect("login.jsp"); // 请求重定向
        } else { // 用户登录过
            // 放开过滤器，让用户访问到目标地址
            filterChain.doFilter(req, resp);
        }
    }

    @Override
    public void destroy() {
//        System.out.println("销毁");
    }
}
