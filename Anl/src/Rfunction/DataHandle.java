package Rfunction;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.rosuda.REngine.Rserve.RConnection;


public class DataHandle {
	
	//public RConnection genVar(List<List<String>> data,List<String> headername,List<String> typelist,int port) {
	public RConnection genVar(String data,List<String> headername,List<String> typelist,int port) throws ParseException{
		System.out.println("Connection method(Generating variables)");
		Map<String,List<String>> map = convertMap(data,headername,typelist);
		RConnection rconn = null;
		try {
			rconn = new RConnection("localhost",port);
			System.out.println("connect rconn sucess");
			String cmd = (headername.toString()).substring(1,headername.toString().length()-1);
			List<String> list;
			String cmdvar = "";
			for (int i =0;i<headername.size();i++) {
				list = map.get(headername.get(i));
				cmdvar = list.toString();
				cmdvar = cmdvar.replace("[","");
				cmdvar = cmdvar.replace("]","");
				rconn.eval(headername.get(i)+"<-c("+cmdvar+")");
			}
			rconn.eval("df<-data.frame("+cmd+")");		
			System.out.println("Connection Success");
		}catch(Exception e) {
			if (rconn!=null) {
				rconn.close();
			}
			System.out.println("(genvar)Connection Fail or Syntex error");
		}finally {
			
		}
		return rconn;
	}
	
	public Map<String,List<String>> convertMap(String data,List<String> headername,List<String> typelist) throws ParseException {
		JSONParser parser = new JSONParser();
		JSONArray jr = (JSONArray) parser.parse(data);
		Map<String,List<String>> map = new HashMap<>();
		List<String> list =null;		
		for (int i =0;i<headername.size();i++) {
			JSONObject jo = null;
			list = new ArrayList<>();
			for (int j=0;j<jr.size();j++) {
				jo = (JSONObject) jr.get(j);
				if (typelist.get(i).equals("text")) {
					list.add("'"+(String)jo.get(headername.get(i))+"'");
				}else {
					list.add((String)jo.get(headername.get(i)));
				}				
			}
			map.put(headername.get(i), list);
		}
		
		return map;
	}

}
