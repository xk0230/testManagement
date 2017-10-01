package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.oc.admin.entity.Department;

public interface DepartmentMapper {
    int deleteByPrimaryKey(String depId);

    int insert(Department record);

    int insertSelective(Department record);

    Department selectByPrimaryKey(String depId);

    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);
    
    List<Department> getAllDep();
    
    int hasManager(String depId);
    
    String getDepManagerId(String depId);
}