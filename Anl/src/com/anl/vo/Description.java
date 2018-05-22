package com.anl.vo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Description {
	double mean,var,max,min;
	String name,type;
	String mapresult;
	Map<String, Integer> dummy;
	
	
	public String getMapresult() {
		if (dummy == null) {
			mapresult = "";
		}else {
			mapresult = dummy.toString();
		}		
		return mapresult;
	}


	public Map<String, Integer> getDummy() {
		return dummy;
	}

	
	


	public void setDummy(Map<String, Integer> dummy) {
		this.dummy = dummy;
	}

	public Map<String, Integer> getDummy(List<String> list){
		Map<String, Integer> countMap = new HashMap<>();
		  for (String item: list) {
		      if (countMap.containsKey(item))
		          countMap.put(item, countMap.get(item) + 1);
		      else
		          countMap.put(item, 1);
		  }
		  return countMap;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	

	

	@Override
	public String toString() {
		return "Description [mean=" + mean + ", var=" + var + ", max=" + max + ", min=" + min + ", name=" + name
				+ ", type=" + type + ", dummy=" + dummy + "]";
	}

	public double getMean() {
		
		return mean;
	}

	public void setMean(double mean) {
		mean = Double.parseDouble(String.format("%.3f", mean));
		this.mean = mean;
	}

	public double getVar() {
		return var;
	}

	public void setVar(double var) {
		var = Double.parseDouble(String.format("%.3f", var));
		this.var = var;
	}

	public double getMax() {
		return max;
	}

	public void setMax(double max) {
		this.max = max;
	}

	public double getMin() {
		return min;
	}

	public void setMin(double min) {
		this.min = min;
	}
}
