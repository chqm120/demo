function checkDate(startId, endId) {
	var start = $("#" + startId).val();
	var end = $("#" + endId).val();

	if (isNull(start) || isNull(end)) {
		return;
	}
	if (start > end) {
		if (!confirm("起始时间不能大于终止时间！")) {
			$("#" + startId).val('');
			$("#" + endId).val('');
		}
		;
	}
}

function CheckINT(inputId) {
	var input = $("#" + inputId).val();
	if (isNull(input)) {
		return;
	}
	var reg1 = /^\d+$/;
	if (!reg1.test(input)) {
		alert("请输入自然数。");
	}
	;
}
// 判断字符串时间是否为空
function isNull(str) {
	if (str == null || str == "") {
		return true;
	}
	return false;
}

function mobileNumHide(num, start, end) {
	var str = num + "";
	if(isNull(str)||str.length<start){
		return str;
	}
	var result = str.substring(0, start);
	for (var int = start; int < end &&int<str.length; int++) {
		result += "*";
	}
	if(end<str.length){
		result += str.substring(end, str.length);
	}

	return result;
}
