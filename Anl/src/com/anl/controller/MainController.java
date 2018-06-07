package com.anl.controller;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
//����� ���� ���� ���ذ�
@Controller
public class MainController {
	
	@RequestMapping("/anldata/mainpage.do")
	public String mainpage() {
		return "main";
	}
	@RequestMapping("/anldata/cancle.do")
	public String cancle(HttpSession session) {
		session.invalidate();
		return "login";
	}

	


	
}



