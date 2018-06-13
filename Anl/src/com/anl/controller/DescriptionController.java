package com.anl.controller;

import java.util.List;
import java.util.Map;

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
public class DescriptionController {
	
	@RequestMapping("description/normaltest.do")
	@ResponseBody
	public String normal(CommandMap map,HttpSession session,Model model) {
		Map<String,String> userInfo = (Map<String, String>) session.getAttribute("userInfo");
		List<List<String>> data =(List<List<String>>) session.getAttribute("data");
		List<String> headername =(List<String>) session.getAttribute("headername");
		Setting set = (Setting) session.getAttribute("typelist");
		List<String> typelist = set.getType();
		Rdata rdata = new Rdata();
		RConnection rconn=null;
		String cmd ="";
		String userid=userInfo.get("USERID");
		map.put("clientid", "'"+userid+"'");
		cmd = map.getMap().toString();
		int startIdx = cmd.indexOf("{");
		int endIdx = cmd.indexOf("}");
		cmd =cmd.substring(startIdx+1, endIdx);
		System.out.println("Rcommand"+cmd);
		JSONObject jo = new JSONObject();
		try {
				rconn = rdata.genVar(data, typelist, headername, 6311);
				new Rsource();
				String rs = Rsource.getNormal();
				rconn.eval(rs);
				cmd ="model<- fun_normal("+cmd+")";
				rconn.eval(cmd);				
				String [] result = rconn.eval("model$shapiro").asStrings();
				JSONArray jr = new JSONArray();
				for (String s : result) {
					jr.add(s+"<br>");
				}
				jo.put("result", jr);
				jo.put("xvar", map.get("x"));
				
				jo.put("imgpath1", "/Anl/img/"+userid+"normal_dist.png");
				jo.put("imgpath2", "/Anl/img/"+userid+"normal_qq.png");
			

		} catch (Exception e) {
			e.printStackTrace();
			jo.put("result","Exception error");
		}finally {
			if (rconn!=null) {
				rconn.close();
			}
		}
		
		
		
		return jo.toJSONString();
	}
}
