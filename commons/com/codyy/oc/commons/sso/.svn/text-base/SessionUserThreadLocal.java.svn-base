package com.codyy.oc.commons.sso;

public class SessionUserThreadLocal extends ThreadLocal<SessionUser> {
	
	private static SessionUserThreadLocal threadLocal = null;
	
	private SessionUserThreadLocal(){}
	
	public static synchronized SessionUserThreadLocal getInstance(){
		if(threadLocal == null){
			threadLocal = new SessionUserThreadLocal();
		}
		return threadLocal;
	}

	public SessionUser getSessionUser(){
		return super.get();
	}
	
	public void setSessionUser(SessionUser user){
		super.set(user);
	}
}
