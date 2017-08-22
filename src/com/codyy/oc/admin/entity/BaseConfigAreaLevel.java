package com.codyy.oc.admin.entity;

public class BaseConfigAreaLevel {
    private String baseConfigAreaLevelId;

    private Integer areaLevel;

    private String levelTitle;

    private String mobileTitle;

    public String getBaseConfigAreaLevelId() {
        return baseConfigAreaLevelId;
    }

    public void setBaseConfigAreaLevelId(String baseConfigAreaLevelId) {
        this.baseConfigAreaLevelId = baseConfigAreaLevelId;
    }

    public Integer getAreaLevel() {
        return areaLevel;
    }

    public void setAreaLevel(Integer areaLevel) {
        this.areaLevel = areaLevel;
    }

    public String getLevelTitle() {
        return levelTitle;
    }

    public void setLevelTitle(String levelTitle) {
        this.levelTitle = levelTitle;
    }

    public String getMobileTitle() {
        return mobileTitle;
    }

    public void setMobileTitle(String mobileTitle) {
        this.mobileTitle = mobileTitle;
    }
}