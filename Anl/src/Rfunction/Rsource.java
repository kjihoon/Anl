package Rfunction;

public class Rsource {
	static String ttest="source('~/Rjihoon/fun_ttest.R', encoding = 'UTF-8', echo=TRUE)";
	static String cortest="source('~/Rjihoon/fun_cortest.R', encoding = 'UTF-8', echo=TRUE)";
	static String bestfit="source('~/Rjihoon/fun_bestfit.R', encoding = 'UTF-8', echo=TRUE)";
	static String multireg="source('~/Rjihoon/fun_multireg.R', encoding = 'UTF-8', echo=TRUE)";
	static String simplereg="source('~/Rjihoon/fun_simplereg.R', encoding = 'UTF-8', echo=TRUE)";
	static String normal="source('~/Rjihoon/fun_normal.R', encoding = 'UTF-8', echo=TRUE)";
	public static String getTtest() {
		return ttest;
	}
	public static String getCortest() {
		return cortest;
	}
	public static String getMultireg() {
		return multireg;
	}
	public static String getSimplereg() {
		return simplereg;
	}
	public static String getBestfit() {
		return bestfit;
	}
	public static String getNormal() {
		return normal;
	}
	
	
}
