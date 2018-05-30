package com.anl.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.anl.vo.Setting;
import com.anl.vo.Ttest;

import Rfunction.DataHandle;
import Rfunction.Rdata;
import Rfunction.Rsource;

@Controller
public class TtestController {

	@SuppressWarnings("unchecked")
	@RequestMapping("/meanestimator/ttest.do")
	public String ttest(Model model,HttpSession session,Ttest ttest) throws ParseException {
		List<List<String>> data =(List<List<String>>) session.getAttribute("data");
		List<String> headername =(List<String>) session.getAttribute("headername");
		Setting set = (Setting) session.getAttribute("typelist");
		List<String> typelist = set.getType();
		Rdata rdata = new Rdata();
		RConnection rconn=null;
		String cmd ="";
		String [] result=null;
		try {
			if (ttest.getX()!=null) {
				rconn = rdata.genVar(data, typelist, headername, 6311);
				new Rsource();
				String rs = Rsource.getTtest();
				rconn.eval(rs);
				List<String> list = new ArrayList<>();
				list.add(ttest.getX());
				list.add(ttest.getY());
				list.add("'"+ttest.getAlternative()+"'");
				list.add(ttest.getMu());
				list.add(ttest.getPaired());
				list.add(ttest.getVarequal());
				list.add(ttest.getConflevel());		
				String [] varlist= ttest.getVarlist();
				cmd = varlist[0]+"="+list.get(0);
				for (int i =1;i<list.size();i++) {
					if (!list.get(i).equals("")&&!list.get(i).equals("''")) {
						cmd += ","+varlist[i]+"="+list.get(i);
					}
				}
				
				cmd ="model<-fun_ttest("+cmd+")";
				rconn.eval(cmd);
				
				result = rconn.eval("model$result").asStrings();
				model.addAttribute("clientid",ttest.getClientid());
				
			}		

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("오류오류");
		}finally {
			if (rconn!=null) {
				rconn.close();
			}
		}
		return "main";
	}

}
