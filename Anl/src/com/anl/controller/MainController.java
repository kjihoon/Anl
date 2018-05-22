package com.anl.controller;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	Logger log = Logger.getLogger(this.getClass());
	
	
	@RequestMapping("/analysis/manual.do")
	public String manual(Model m) {
		m.addAttribute("center","manual");
		return "analysis/main";
	}

	@RequestMapping("/analysis/about.do")
	public String about(Model m) {
		m.addAttribute("center","about");
		return "analysis/main";
	}
	
	
	@RequestMapping("/analysis/cancle.do")
	public String cancle(HttpSession session) {
		session.invalidate();
		return "analysis/main";
	}

	
}



