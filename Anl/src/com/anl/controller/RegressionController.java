package com.anl.controller;

import java.io.File;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anl.common.CommandMap;
import com.anl.vo.Setting;

import Rfunction.Rdata;
import Rfunction.Rsource;

@Controller
public class RegressionController {

	
	@SuppressWarnings("unchecked")
	@RequestMapping("regression/simplereg.do")
	@ResponseBody
	public String simplereg(CommandMap map,Model model,HttpSession session) {
		System.out.println("param"+map.getMap().toString());
		Map<String,String> userInfo = (Map<String, String>) session.getAttribute("userInfo");
		List<List<String>> data =(List<List<String>>) session.getAttribute("data");
		List<String> headername =(List<String>) session.getAttribute("headername");
		Setting set = (Setting) session.getAttribute("typelist");
		List<String> typelist = set.getType();
		Rdata rdata = new Rdata();
		RConnection rconn=null;
		String cmd ="";
		String userid=userInfo.get("USERID");
		Set<String> checkset = new HashSet<>();
		map.put("formula", map.get("y")+"~"+map.get("x"));
		map.remove("x");map.remove("y");
		map.put("clientid", "'"+userid+"'");
		for (String key:map.getMap().keySet()) {
			if (map.getMap().get(key).equals("")) {
				checkset.add(key);
			}			
		}
		map.getMap().keySet().removeAll(checkset);
		cmd = map.getMap().toString();
		int startIdx = cmd.indexOf("{");
		int endIdx = cmd.indexOf("}");
		cmd =cmd.substring(startIdx+1, endIdx);
		System.out.println("cmd:"+cmd);
		JSONObject jo = new JSONObject();
		try {
			rconn = rdata.genVar(data, typelist, headername, 6311);
			new Rsource();
			String rs = Rsource.getSimplereg();
			rconn.eval(rs);
			rconn.eval("model<-fun_simplereg("+cmd+")");
			
			String [] result = rconn.eval("model$summary").asStrings();
			String [] beta = rconn.eval("model$beta").asStrings();
			String rsq = rconn.eval("model$rsq").asString()+"%";
			JSONArray jr = new JSONArray();
			for (String s : result) {
				jr.add(s+"<br>");
			}
			JSONArray jrbeta = new JSONArray();
			for (String s : beta) {
				jrbeta.add(s);
			}
			jo.put("result", jr);
			jo.put("beta",jrbeta);
			jo.put("rsq", rsq);
			jo.put("formula", map.get("formula"));
			
			jo.put("imgpath1", "/Anl/img/"+userid+"reg_line.png");
			jo.put("imgpath2", "/Anl/img/"+userid+"reg_psy.png");	
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("t-test error");
			jo.put("result","Exception error");
		}finally {
			if (rconn!=null) {
				rconn.close();
			}
		}
		return jo.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("regression/simpleregresid.do")
	@ResponseBody
	public String simpleregresid(CommandMap map,Model model,HttpSession session) {
		
		
		System.out.println("param"+map.getMap().toString());
		Map<String,String> userInfo = (Map<String, String>) session.getAttribute("userInfo");
		List<List<String>> data =(List<List<String>>) session.getAttribute("data");
		List<String> headername =(List<String>) session.getAttribute("headername");
		Setting set = (Setting) session.getAttribute("typelist");
		List<String> typelist = set.getType();
		Rdata rdata = new Rdata();
		RConnection rconn=null;
		String cmd ="";
		String userid=userInfo.get("USERID");
		Set<String> checkset = new HashSet<>();
		map.put("formula", map.get("y")+"~"+map.get("x"));
		map.remove("x");map.remove("y");
		map.put("clientid", "'"+userid+"'");
		for (String key:map.getMap().keySet()) {
			if (map.getMap().get(key).equals("")) {
				checkset.add(key);
			}			
		}
		map.getMap().keySet().removeAll(checkset);
		cmd = map.getMap().toString();
		int startIdx = cmd.indexOf("{");
		int endIdx = cmd.indexOf("}");
		cmd =cmd.substring(startIdx+1, endIdx);
		System.out.println("cmd:"+cmd);
		JSONObject jo = new JSONObject();
		try {
			rconn = rdata.genVar(data, typelist, headername, 6311);
			new Rsource();
			String rs = Rsource.getSimplereg();
			rconn.eval(rs);
			rconn.eval("model<-fun_simplereg_resid("+cmd+")");
			String [] residtest = rconn.eval("model$residtest").asStrings();
			String [] influence = rconn.eval("model$influence").asStrings();
			JSONArray residjr = new JSONArray();
			JSONArray influjr = new JSONArray();
			for (String s : residtest) {
				residjr.add(s+"<br>");
			}
			for (String s : influence) {
				influjr.add(s+"<br>");
			}
			jo.put("residtest", residjr);
			jo.put("residinfluence",influjr);
			jo.put("imgpath1", "/Anl/img/"+userid+"reg_resid.png");
			jo.put("imgpath2", "/Anl/img/"+userid+"reg_influence.png");
			jo.put("imgpath3", "/Anl/img/"+userid+"reg_influence2.png");
			
		}catch (Exception e) {
			
		}finally {
			if (rconn!=null) {
				rconn.close();
			}
		}

		return jo.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("regression/multiregresid.do")
	@ResponseBody
	public String multiregresid(CommandMap map,Model model,HttpSession session) {
		System.out.println("param"+map.getMap().toString());
		Map<String,String> userInfo = (Map<String, String>) session.getAttribute("userInfo");
		List<List<String>> data =(List<List<String>>) session.getAttribute("data");
		List<String> headername =(List<String>) session.getAttribute("headername");
		Setting set = (Setting) session.getAttribute("typelist");
		List<String> typelist = set.getType();
		Rdata rdata = new Rdata();
		RConnection rconn=null;
		String cmd ="";
		String userid=userInfo.get("USERID");
		Set<String> checkset = new HashSet<>();
		String formula ="";
		for (String key:map.getMap().keySet()) {
			if (map.getMap().get(key).equals("")) {
				checkset.add(key);
			}else {
				if (key.substring(0,1).equals("x")) {
					formula += map.get(key)+"+";
				}
			}
		}
		
		map.getMap().keySet().removeAll(checkset);
		formula =map.get("y")+"~"+formula.substring(0, formula.length()-1);
		cmd += "formula="+formula+",clientid='"+userid+"'";
		if (map.get("dw")!=null) {
			cmd +=",max.lag="+map.get("dw");
		}
		System.out.println("Rparam:"+cmd);
		JSONObject jo = new JSONObject();
		try {
			rconn = rdata.genVar(data, typelist, headername, 6311);
			new Rsource();
			String rs = Rsource.getMultireg();
			rconn.eval(rs);
			rconn.eval("model<-fun_multireg_resid("+cmd+")");
			
			if (map.get("dw")!=null) {
				String [] dw =rconn.eval("model$dw").asStrings();
				JSONArray dwjr= new JSONArray();
				for (String a: dw) {
					dwjr.add(a+"<br>");
				}
				jo.put("dw", dwjr);
			}			
			String [] residtest =rconn.eval("model$residtest").asStrings();
			JSONArray residtestjr = new JSONArray();			
			for (String a: residtest) {
				residtestjr.add(a+"<br>");
			}
			
			String [] residinfluence =rconn.eval("model$influence").asStrings();
			JSONArray residinfluencejr = new JSONArray();			
			for (String a: residinfluence) {
				residinfluencejr.add(a+"<br>");
			}
			jo.put("residinfluence", residinfluencejr);
			jo.put("residtest", residtestjr);
			jo.put("imgpath1", "/Anl/img/"+userid+"multireg_resid.png");
			jo.put("imgpath2", "/Anl/img/"+userid+"multireg_influence.png");
			jo.put("imgpath3", "/Anl/img/"+userid+"multireg_influence2.png");
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("multi reg resid r error");
		}finally {
			if (rconn!=null) {
				rconn.close();
			}
		}
		System.out.println(jo.toJSONString());
		return jo.toJSONString();
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("regression/multireg.do")
	@ResponseBody
	public String multireg(CommandMap map,Model model,HttpSession session) {
		System.out.println("param"+map.getMap().toString());
		Map<String,String> userInfo = (Map<String, String>) session.getAttribute("userInfo");
		List<List<String>> data =(List<List<String>>) session.getAttribute("data");
		List<String> headername =(List<String>) session.getAttribute("headername");
		Setting set = (Setting) session.getAttribute("typelist");
		List<String> typelist = set.getType();
		Rdata rdata = new Rdata();
		RConnection rconn=null;
		String cmd ="";
		String userid=userInfo.get("USERID");
		Set<String> checkset = new HashSet<>();
		String formula ="";
		for (String key:map.getMap().keySet()) {
			if (map.getMap().get(key).equals("")) {
				checkset.add(key);
			}else {
				if (key.substring(0,1).equals("x")) {
					formula += map.get(key)+"+";
				}
			}
		}
		
		map.getMap().keySet().removeAll(checkset);
		formula =map.get("y")+"~"+formula.substring(0, formula.length()-1);
		cmd += "formula="+formula+",clientid='"+userid+"'";
		System.out.println("Rparam:"+cmd);
		JSONObject jo = new JSONObject();
		try {
			rconn = rdata.genVar(data, typelist, headername, 6311);
			new Rsource();
			String rs = Rsource.getMultireg();
			rconn.eval(rs);
			rconn.eval("model<-fun_multireg("+cmd+")");
			String [] result =rconn.eval("model$summary").asStrings();
			String [] aov =rconn.eval("model$aov").asStrings();
			String [] vif =rconn.eval("model$vif").asStrings();
			String [] beta=rconn.eval("model$beta").asStrings();
			String [] xnames=rconn.eval("model$xnames").asStrings();
			JSONArray resultjr= new JSONArray();
			JSONArray aovjr = new JSONArray();
			JSONArray vifjr = new JSONArray();
			JSONArray betajr = new JSONArray();
			JSONArray xnamesjr = new JSONArray();
			for (String r: result) {
				resultjr.add(r+"<br>");
			}
			for (String a: aov) {
				aovjr.add(a+"<br>");
			}
			for (String a: vif) {
				vifjr.add(a+"<br>");
			}
			for (String a: beta) {
				betajr.add(a);
			}
			for (String a: xnames) {
				xnamesjr.add(a);
			}
			jo.put("result", resultjr);
			jo.put("aov", aovjr);
			jo.put("vif", vifjr);
			jo.put("beta", betajr);
			jo.put("xnames", xnamesjr);
			jo.put("imgpath1", "/Anl/img/"+userid+"multireg_psy.png");
			
		}catch(Exception e) {
			System.out.println("multi reg r error");
		}finally {
			if (rconn!=null) {
				rconn.close();
			}
		}
		return jo.toJSONString();
	}

}
