package com.anl.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anl.vo.Setting;
import com.anl.vo.Ttest;

import Rfunction.Rdata;
import Rfunction.Rsource;

@Controller
public class MeanEstimatorController {

	@SuppressWarnings("unchecked")
	@RequestMapping("/meanestimator/ttest.do")
	@ResponseBody
	public String ttest(Model model,HttpSession session,Ttest ttest) throws ParseException {
		Map<String,String> userInfo = (Map<String, String>) session.getAttribute("userInfo");
		List<List<String>> data =(List<List<String>>) session.getAttribute("data");
		List<String> headername =(List<String>) session.getAttribute("headername");
		Setting set = (Setting) session.getAttribute("typelist");
		
		List<String> typelist = set.getType();
		Rdata rdata = new Rdata();
		RConnection rconn=null;
		String cmd ="";
		ttest.setClientid(userInfo.get("USERID"));
		JSONObject jo = new JSONObject();
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
				list.add("'"+ttest.getClientid()+"'");		
				System.out.println(list.toString());
				String [] varlist= ttest.getVarlist();
				cmd = varlist[0]+"="+list.get(0);
				for (int i =1;i<list.size();i++) {
					if (!list.get(i).equals("")&&!list.get(i).equals("''")) {
						cmd += ","+varlist[i]+"="+list.get(i);
					}
				}
				
				cmd ="model<-fun_ttest("+cmd+")";
				System.out.println("Rcommand :"+cmd);
				rconn.eval(cmd);				
				String [] result = rconn.eval("model$result").asStrings();
				JSONArray jr = new JSONArray();
				for (String s : result) {
					jr.add(s+"<br>");
				}
				jo.put("result", jr);
				jo.put("xvar", ttest.getX());
				jo.put("imgpath1", "/Anl/img/"+ttest.getClientid()+"ttest_hist.png");
				jo.put("imgpath2", "/Anl/img/"+ttest.getClientid()+"ttest_box.png");
				
				
				
				
			}		

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("t-test error");
			jo.put("result","Exception error");
		}finally {
			if (rconn!=null) {
				rconn.close();
			}
			session.setAttribute("typelist", set);
		}
		return jo.toJSONString();
	}

}
