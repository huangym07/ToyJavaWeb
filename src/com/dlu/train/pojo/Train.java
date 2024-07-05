package com.dlu.train.pojo;

import java.io.Serializable;
import java.util.Date;

public class Train implements Serializable {
    private String trainno;
    private String startpos;
    private String endpos;
    private Date startdate;
    private Date enddate;
    private Long price;
    private Integer soldtickets;
    private Integer avalibletickets;

    public Train() {
    }

    public Train(String trainno, String startpos, String endpos, Date startdate, Date enddate, Long price, Integer soldtickets, Integer avalibletickets) {
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

    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public Date getEnddate() {
        return enddate;
    }

    public void setEnddate(Date enddate) {
        this.enddate = enddate;
    }

    public Long getPrice() {
        return price;
    }

    public void setPrice(Long price) {
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
                ", startdate=" + startdate +
                ", enddate=" + enddate +
                ", price=" + price +
                ", soldtickets=" + soldtickets +
                ", avalibletickets=" + avalibletickets +
                '}';
    }
}
