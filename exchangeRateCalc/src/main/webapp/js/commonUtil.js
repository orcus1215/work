var regComma = /\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g;

function fn_regComma(param){
	var rtnVal = '';
	
	rtnVal = param.replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	return rtnVal;
}

function fn_numChk(param){
	if(isNaN(param)){
		return false;
	}
	return true;
}

function fn_mathRound(param){
	var rtnVal = '';
	
	rtnVal = (Math.round((param) * 10) / 10).toFixed(2);
	
	return rtnVal;
}