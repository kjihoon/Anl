package com.anl.vo;

import java.util.Arrays;
import java.util.List;

public class Ttest {
   
    private String x,y,alternative,mu,paired,varequal,conflevel,clientid,x0;


	private String[] varlist = {"x","y","alternative","mu","paired","varequal","conflevel","clientid"};
	@Override
	public String toString() {
		return "Ttest [x=" + x + ", y=" + y + ", alternative=" + alternative + ", mu=" + mu + ", paired=" + paired
				+ ", varequal=" + varequal + ", conflevel=" + conflevel + ", clientid=" + clientid + ", varlist="
				+ Arrays.toString(varlist) + "]";
	}

	
	
    public String getX0() {
		return x0;
	}

	public void setX0(String x0) {
		this.x0 = x0;
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

	public String getAlternative() {
		return alternative;
	}

	public void setAlternative(String alternative) {
		this.alternative = alternative;
	}

	public String getMu() {
		return mu;
	}

	public void setMu(String mu) {
		this.mu = mu;
	}



	public String getPaired() {
		return paired;
	}

	public void setPaired(String paired) {
		this.paired = paired;
	}

	public String getVarequal() {
		return varequal;
	}

	public void setVarequal(String varequal) {
		this.varequal = varequal;
	}

	public String getConflevel() {
		return conflevel;
	}

	public void setConflevel(String conflevel) {
		this.conflevel = conflevel;
	}
    
}
