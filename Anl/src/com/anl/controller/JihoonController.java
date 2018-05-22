package com.anl.controller;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.anl.vo.Setting;

import functionSet.OtherFun;

@Controller
public class JihoonController {
	Logger log = Logger.getLogger(this.getClass());
	@RequestMapping("/analysis/main.do")
	public String main() {
		return "analysis/main";
	}
	@RequestMapping("/analysis/step1.do")
	public String step1(Model m,HttpSession session) {
		session.removeAttribute("dataob");
		m.addAttribute("center","step1");
		return "analysis/main";
	}
	@RequestMapping(value="/analysis/step2.do", method=RequestMethod.POST)
	public String upload(@RequestParam("uploadfile") MultipartFile uploadfile,Model model, HttpSession session) {
		List<List<String>> data = new ArrayList<List<String>>();
		String filename = uploadfile.getOriginalFilename();		
		BufferedReader reader =null;
		
	    try {
	    	  Charset.forName("UTF-8");
		      reader = new BufferedReader(new InputStreamReader(new ByteArrayInputStream(uploadfile.getBytes())));
		      String line;		      
		      while ((line = reader.readLine()) != null) {
		        List<String> tmp = new ArrayList<String>();
				String arr[] = line.split(",");
				tmp = Arrays.asList(arr);
				data.add(tmp);
		      }  
		} catch (IOException e1) {
			e1.printStackTrace();
		} finally {
			try {
				if(reader !=null)
					reader.close();
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
	  
	    session.setAttribute("filename", filename);
		session.setAttribute("data", data);
		
		model.addAttribute("center","step2");		
		List<Integer> ncolumn = new ArrayList<>();
		for (int i=1;i<=data.get(0).size();i++)
			ncolumn.add(i);
		model.addAttribute("ncolumn",ncolumn);
		model.addAttribute("firstrow",data.get(0));
		//setting 재요청시 remove 필요 setting 재요청 들어오지 않는 로직으로 짰으나 재수정 필요가능성 충분!!
		return "analysis/main";
	}
	@SuppressWarnings("unchecked")
	@RequestMapping("/analysis/redirectstep2.do")
	public String redirectstep2(Model model,HttpSession session) {
		
		List<List<String>> data =(List<List<String>>) session.getAttribute("data");
		if (data==null) {
			model.addAttribute("warning","Data Upload를 해주세요!");
			model.addAttribute("center","step1");
		}else {
			List<Integer> ncolumn = new ArrayList<>();
			for (int i=1;i<=data.get(0).size();i++)
				ncolumn.add(i);
			model.addAttribute("ncolumn",ncolumn);
			model.addAttribute("firstrow",data.get(0));
			//setting 재요청시 remove 필요 setting 재요청 들어오지 않는 로직으로 짰으나 재수정 필요가능성 충분!!
			model.addAttribute("center","step2");
		}		
		return "analysis/main";
	}
	
	
	@RequestMapping("/analysis/redirectstep3.do")
	public String redirectstep3(Model model,HttpSession session) {
		if (session.getAttribute("headername")==null) {
			model.addAttribute("warning","Data Upload를 해주세요!");
			model.addAttribute("center","step1");
		}else {
			model.addAttribute("center","step32");
		}		
		return "analysis/main";
	}
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/analysis/step3.do")
	public String setting(Model model,HttpSession session,Setting set) {
		List<List<String>> data =(List<List<String>>) session.getAttribute("data");
		//session.removeAttribute("data"); //remove data session, **convert to json 
		List<String> typelist =set.getType();
		String headerinfo = set.getHeader();

		//headerinfo setting
		List<String> headername = new ArrayList<String>();
		int start=0; //문자 포함 여부 확인하기
		if (headerinfo.equals("t")) {
			start = 1;
			List<String> header =  new ArrayList<String>();
			header = data.get(0); //header name
			for (int i=0;i<header.size();i++)
				headername.add(header.get(i).replaceAll("\\p{Z}", ""));
		}else {
			for (int i =1;i<data.get(0).size()+1;i++) {
				headername.add("V"+i); //header name
			}				
		}
		String textcheck = "";
		for (int i =0;i<data.get(0).size();i++) {
			if ((typelist.get(i)).equals("numeric")) {
				roop1 :for (int j=start;j<data.size();j++) {
					if(!new OtherFun().checkrealnum(data.get(j).get(i))) {
						textcheck += ""+(i+1)+", ";
						break roop1; 
					}
				}
			}
		}
		if (textcheck.length()>1) {
			model.addAttribute("warning",textcheck+"행에 문자가 포함되어있씁니다.");
			model.addAttribute("redirect", "/Anl/analysis/redirectstep2.do");
		}else {
			//spread sheet javascript code로 옮겨야함!!!!! view안에서 로직 돌리자 그냥 데이터 유지 ㄴㄴ해
			JSONObject jo = null; //data information
			JSONObject no = null; // rotation
			JSONArray  jr = new JSONArray(); // Each coloumn information
			JSONArray  hn = new JSONArray(); // headername arr(JSON)		
			for (int i =0;i<headername.size();i++) {
				jo =new JSONObject();
				jo.put("data", headername.get(i));
				jo.put("type", typelist.get(i));
				
				if ((typelist.get(i)).equals("numeric")) {				
					no =new JSONObject();
					no.put("pattern", "0.000");
					jo.put("numericFormat", no);
				}
				jr.add(jo);
				hn.add(headername.get(i));
			}		
			
			JSONArray  dataob = new JSONArray();
			
			
			if (headerinfo.equals("t")) {			
				for (int i = 1;i<data.size();i++) {
					jo = new JSONObject();
					for(int j=0;j<data.get(0).size();j++) {
						jo.put(headername.get(j),data.get(i).get(j));
					}
					dataob.add(jo);
				}
			}else {
				for (int i = 0;i<data.size();i++) {
					jo = new JSONObject();
					for(int j=0;j<data.get(0).size();j++) {
						jo.put(headername.get(j),data.get(i).get(j));
					}
					dataob.add(jo);
				}
			}
			
			
					
			//sheet view session
			session.setAttribute("hn",hn.toJSONString());
			session.setAttribute("jr", jr.toJSONString());
			session.setAttribute("dataob", dataob.toJSONString());
			session.setAttribute("sheet","step3");
			session.setAttribute("set", set);
			
		   
			//importance things
			session.setAttribute("headername", headername);
			session.setAttribute("typelist", typelist);
			model.addAttribute("center","step32"); //반드시 수정 필요 (center에 넣을 뷰가 없어서 해놓음)
		}
		
		return "analysis/main";
		
	}


}
