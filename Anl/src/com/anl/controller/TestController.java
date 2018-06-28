package com.anl.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anl.common.CommandMap;
import com.anl.user.UserService;

@Controller
public class TestController {

	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/dbtest.do")
	@ResponseBody
	public String dbtest() throws Exception {
		CommandMap cmd = new CommandMap();
		List<Map<String, Object>>  map = userService.selectUserList(cmd.getMap());
		
		System.out.println(map.toString());
		
		return "sdf";
	}
}
