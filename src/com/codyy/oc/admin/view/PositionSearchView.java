package com.codyy.oc.admin.view;

import com.codyy.oc.admin.entity.Position;
import com.codyy.oc.admin.entity.PositionAudit;

public class PositionSearchView extends Position{
	
	private PositionAudit audit;

	public PositionAudit getAudit() {
		return audit;
	}

	public void setAudit(PositionAudit audit) {
		this.audit = audit;
	}
	
	
	
}
