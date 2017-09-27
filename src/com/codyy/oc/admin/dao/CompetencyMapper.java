package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.oc.admin.entity.Competency;

public interface CompetencyMapper {
    int deleteByPrimaryKey(String id);

    int insert(Competency record);

    int insertSelective(Competency record);

    Competency selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Competency record);

    int updateByPrimaryKey(Competency record);
    
    List<Competency> getAll();
    
    List<Competency> getByRecId(String id);
}