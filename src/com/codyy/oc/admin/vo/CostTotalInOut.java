/**
 * Creation Date:2017年9月5日-下午2:50:40
 * 
 * Copyright 2008-2017 © 同程网 Inc. All Rights Reserved
 */
package com.codyy.oc.admin.vo;

import java.math.BigDecimal;



public class CostTotalInOut {
    
    private BigDecimal totalIncome = new BigDecimal(0);
    
    private BigDecimal totalOut = new BigDecimal(0);
    
    private BigDecimal balance = new BigDecimal(0);

	public BigDecimal getTotalIncome() {
		return totalIncome;
	}

	public void setTotalIncome(BigDecimal totalIncome) {
		this.totalIncome = totalIncome;
	}

	public BigDecimal getTotalOut() {
		return totalOut;
	}

	public void setTotalOut(BigDecimal totalOut) {
		this.totalOut = totalOut;
	}

	public BigDecimal getBalance() {
		return balance;
	}

	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}

}

