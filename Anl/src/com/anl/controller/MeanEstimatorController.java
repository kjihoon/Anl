package com.anl.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anl.common.CommandMap;
import com.anl.vo.Setting;
import com.anl.vo.Ttest;

import Rfunction.Rdata;
import Rfunction.Rsource;

@Controller
public class MeanEstimatorController {

	@SuppressWarnings("unchecked")
	@RequestMapping("/meanestimator/ttest.do")
	@ResponseBody
	public String ttest(Model model,HttpSession session,CommandMap map) throws ParseException {
		Map<String,String> userInfo = (Map<String, String>) session.getAttribute("userInfo");
		List<List<String>> data =(List<List<String>>) session.getAttribute("data");
		List<String> headername =(List<String>) session.getAttribute("headername");
		Setting set = (Setting) session.getAttribute("typelist");
		
		List<String> typelist = set.getType();
		Rdata rdata = new Rdata();
		RConnection rconn=null;
		String cmd ="";
		String userid=userInfo.get("USERID");
		//pre handling
		Set<String> checkset = new HashSet<>();
		for (String key:map.getMap().keySet()) {
			if (map.getMap().get(key).equals("")) {
				checkset.add(key);
			}			
		}
		map.getMap().keySet().removeAll(checkset);
		map.put("clientid", "'"+userid+"'");
		if (map.containsKey("x0")) {
			map.remove("x0");
		}
		if (map.get("alternative")!=null) {
			String alternative =(String) map.get("alternative");
			map.getMap().replace("alternative", "'"+alternative+"'");
		}
		cmd = map.getMap().toString();
		int startIdx = cmd.indexOf("{");
		int endIdx = cmd.indexOf("}");
		cmd =cmd.substring(startIdx+1, endIdx);
		
		JSONObject jo = new JSONObject();
		try {
				rconn = rdata.genVar(data, typelist, headername, 6311);
				new Rsource();
				String rs = Rsource.getTtest();
				rconn.eval(rs);
				cmd ="model<-fun_ttest("+cmd+")";
				System.out.println("Rcommand :"+cmd);
				rconn.eval(cmd);				
				String [] result = rconn.eval("model$result").asStrings();
				JSONArray jr = new JSONArray();
				for (String s : result) {
					jr.add(s+"<br>");
				}
				jo.put("result", jr);
				jo.put("xvar", map.get("x"));
				jo.put("imgpath1", "/Anl/img/"+userid+"ttest_hist.png");
				jo.put("imgpath2", "/Anl/img/"+userid+"ttest_box.png");
			

		} catch (Exception e) {
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
	@RequestMapping("/meanestimator/ttest2.do")
	@ResponseBody
	public String ttest2(Model model,HttpSession session,CommandMap map) throws ParseException {
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
		//pre handling
				Set<String> checkset = new HashSet<>();
				
				map.put("x",map.get("x0"));map.remove("x0");
				map.put("mu",map.get("mu2"));map.remove("mu2");
				map.put("conflevel",map.get("conflevel2"));map.remove("conflevel2");
				map.put("alternative",map.get("alternative2"));map.remove("alternative2");
				map.put("clientid", "'"+userid+"'");
				for (String key:map.getMap().keySet()) {
					if (map.getMap().get(key).equals("")) {
						checkset.add(key);
					}			
				}
				if (map.containsKey("_")) {
					map.remove("_");
				}
				
				map.getMap().keySet().removeAll(checkset);
				
				if (map.get("alternative")!=null) {
					String alternative =(String) map.get("alternative");
					map.getMap().replace("alternative", "'"+alternative+"'");
				}
				cmd = map.getMap().toString();
				int startIdx = cmd.indexOf("{");
				int endIdx = cmd.indexOf("}");
				cmd =cmd.substring(startIdx+1, endIdx);
				
		JSONObject jo = new JSONObject();
		try {
			rconn = rdata.genVar(data, typelist, headername, 6311);
			new Rsource();
			String rs = Rsource.getTtest();
			rconn.eval(rs);
			cmd ="model<-fun_ttest("+cmd+")";
			System.out.println("Rcommand :"+cmd);
			rconn.eval(cmd);				
			String [] result = rconn.eval("model$result").asStrings();
			JSONArray jr = new JSONArray();
			for (String s : result) {
				jr.add(s+"<br>");
			}
			jo.put("result", jr);
			jo.put("xvar", "x: "+map.get("x")+"<br> y:"+map.get("y"));
			jo.put("imgpath1", "/Anl/img/"+userid+"ttest_hist.png");
			jo.put("imgpath2", "/Anl/img/"+userid+"ttest_box.png");	
			

		} catch (Exception e) {
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

}
