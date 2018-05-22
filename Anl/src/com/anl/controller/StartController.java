package com.anl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StartController {

	
	@RequestMapping("/start/main.do")
	public String main() {
		return "/start/main";
	}
	@RequestMapping("/start/generic.do")
	public String generic() {
		return "/start/generic";
	}
	@RequestMapping("/start/element.do")
	public String element() {
		return "/start/element";
	}
}
