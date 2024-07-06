package com.dlu.train.service;

import com.dlu.train.dao.UserDao;
import com.dlu.train.pojo.User;

public class UserService {
    UserDao userDao = new UserDao();

    public User signIn(String username, String password) {
        User user = userDao.signIn(username, password);
        if (user == null) {
            throw new RuntimeException("账号或密码输入错误");
        }
        return user;
    }

    public Boolean signUp(User user) {
        boolean res = userDao.signUp(user);
        if (res == false) {
            throw new RuntimeException("注册失败，请更换账号后重试");
        }
        return true;
    }

    public Boolean updatePassword(String username, String newPass) {
        boolean res = userDao.updatePassword(username, newPass);
        if (res == false) {
            throw new RuntimeException("修改密码失败");
        }
        return true;
    }
}
