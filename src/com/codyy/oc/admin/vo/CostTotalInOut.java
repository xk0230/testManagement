/**
 * Creation Date:2017年9月5日-下午2:50:40
 * 
 * Copyright 2008-2017 © 同程网 Inc. All Rights Reserved
 */
package com.codyy.oc.admin.vo;



public class CostTotalInOut {
    
    private double totalIncome = 0.00;
    
    private double totalOut= 0.00;
    
    private double balance= 0.00;

    public double getTotalIncome() {
        return totalIncome;
    }

    public void setTotalIncome(double totalIncome) {
        this.totalIncome = totalIncome;
    }

    public double getTotalOut() {
        return totalOut;
    }

    public void setTotalOut(double totalOut) {
        this.totalOut = totalOut;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

}

