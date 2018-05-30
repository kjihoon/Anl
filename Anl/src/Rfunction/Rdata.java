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


public class Rdata {
	
	
	public static Map<String,List<String>> convertMap(List<List<String>> data,List<String> typelist,List<String> headername) {
		Map<String,List<String>> map = new HashMap<>();
		List<String> item = null;
		for(int i=0;i<data.get(0).size();i++) {
			item = new ArrayList<String>();				
			if (typelist.get(i).equals("text")) {
				for(int j=0;j<data.size();j++) {
					item.add("'"+data.get(j).get(i)+"'");
				}					
			}else {
				for(int j=0;j<data.size();j++) {
					item.add(data.get(j).get(i));
				}
			}
			map.put(headername.get(i),item);								
		}
		return map;
	}
	
	public RConnection genVar(List<List<String>> data,List<String> typelist,List<String> headername,int port) throws ParseException{
		System.out.println("Connection method(Generating variables)");
		
		RConnection rconn = null;
		Map<String,List<String>> map = new HashMap<>();
		
		try {
			rconn = new RConnection("localhost",port);
			map = convertMap(data,typelist,headername);
			List<String> item = null;
			String cmd = "";
			for (int i=0;i<headername.size();i++) {
				item = map.get(headername.get(i));
				cmd = headername.get(i)+"<-c("+item.toString().substring(1,item.toString().length()-1)+")";
				rconn.voidEval(cmd);
			}
			cmd ="";
			for (int j=0;j<headername.size();j++) {
				cmd +=headername.get(j)+",";
			}
			rconn.voidEval("df<-data.frame("+cmd.substring(0, cmd.length()-1)+")");		
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
}
