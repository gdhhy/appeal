package com.zcreate.security.pojo;

import javax.xml.bind.annotation.XmlElement;
import java.io.Serializable;

/**
 * 部门对象<p>
 * groupID：关键字，自增长ID<p>
 * name:部门名称<p>
 * groupNo:部门编号<p>
 * layer:部门所在的层次，根为0<p>
 * parentID:上级部门ID<p>
 * hasChild：是否有下级<p>
 * orderID:同级部门中的排序号<p>
 * principal:部门主管的用户ID
 *
 * @author 黄海晏
 */
public class Group implements Comparable, Serializable {
    private static final long serialVersionUID = 3183026029455420777L;
    private Integer groupID;
    private String name;
    private String groupNo;
    private Integer layer;
    private Integer parentID;
    private Boolean hasChild;
    private String note;
    private Integer orderID;
    private Integer principal;

    public Integer getGroupID() {
        return groupID;
    }

    public void setGroupID(Integer groupID) {
        this.groupID = groupID;
    }

    public String getName() {
        return name;
    }

    @XmlElement(required = true)
    public void setName(String name) {
        this.name = name;
    }

    public String getGroupNo() {
        return groupNo;
    }

    public void setGroupNo(String no) {
        this.groupNo = no;
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
      @XmlElement( required = true)
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

    public Integer getOrderID() {
        return orderID;
    }

    public void setOrderID(Integer orderID) {
        this.orderID = orderID;
    }

    public Integer getPrincipal() {
        return principal;
    }

    public void setPrincipal(Integer principal) {
        this.principal = principal;
    }

    public String toString() {
        return name;
    }

    public int compareTo(Object object) {
        if (this == object) {
            return 0;
        }
        if (object != null && object instanceof Group) {
            if (getGroupID() > ((Group) object).getGroupID()) return 1;
            if (getGroupID().equals(((Group) object).getGroupID()))
                return 0;
            else
                return -1;
        } else
            return 1;
    }
}