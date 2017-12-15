package com.codyy.oc.admin.vo;

import java.util.Comparator;

public class CostChartsSeriesDataComparator implements Comparator<CostChartsSeriesData>{

	@Override
	public int compare(CostChartsSeriesData c1, CostChartsSeriesData c2) {
			if (Integer.parseInt(c1.getName()) < Integer.parseInt(c2.getName())){
				return -1;
			}else if(Integer.parseInt(c1.getName()) == Integer.parseInt(c2.getName())) {
				return 0;
			}else  {
				return 1;
			}
		}

}
