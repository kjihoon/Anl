package com.anl.vo;

public class SimpleReg {
	private String x,y;
	private String group;
	private String clientid;
	private String [] varlist= {"group","clientid"};
	public String getX() {
		return x;
	}
	public void setX(String x) {
		this.x = x;
	}
	public String getY() {
		return y;
	}
	public void setY(String y) {
		this.y = y;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public String getClientid() {
		return clientid;
	}
	public void setClientid(String clientid) {
		this.clientid = clientid;
	}
	public String[] getVarlist() {
		return varlist;
	}
	public void setVarlist(String[] varlist) {
		this.varlist = varlist;
	}
}
