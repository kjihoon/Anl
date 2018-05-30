package com.anl.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anl.vo.Setting;

import Rfunction.Rdata;

@Controller
public class TestController {

	
	@RequestMapping("testcon.do")
	@ResponseBody
	public String testcon(HttpSession session) {
		String byebye = "byebye";
		session.setAttribute("a",byebye);
		
		return "sucess";
	}
	@RequestMapping("testcon1.do")
	@ResponseBody
	public String testcon1(HttpSession session) {
		String byebye = (String) session.getAttribute("a");
		System.out.println(byebye);
		byebye="hihi";
		return "sucess1";
	}
	
	@RequestMapping("/testview/testbutton.do")
	public String button() {
		return "testview/testbutton";
	}
	
	@RequestMapping("/testview/testtable.do")
	public String tables(HttpSession session) throws Exception {
		List<List<String>> data =(List<List<String>>) session.getAttribute("data");
		List<String> headername =(List<String>) session.getAttribute("headername");
		Setting set = (Setting) session.getAttribute("typelist");
		List<String> typelist = set.getType();
		Rdata rdata = new Rdata();
		RConnection rconn = rdata.genVar(data, typelist, headername, 6311);
		double [] aa = rconn.eval("df[,1]").asDoubles();
		for (double  ii : aa) {
			System.out.println(ii);
		}
		return "analysis/testview/tables";
	}
}
