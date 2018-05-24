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

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class AnlController {
	@RequestMapping("/anldata/dataupload.do")
	public String dataupload(Model model) {
	
		model.addAttribute("center","dataupload");
		return "main";
	}
	
	@RequestMapping(value="/anldata/datasetting.do", method=RequestMethod.POST)
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
		
		model.addAttribute("center","datasetting");		
		List<Integer> ncolumn = new ArrayList<>();
		for (int i=1;i<=data.get(0).size();i++)
			ncolumn.add(i);
		model.addAttribute("ncolumn",ncolumn);
		model.addAttribute("firstrow",data.get(0));
		model.addAttribute("secondrow",data.get(1));
		return "main";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/anldata/redirectdatasetting.do")
	public String redirectstep2(Model model,HttpSession session) {
		
		List<List<String>> data =(List<List<String>>) session.getAttribute("data");
		if (data==null) {
			model.addAttribute("center","dataupload");
		}else {
			List<Integer> ncolumn = new ArrayList<>();
			for (int i=1;i<=data.get(0).size();i++)
				ncolumn.add(i);
			model.addAttribute("ncolumn",ncolumn);
			model.addAttribute("firstrow",data.get(0));
			model.addAttribute("secondrow",data.get(1));
			model.addAttribute("center","datasetting");
		}		
		return "main";
	}
}
