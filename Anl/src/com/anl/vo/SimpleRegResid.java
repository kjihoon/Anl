package com.anl.vo;

import java.util.List;

public class SimpleRegResid {
	private List<String> x;
	private String y;
	private String clientid;
	private String maxlag;
	private String [] varlist= {"maxlag","clientid"};
	public List<String> getX() {
		return x;
	}
	public String[] getVarlist() {
		return varlist;
	}
	public void setX(List<String> x) {
		this.x = x;
	}
	public String getY() {
		return y;
	}
	public void setY(String y) {
		this.y = y;
	}
	public String getClientid() {
		return clientid;
	}
	public void setClientid(String clientid) {
		this.clientid = clientid;
	}
	public String getMaxlag() {
		return maxlag;
	}
	public void setMaxlag(String maxlag) {
		this.maxlag = maxlag;
	}

}
