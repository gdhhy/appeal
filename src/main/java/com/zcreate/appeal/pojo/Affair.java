package com.zcreate.appeal.pojo;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Affair implements Serializable {
    private Integer affairID;
    private String name;
    private String place;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date togetherTime;
    private String appealDepart;
    private String receptionDepart;
    private String police;
    private String general;
    private Integer createUserID;

    private Date createTime;


    public Integer getAffairID() {
        return affairID;
    }

    public void setAffairID(Integer affairID) {
        this.affairID = affairID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public Date getTogetherTime() {
        return togetherTime;
    }

    public void setTogetherTime(Date togetherTime) {
        this.togetherTime = togetherTime;
    }

    public String getAppealDepart() {
        return appealDepart;
    }

    public void setAppealDepart(String appealDepart) {
        this.appealDepart = appealDepart;
    }

    public String getReceptionDepart() {
        return receptionDepart;
    }

    public void setReceptionDepart(String receptionDepart) {
        this.receptionDepart = receptionDepart;
    }

    public String getPolice() {
        return police;
    }

    public String getGeneral() {
        return general;
    }

    public void setGeneral(String general) {
        this.general = general;
    }

    public void setPolice(String police) {
        this.police = police;
    }

    public Integer getCreateUserID() {
        return createUserID;
    }

    public void setCreateUserID(Integer createUserID) {
        this.createUserID = createUserID;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
