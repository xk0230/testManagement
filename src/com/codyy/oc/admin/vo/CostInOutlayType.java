
package com.codyy.oc.admin.vo;

import java.util.List;

/**
 *成本支出类型
 */
public class CostInOutlayType {
    
    private String name;
    
    private List<CostMonthInOut> monthInOut;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<CostMonthInOut> getMonthInOut() {
        return monthInOut;
    }

    public void setMonthInOut(List<CostMonthInOut> monthInOut) {
        this.monthInOut = monthInOut;
    }

}

