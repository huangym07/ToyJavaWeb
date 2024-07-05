package com.dlu.train.util;

import java.util.ArrayList;
import java.util.List;

// 返回到前端的结果类
public class ResultMap<T> {
    private boolean status; //标志：true 表示前端请求响应成功; false -> 失败
    private String message; // 失败原因
    private List<T> list = new ArrayList<>(); // 查询数据

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}
