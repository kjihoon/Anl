package com.anl.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String tables() {
		return "analysis/testview/tables";
	}
}
