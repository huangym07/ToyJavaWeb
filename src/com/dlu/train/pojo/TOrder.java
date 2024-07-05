package com.dlu.train.pojo;

import java.io.Serializable;

public class TOrder implements Serializable {
    private String username;
    private String trainno;
    private int tickets;

    public TOrder() {
    }

    public TOrder(String username, String trainno, int tickets) {
        this.username = username;
        this.trainno = trainno;
        this.tickets = tickets;
    }


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getTrainno() {
        return trainno;
    }

    public void setTrainno(String trainno) {
        this.trainno = trainno;
    }

    public int getTickets() {
        return tickets;
    }

    public void setTickets(int tickets) {
        this.tickets = tickets;
    }

    @Override
    public String toString() {
        return "TOrder{" +
                "username='" + username + '\'' +
                ", trainno='" + trainno + '\'' +
                ", tickets=" + tickets +
                '}';
    }
}
