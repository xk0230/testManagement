package com.codyy.oc.admin.vo;

import java.util.List;

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

