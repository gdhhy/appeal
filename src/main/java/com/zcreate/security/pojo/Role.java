package com.zcreate.security.pojo;

import java.io.Serializable;
import java.util.List;

/**
 * 角色对象<p>
 * roleID:关键字，自增长ID<p>
 * name:角色名称<p>
 * roleNo:角色标号<p>
 * layer:角色所在的层次，根为0<p>
 * parentID:父菜单ID<p>
 * hasChild:是否有子角色<p>
 * allowCount:角色允许的用户数，即最多可以有多少个用户拥有该角色
 *
 * @author 黄海晏
 */
public class Role implements Comparable, Serializable {
    private static final long serialVersionUID = -3350764928340911756L;
    private Integer roleID;
    private String name;
    private String roleNo;
    private Integer layer;
    private Integer parentID;
    private Boolean hasChild;
    private String homepage;
    private String note;
    private Integer allowCount = 99999;
    private List<Function> functions;

    public Integer getAllowCount() {
        return allowCount;
    }

    public void setAllowCount(Integer allowCount) {
        this.allowCount = allowCount;
    }


    public Integer getRoleID() {
        return roleID;
    }

    public void setRoleID(Integer roleID) {
        this.roleID = roleID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRoleNo() {
        return roleNo;
    }

    public void setRoleNo(String roleNo) {
        this.roleNo = roleNo;
    }

    public Integer getLayer() {
        return layer;
    }

    public void setLayer(Integer layer) {
        this.layer = layer;
    }

    public Integer getParentID() {
        return parentID;
    }

    public void setParentID(Integer parentID) {
        this.parentID = parentID;
    }

    public Boolean getHasChild() {
        return hasChild != null && hasChild;
    }

    public void setHasChild(Boolean hasChild) {
        this.hasChild = hasChild;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int compareTo(Object object) {
        if (this == object) {
            return 0;
        }
        if (object != null && object instanceof Role) {
            if (getRoleID() > ((Role) object).getRoleID()) return 1;
            if (getRoleID().equals(((Role) object).getRoleID()))
                return 0;
            else
                return -1;
        } else
            return 1;
    }

    public String toString() {
        return name;
    }

    public String getHomepage() {
        return homepage;
    }

    public void setHomepage(String homepage) {
        this.homepage = homepage;
    }

    public List<Function> getFunctions() {
        return functions;
    }

    public void setFunctions(List<Function> functions) {
        this.functions = functions;
    }
}