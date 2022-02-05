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
					$('#rate').html('<span style="color: red;">���� �߻� (error message:'+data.errorMsg+')</span>');
				}
			}, 
			error : function(xhr, status, e){ 
				$('#rate').html('<span style="color: red;">���� �߻� (error code : 001)</span>');
				console.log('e : '+e);
			}
		});
	}
	
	function fn_calc(){
		var money = $('#money').val();
		if(fn_checkVal(money)){
			// ���
			var result = fn_regComma(fn_mathRound(money * globalRate));
			$('#result').html('����ݾ��� '+result+' '+$('#nation').val()+' �Դϴ�.');
		}
	}
	
	function fn_checkVal(money){
		// �۱ݾ� �Է�üũ
		if(money == ''){
			alert('�۱ݾ��� �Է����ּ���');
			return false;	
		}
		
		//����üũ
		if(!fn_numChk(money)){
			alert('�۱ݾ��� ���ڸ� �Է��� �����մϴ�.');
			return false;
		}
		
		// �۱ݾ��� 0���� Ŀ����
		if(money <= 0){
			alert('�۱ݾ��� 0 USD �ʰ��� �Է����ּ���.');
			return false;
		}
		
		// �۱ݾ��� 10,000���� �۾ƾ���
		if(money >= 10000){
			alert('�۱ݾ��� 10,000 USD �̸����� �Է����ּ���.');
			return false;
		}
		
		return true;
	}
</script>
</head>
<body>
<div>ȯ�����</div>
<div>�۱ݱ���:�̱�(USD)</div>
<div>
	���뱹��:
	<select id="nation" onchange="fn_getRate()">
		<option value="KRW">�ѱ�(KRW)</option>
		<option value="JPY">�Ϻ�(JPY)</option>
		<option value="PHP">�ʸ���(PHP)</option>
	</select>
</div>
<div>ȯ��:<span id="rate"></span></div>
<div>�۱ݾ�:<input type="text" id="money" value=""/>USD</div>
<button onclick="fn_calc()">submit</button>
<div id="result"></div>
</body>
</html>