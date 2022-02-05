package com.exchangeRateCalc;

import java.text.DecimalFormat;

public class Util {
	public static String convertRate(String paramStr) {
		String rtnStr = "";
		double tempDouble = 0;
		
		tempDouble = strToDouble(paramStr);
		
		DecimalFormat df = new DecimalFormat("0.00");
		rtnStr = df.format(tempDouble);
		
		return rtnStr;
	}
	
	public static double strToDouble(String paramStr) {
		double rtnDouble = 0;
		
		if(paramStr != null && !paramStr.equals("")) {
			rtnDouble = Double.parseDouble(paramStr);
		}		
		
		return rtnDouble;		
	}
	
	public static String nullToEmpty(String paramStr) {
		if(paramStr != null && !paramStr.equals("")) {
			return paramStr;
		}else {
			return "";
		}
	}
	
	public static String intToStr(int paramInt) {
		String rtnStr = "";
		rtnStr = String.valueOf(paramInt);
		return rtnStr;
	}
	
	public static String doubleToStr(double paramDouble) {
		String rtnStr = "";
		rtnStr = String.valueOf(paramDouble);
		return rtnStr;
	}
}
