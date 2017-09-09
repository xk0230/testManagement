/**
 * Creation Date:2017年9月5日-下午6:07:53
 * 
 * Copyright 2008-2017 © 同程网 Inc. All Rights Reserved
 */
package com.codyy.oc.admin.vo;

import java.util.List;

/**
 * Description Of The Class<br/>
 * QQ:835924373
 * 
 * @author 	Irain(胡奎5249)
 * @version 1.0.0, 2017年9月5日-下午6:07:53
 * @since 2017年9月5日-下午6:07:53
 */
public class CostChartsData {
    
    private List<String> xcategories ;
    
    private List<CostChartsSeriesData> seriesData ;

    public List<String> getXcategories() {
        return xcategories;
    }

    public void setXcategories(List<String> xcategories) {
        this.xcategories = xcategories;
    }

    public List<CostChartsSeriesData> getSeriesData() {
        return seriesData;
    }

    public void setSeriesData(List<CostChartsSeriesData> seriesData) {
        this.seriesData = seriesData;
    }
    
}

