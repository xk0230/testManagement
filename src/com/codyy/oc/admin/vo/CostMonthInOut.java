/**
 * Creation Date:2017年9月5日-上午11:33:18
 * 
 * Copyright 2008-2017 © 同程网 Inc. All Rights Reserved
 */
package com.codyy.oc.admin.vo;


/**
 * 成本月份收入支出
 */
public class CostMonthInOut {
    
    private String name;
    
    private String month;
    
    private double total;
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

}

