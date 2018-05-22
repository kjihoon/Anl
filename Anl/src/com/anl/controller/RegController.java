package com.anl.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.anl.vo.SimpleReg;
import com.anl.vo.SimpleRegResid;

import Rfunction.DataHandle;
import Rfunction.Rsource;

@Controller
public class RegController {

	
	@SuppressWarnings("unchecked")
	@RequestMapping("/analysis/regression/simplereg.do")
	public String simplereg(Model model,HttpSession session,SimpleReg reg,HttpServletRequest req) throws ParseException {
		
		
		List<String> typelist = (List<String>) session.getAttribute("typelist");
		List<String> headername = (List<String>) session.getAttribute("headername");
		String data = (String) session.getAttribute("dataob"); //json arr(json set) string !!	
		DataHandle dh= new DataHandle();
		RConnection rconn =null;		
		try {
			if (reg.getX()!=null) {
				rconn = dh.genVar(data,headername,typelist,6311);
				new Rsource();
				String rs = Rsource.getSimplereg();
				rconn.eval(rs);
				String cmd = "";
				
				//formula
				String formula ="formula="+reg.getY()+"~"+reg.getX();
				cmd +=formula;
				
				//others (variable parameter)
				List<String> list = new ArrayList<>();
				list.add(reg.getGroup());
				list.add("'"+reg.getClientid()+"'");
				
				for (int i =0;i<list.size();i++) {
					if (!list.get(i).equals("")) {
						cmd += ","+reg.getVarlist()[i]+"="+list.get(i);
					}
				}
				rconn.eval("result<-fun_simplereg("+cmd+")");
				
				
				if (reg.getGroup().equals("")) {
					String [] result = rconn.eval("result$summary").asStrings();
					model.addAttribute("result",result);
				}else {
					String group [] = rconn.eval("result$group").asStrings();				
	 				List<String []> resultlist = new ArrayList<>();
	 				String [] result;
	 				for (int i=0;i<group.length;i++) {
	 					result = rconn.eval("result$"+group[i]).asStrings();
	 					resultlist.add(result);
	 				}
	 				model.addAttribute("group", group);
	 				model.addAttribute("resultlist", resultlist); 				
				}			
				model.addAttribute("clientid",reg.getClientid()); //여기서 말고 로그인 때 유지
				session.setAttribute("formula", formula);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (rconn!=null) {
				rconn.close();
			}			
		}
		model.addAttribute("buttonhoover","simplereg"); //button hoover
		model.addAttribute("center","regression/reg");
		return "analysis/main";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/analysis/regression/simpleregresid.do")
	public String simpleregresid(Model model,HttpSession session,SimpleRegResid regresid,HttpServletRequest req) {
		

		List<String> typelist = (List<String>) session.getAttribute("typelist");
		List<String> headername = (List<String>) session.getAttribute("headername");
		String data = (String) session.getAttribute("dataob");
		String formula = (String) session.getAttribute("formula");
		DataHandle dh= new DataHandle();
		RConnection rconn =null;
		
		try {

				rconn = dh.genVar(data,headername,typelist,6311);
				new Rsource();
				String rs = Rsource.getSimplereg();
				
				rconn.eval(rs);
				String cmd = "";

				//formula
				cmd +=formula;
				
				//others (param)
				List<String> list = new ArrayList<>();			
				list.add(regresid.getMaxlag());
				list.add("'"+regresid.getClientid()+"'");
				for (int i =0;i<list.size();i++) {
					if (!list.get(i).equals("")) {
						cmd += ","+regresid.getVarlist()[i]+"="+list.get(i);
					}
				}
				rconn.eval("result<-fun_simplereg_resid("+cmd+")");
				String [] residtest = rconn.eval("result$residtest").asStrings();
				String [] influence = rconn.eval("result$influence").asStrings();
				if (!regresid.getMaxlag().equals("")){
					String [] dw = rconn.eval("result$dw").asStrings();
					model.addAttribute("dw",dw);
				}
				
				model.addAttribute("x",regresid.getX());
				model.addAttribute("residtest",residtest);
				model.addAttribute("influence",influence);			
				model.addAttribute("clientid",regresid.getClientid());
				//session.removeAttribute("formula");
				
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (rconn!=null) {
				rconn.close();
			}			
		}
		model.addAttribute("buttonhoover","simplereg");
		model.addAttribute("center","regression/regresid");
		return "analysis/main";
	}
}
