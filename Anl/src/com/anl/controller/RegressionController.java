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
}
