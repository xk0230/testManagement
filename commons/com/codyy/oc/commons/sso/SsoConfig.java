package com.codyy.oc.commons.sso;

public class SsoConfig {
	
	private String app;
	private String key;
	private String authUrl;
	private String checkUrl;
	private String redirectUrl;
	
	public String getApp() {
		return app;
	}
	public void setApp(String app) {
		this.app = app;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getAuthUrl() {
		return authUrl;
	}
	public void setAuthUrl(String authUrl) {
		this.authUrl = authUrl;
	}
	public String getCheckUrl() {
		return checkUrl;
	}
	public void setCheckUrl(String checkUrl) {
		this.checkUrl = checkUrl;
	}
	public String getRedirectUrl() {
		return redirectUrl;
	}
	public void setRedirectUrl(String redirectUrl) {
		this.redirectUrl = redirectUrl;
	}

}
