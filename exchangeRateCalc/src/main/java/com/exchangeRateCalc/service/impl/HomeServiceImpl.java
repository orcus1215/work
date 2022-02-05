package com.exchangeRateCalc.service.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.exchangeRateCalc.Util;
import com.exchangeRateCalc.service.HomeService;

@Service
public class HomeServiceImpl implements HomeService {
	@Override
	public Map<String, Object> getRate(Map<String, String> param) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		String reqNation = "";
		String strUrl = "";
		URL url = null;
		HttpURLConnection httpURLConnection = null;

		JSONObject jObject_1 = null;
		JSONObject jObject_2 = null;

		try {
			reqNation = param.get("nation").toString();

			strUrl = "http://www.apilayer.net/api/live?access_key=a7ec72202db1df81585b85c1cd587971";
			url = new URL(strUrl);
			httpURLConnection = (HttpURLConnection) url.openConnection();

			httpURLConnection.setRequestMethod("GET");
			httpURLConnection.setRequestProperty("Content-Type", "application/json");
			httpURLConnection.setRequestProperty("Transfer-Encoding", "chunked");
			httpURLConnection.setRequestProperty("Connection", "keep-alive");
			httpURLConnection.setDoOutput(true);

			int responseCode = httpURLConnection.getResponseCode();
			if(responseCode == 200){
				BufferedReader br = new BufferedReader(new InputStreamReader(httpURLConnection.getInputStream()));
				StringBuilder sb = new StringBuilder();
				String line = "";
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}

				jObject_1 = new JSONObject(sb.toString());
				if(jObject_1.getBoolean("success")) {
					jObject_2 = new JSONObject(jObject_1.getJSONObject("quotes").toString());
					rtnMap.put("rate", Util.convertRate(Util.doubleToStr(jObject_2.getDouble("USD"+""+reqNation))));
					rtnMap.put("success", true);
					rtnMap.put("errorMsg", "");
				}else {
					//jObject_1 ::::: {"success":false,"error":{"code":106,"info":"You have exceeded the maximum rate limitation allowed on your subscription plan. Please refer to the \"Rate Limits\" section of the API Documentation for details. "}}
					jObject_2 = new JSONObject(jObject_1.getJSONObject("error").toString());
					rtnMap.put("success", false);
					rtnMap.put("errorMsg", "error code :: "+Util.intToStr(jObject_2.getInt("code"))+", info :: "+jObject_2.getString("info"));
				}
			}else {
				rtnMap.put("success", false);
				rtnMap.put("errorMsg", "http status error :: "+Util.intToStr(responseCode));
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return rtnMap;
	}
}
