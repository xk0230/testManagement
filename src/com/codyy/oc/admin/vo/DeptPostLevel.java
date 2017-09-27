
package com.codyy.oc.admin.vo;

import java.util.List;


public class DeptPostLevel {
    
    private String depName;
    
    private List<PostLevel> postLevels;

    public String getDepName() {
        return depName;
    }

    public void setDepName(String depName) {
        this.depName = depName;
    }

    public List<PostLevel> getPostLevels() {
        return postLevels;
    }

    public void setPostLevels(List<PostLevel> postLevels) {
        this.postLevels = postLevels;
    }
    
}

