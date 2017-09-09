/**
 * Creation Date:2017年9月5日-下午6:10:07
 * 
 * Copyright 2008-2017 © 同程网 Inc. All Rights Reserved
 */
package com.codyy.oc.admin.vo;

import java.math.BigDecimal;
import java.util.List;

/**
 * Description Of The Class<br/>
 * QQ:835924373
 * 
 * @author 	Irain(胡奎5249)
 * @version 1.0.0, 2017年9月5日-下午6:10:07
 * @since 2017年9月5日-下午6:10:07
 */
public class CostChartsSeriesData {
    
    private String name;
    
    private List<BigDecimal> data;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

	public List<BigDecimal> getData() {
		return data;
	}

	public void setData(List<BigDecimal> data) {
		this.data = data;
	}

}

