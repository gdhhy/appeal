package com.zcreate.security.pojo;

import java.io.Serializable;
import java.util.List;

/**
 * 菜单权限对象，在本系统中，菜单等同于权限，也等同功能<p>
 * functionID:关键字，自增长ID<p>
 * name:菜单名称<p>
 * functionNo:菜单编号<p>
 * url:菜单的主请求url<p>
 * moreUrl:进入本功能后，其他链接的url<p>
 * newWindow:点击本菜单是否创建新浏览器的窗口后打开<p>
 * orderID:菜单顺序ID<p>
 * layer:菜单所在的层次，根为0<p>
 * parentID:父菜单ID<p>
 * hasChild:是否有子菜单<p>
 * isMenu:是否显示为菜单，如果否，不显示出来,可以作为页面的具体功能，例如增删改，设定functionNo，判断用户是否有该功能，然后显示增删改按钮<p>
 * swingMenu: 是否是Swing菜单,Swing客户端用<p>
 * requestAuth:要求登录用户验证,部分功能可能不需要登录就可以访问，例如公告<p>
 * permitIP:设定本功能访问时允许的IP访问，可设置IP段<p>
 * icon:菜单图标链接，显示在菜单树上，大小是16x16
 *
 * @author 黄海晏
 */
public class Function implements Comparable, Serializable {
    private static final long serialVersionUID = 8438431945522750290L;
    private Integer functionID;
    private String name;
    private String functionNo;
    // private String no = "";
    private String url = "";
    private String moreUrl = "";
    private Boolean newWindow;
    private Integer orderID;
    private Integer layer;
    private Integer parentID;
    private Boolean hasChild;
    private Boolean isMenu;
    private Integer swingMenu = 0;
    private Boolean requestAuth;
    private String permitIP;
    private String note;
    private String icon = "";
    private String bigIcon = "";
    private List<Function> child;

    public Integer getFunctionID() {
        return functionID;
    }

    public void setFunctionID(Integer functionID) {
        this.functionID = functionID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFunctionNo() {
        return functionNo;
    }

    public void setFunctionNo(String functionNo) {
        this.functionNo = functionNo;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getMoreUrl() {
        return moreUrl;
    }

    public void setMoreUrl(String moreUrl) {
        this.moreUrl = moreUrl;
    }

    public Boolean getNewWindow() {
        return newWindow;
    }

    public void setNewWindow(Boolean newWindow) {
        this.newWindow = newWindow;
    }

    public Integer getOrderID() {
        return orderID;
    }

    public void setOrderID(Integer orderID) {
        this.orderID = orderID;
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
        return hasChild;
    }

    public void setHasChild(Boolean hasChild) {
        this.hasChild = hasChild;
    }

    public Boolean getMenu() {
        return isMenu;
    }

    public void setMenu(Boolean menu) {
        isMenu = menu;
    }

    public Integer getSwingMenu() {
        return swingMenu;
    }

    public void setSwingMenu(Integer swingMenu) {
        this.swingMenu = swingMenu;
    }

    public Boolean getRequestAuth() {
        return requestAuth;
    }

    public void setRequestAuth(Boolean requestAuth) {
        this.requestAuth = requestAuth;
    }

    public String getPermitIP() {
        return permitIP;
    }

    public void setPermitIP(String permitIP) {
        this.permitIP = permitIP;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getBigIcon() {
        return bigIcon;
    }

    public void setBigIcon(String bigIcon) {
        this.bigIcon = bigIcon;
    }

    //按照layer,orderID,functionID来排序
    public int compareTo(Object object) {
        if (this == object) {
            return 0;
        }
        if (object != null && object instanceof Function) {
            Function aFunc = (Function) object;
            if (getLayer() < aFunc.getLayer()) return 1;
            if (getLayer().equals(aFunc.getLayer())) {
                /* System.out.println("aFunc = " + aFunc);
            System.out.println("this.getName() = " + this.getName());
            System.out.println("getOrderID = " + getOrderID());
            System.out.println("aFunc.getOrderID() = " + aFunc.getOrderID());*/
                if (getOrderID() < aFunc.getOrderID()) return 1;
                else if (getOrderID().equals(aFunc.getOrderID())) {
                    if (getFunctionID() < aFunc.getFunctionID()) return 1;
                    else if (getFunctionID().equals(aFunc.getFunctionID())) return 0;
                    else return -1;
                } else return -1;
            } else
                return -1;
        } else
            return 1;
    }

    public List<Function> getChild() {
        return child;
    }

    public void setChild(List<Function> child) {
        this.child = child;
    }
}