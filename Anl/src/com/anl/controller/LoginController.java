package com.anl.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.anl.common.CommandMap;
import com.anl.user.UserService;

@Controller
public class LoginController {

	private int clientNum =0;
	
	
	/* GoogleLogin */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;

	// �α��� ù ȭ�� ��û �޼ҵ�
	@RequestMapping(value = "client/login.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {

		/* ����code ���� */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

		System.out.println("����:" + url);

		model.addAttribute("google_url", url);

		/* ������ ���� URL�� View�� ���� */
		return "client/login";
	}

	// ���� Callbackȣ�� �޼ҵ�
	@RequestMapping(value = "client/oauth2callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(Model model, @RequestParam String code) throws IOException {
		System.out.println("����� googleCallback");

		return "client/googleSuccess";
	}
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/login/login.do")
	public String login() {
		return "login/login";
	}
	
	
	@RequestMapping(value="/login/loginimp.do",method = { RequestMethod.GET, RequestMethod.POST })
	public String loginimp(CommandMap cmd,HttpSession session,Model model) throws Exception {
		System.out.println(cmd.getMap().toString());
		String out="";
		Map<String, Object> userInfo =new HashMap<>();
		if (cmd.get("USERID")!=null) { 
			userInfo = userService.selectUserOne(cmd.getMap());//actual client Info	
			if (userInfo==null) {
				System.out.println("�α��� ����");
				out="login/login";
			}else {			
				session.setAttribute("userInfo", userInfo);
				out = "main";
			}
		}else { //if try login page without ID and PWE..
			out = "login/login";
		}
		return out;
	}
}

