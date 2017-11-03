package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.oc.admin.entity.EnvironmentSurvey;

public interface EnvironmentSurveyMapper {
    int deleteByPrimaryKey(String envirSurveyId);

    int insert(EnvironmentSurvey record);

    int insertSelective(EnvironmentSurvey record);

    EnvironmentSurvey selectByPrimaryKey(String envirSurveyId);

    int updateByPrimaryKeySelective(EnvironmentSurvey record);

    int updateByPrimaryKey(EnvironmentSurvey record);

	List<EnvironmentSurvey> getEnvirSurveyByClassroomId(String classroomId);

	int checkEnvirByClassroomId(String classroomId);

	EnvironmentSurvey getEnvirSurvey(String classroomId);

	int updateEnvirSurvey(EnvironmentSurvey environmentSurvey);

	
}