<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>exchange rate calc</title>
<script src="../../js/jquery-3.6.0.min.js"></script>
<script src="../../js/commonUtil.js?1=1"></script>
<script type="text/javascript">
	$(document).ready(function(){ 
		fn_getRate();
	});
	
	var globalRate = '';
	
	function fn_getRate(){
		var nation = $('#nation').val();
		
		$.ajax({
			type : 'POST', 
			data : {'nation' : nation},
			url : '/getRate',
			dataType : 'json', 
			success : function(data){
				var success = data.success;
				if(success){
					globalRate = data.rate;
					$('#rate').html(fn_regComma(globalRate)+' '+nation+'/USD');
				}else{
					$('#rate').html('<span style="color: red;">에러 발생 (error message:'+data.errorMsg+')</span>');
				}
			}, 
			error : function(xhr, status, e){ 
				$('#rate').html('<span style="color: red;">에러 발생 (error code : 001)</span>');
				console.log('e : '+e);
			}
		});
	}
	
	function fn_calc(){
		var money = $('#money').val();
		if(fn_checkVal(money)){
			// 계산
			var result = fn_regComma(fn_mathRound(money * globalRate));
			$('#result').html('수취금액은 '+result+' '+$('#nation').val()+' 입니다.');
		}
	}
	
	function fn_checkVal(money){
		// 송금액 입력체크
		if(money == ''){
			alert('송금액을 입력해주세요');
			return false;	
		}
		
		//숫자체크
		if(!fn_numChk(money)){
			alert('송금액은 숫자만 입력이 가능합니다.');
			return false;
		}
		
		// 송금액이 0보다 커야함
		if(money <= 0){
			alert('송금액을 0 USD 초과로 입력해주세요.');
			return false;
		}
		
		// 송금액이 10,000보다 작아야함
		if(money >= 10000){
			alert('송금액을 10,000 USD 미만으로 입력해주세요.');
			return false;
		}
		
		return true;
	}
</script>
</head>
<body>
<div>환율계산</div>
<div>송금국가:미국(USD)</div>
<div>
	수취국가:
	<select id="nation" onchange="fn_getRate()">
		<option value="KRW">한국(KRW)</option>
		<option value="JPY">일본(JPY)</option>
		<option value="PHP">필리핀(PHP)</option>
	</select>
</div>
<div>환율:<span id="rate"></span></div>
<div>송금액:<input type="text" id="money" value=""/>USD</div>
<button onclick="fn_calc()">submit</button>
<div id="result"></div>
</body>
</html>