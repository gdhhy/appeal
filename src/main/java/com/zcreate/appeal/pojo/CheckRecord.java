package com.zcreate.appeal.pojo;

import java.io.Serializable;
import java.sql.Timestamp;

public class CheckRecord implements Serializable {
    private int recordID;
    private int eventID;
    private String checkMethod;
    private String checkType;
    private String name;
    private String idNo;
    private String sex;
    private String address;
    private Timestamp checkTime;
    private String police;
    private String policeman;
    private String policeNo;
    private String filterCause;
    private String handle;
    private String dataValid;
    private String situation;
    private int createUserID;
    private Timestamp createTime;

    public int getRecordID() {
        return recordID;
    }

    public void setRecordID(int recordID) {
        this.recordID = recordID;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public String getCheckMethod() {
        return checkMethod;
    }

    public void setCheckMethod(String checkMethod) {
        this.checkMethod = checkMethod;
    }

    public String getCheckType() {
        return checkType;
    }

    public void setCheckType(String checkType) {
        this.checkType = checkType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIdNo() {
        return idNo;
    }

    public void setIdNo(String idNo) {
        this.idNo = idNo;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Timestamp getCheckTime() {
        return checkTime;
    }

    public void setCheckTime(Timestamp checkTime) {
        this.checkTime = checkTime;
    }

    public String getPolice() {
        return police;
    }

    public void setPolice(String police) {
        this.police = police;
    }

    public String getPoliceman() {
        return policeman;
    }

    public void setPoliceman(String policeman) {
        this.policeman = policeman;
    }

    public String getPoliceNo() {
        return policeNo;
    }

    public void setPoliceNo(String policeNo) {
        this.policeNo = policeNo;
    }

    public String getFilterCause() {
        return filterCause;
    }

    public void setFilterCause(String filterCause) {
        this.filterCause = filterCause;
    }

    public String getHandle() {
        return handle;
    }

    public void setHandle(String handle) {
        this.handle = handle;
    }

    public String getDataValid() {
        return dataValid;
    }

    public void setDataValid(String dataValid) {
        this.dataValid = dataValid;
    }

    public String getSituation() {
        return situation;
    }

    public void setSituation(String situation) {
        this.situation = situation;
    }

    public int getCreateUserID() {
        return createUserID;
    }

    public void setCreateUserID(int createUserID) {
        this.createUserID = createUserID;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }
}
