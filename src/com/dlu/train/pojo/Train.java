package com.dlu.train.pojo;

import java.io.Serializable;
import java.util.Date;

public class Train implements Serializable {
    private String trainno;
    private String startpos;
    private String endpos;
    private String startdate;
    private String enddate;
    private Double price;
    private Integer soldtickets;
    private Integer avalibletickets;

    public Train() {
    }

    public Train(String trainno, String startpos, String endpos, String startdate, String enddate, Double price, Integer soldtickets, Integer avalibletickets) {
        this.trainno = trainno;
        this.startpos = startpos;
        this.endpos = endpos;
        this.startdate = startdate;
        this.enddate = enddate;
        this.price = price;
        this.soldtickets = soldtickets;
        this.avalibletickets = avalibletickets;
    }

    public String getTrainno() {
        return trainno;
    }

    public void setTrainno(String trainno) {
        this.trainno = trainno;
    }

    public String getStartpos() {
        return startpos;
    }

    public void setStartpos(String startpos) {
        this.startpos = startpos;
    }

    public String getEndpos() {
        return endpos;
    }

    public void setEndpos(String endpos) {
        this.endpos = endpos;
    }

    public String getStartdate() {
        return startdate;
    }

    public void setStartdate(String startdate) {
        this.startdate = startdate;
    }

    public String getEnddate() {
        return enddate;
    }

    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getSoldtickets() {
        return soldtickets;
    }

    public void setSoldtickets(Integer soldtickets) {
        this.soldtickets = soldtickets;
    }

    public Integer getAvalibletickets() {
        return avalibletickets;
    }

    public void setAvalibletickets(Integer avalibletickets) {
        this.avalibletickets = avalibletickets;
    }

    @Override
    public String toString() {
        return "Train{" +
                "trainno='" + trainno + '\'' +
                ", startpos='" + startpos + '\'' +
                ", endpos='" + endpos + '\'' +
                ", startdate='" + startdate + '\'' +
                ", enddate='" + enddate + '\'' +
                ", price=" + price +
                ", soldtickets=" + soldtickets +
                ", avalibletickets=" + avalibletickets +
                '}';
    }
}
