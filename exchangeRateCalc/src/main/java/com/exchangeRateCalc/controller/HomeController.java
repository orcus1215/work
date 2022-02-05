package com.exchangeRateCalc.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exchangeRateCalc.Util;
import com.exchangeRateCalc.service.HomeService;


@Controller
public class HomeController {

	@Autowired 
	HomeService homeService;

	@RequestMapping("/")
	public String home() throws Exception {
		return "home";
	}

	@RequestMapping("/getRate")
	public @ResponseBody Map<String, Object> getRate(
			@RequestParam Map<String, String> param) throws Exception{

		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			rtnMap = homeService.getRate(param);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return rtnMap;
	}
}
