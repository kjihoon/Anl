package functionSet;
 
public class OtherFun {
	public boolean checkrealnum(String x) {
		try {
			Double.parseDouble(x);
			return true;
		}catch(Exception e){
			return false;
		}
	}
}
