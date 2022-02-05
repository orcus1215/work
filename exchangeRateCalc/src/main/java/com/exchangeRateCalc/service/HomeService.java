package com.exchangeRateCalc.service;

import java.util.Map;

public interface HomeService {
	Map<String, Object> getRate(Map<String, String> param) throws Exception;
}
