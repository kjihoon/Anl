package com.anl.controller;

import java.io.IOException;
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

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {

	/* GoogleLogin */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;

	// 로그인 첫 화면 요청 메소드
	@RequestMapping(value = "client/login.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {

		/* 구글code 발행 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

		System.out.println("구글:" + url);

		model.addAttribute("google_url", url);

		/* 생성한 인증 URL을 View로 전달 */
		return "client/login";
	}

	// 구글 Callback호출 메소드
	@RequestMapping(value = "client/oauth2callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(Model model, @RequestParam String code) throws IOException {
		System.out.println("여기는 googleCallback");

		return "client/googleSuccess";
	}
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/login/login.do",method = { RequestMethod.GET, RequestMethod.POST })
	public String login(CommandMap cmd,HttpSession session,Model model) throws Exception {
		System.out.println(cmd.getMap().toString());
		@SuppressWarnings("rawtypes")
		Map userInfo = (Map) session.getAttribute("userInfo");
		String out="";
		//login interceptor 만들기 전
		if (userInfo==null) {
			if (cmd.get("USERID") !=null &&cmd.get("USERPWD") !=null) {
				userInfo = userService.selectUserOne(cmd.getMap());
				System.out.println(userInfo.toString());
				session.setAttribute("userInfo", userInfo);
				out = "main";
			}else {
				out="login/login";
			}
		}else {
			out = "main";
		}
		return out;
	}
}

