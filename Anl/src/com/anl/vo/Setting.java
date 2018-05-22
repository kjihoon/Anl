package com.anl.vo;

import java.util.List;

public class Setting {
	private List<String> type;
	private String header;
	@Override
	public String toString() {
		return "Setting [type=" + type.toString() + ", header=" + header + "]";
	}
	public List<String> getType() {
		return type;
	}
	public void setType(List<String> type) {
		this.type = type;
	}
	public String getHeader() {
		return header;
	}
	public void setHeader(String header) {
		this.header = header;
	}

}
