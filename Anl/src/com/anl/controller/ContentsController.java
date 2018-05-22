package com.anl.controller;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.anl.common.CommandMap;
import com.anl.contents.ContentsService;

@Controller
public class ContentsController {

	@Autowired
	private ContentsService contentsService;
	
	@RequestMapping("contents/main.do")
	public String contentsmain() throws Exception {
		
		CommandMap cmd = new CommandMap();
		cmd.put("contentidx", "1");
		Map map =contentsService.selectContentsOne(cmd.getMap());
		System.out.println(map.toString());
		return "contentsmain";
	}
	
	

	
}
