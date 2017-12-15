package com.codyy.oc.admin.task;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.codyy.oc.admin.entity.CandidateRInterviewer;
import com.codyy.oc.admin.service.CandidateService;

public class TestTask {
    @Autowired
    private CandidateService candidateService;
    
	public void test() {
		
		System.out.println("定时发送邮件");
		List<CandidateRInterviewer> ls = candidateService.getYesterday();
		for (CandidateRInterviewer c : ls) {
			System.out.println(c.getId());
			System.out.println(c.getPlace());
		}
		System.out.println(ls.size());
	}
}