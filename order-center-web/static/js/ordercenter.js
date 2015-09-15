// ====================================
// ordercenter.js
// houhongwei
// ====================================
var OC = function () {
var setTitle = function(title) {
	try{
		client = getSystemName();
		if(client == "android"){
			android.setTitleName(title);
		}
		else if(client == "IOS"){
            setTimeout(function(){
                window.location.href = "native://setTitleName?titleName="+title;
            },1);
		}
	}catch(e){
		console.log("客户端接口调用失败");
	}
};
var getSystemName = function() {
	var u = navigator.userAgent;
	if(u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) {
		return "android";
	} else if(u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1) {
		return "IOS";
	}
	return "android";
};
var ajaxGet = function (uri, data, succCallback, failCallback) {
	$.ajax({
		type:"get",
		url :uri,
		data:data,
		success:function(data){
			succCallback(data);
		},
		error: function () {
			console.log("请求失败");
			if (!isEmpty(failCallback)) {
				failCallback();
			}
		}
	});
};
var ajaxPost = function (uri, data, succCallback, failCallback) {
	$.ajax({
		  type: 'POST',
		  url: uri,
		  data: data,
		  dataType: 'json',
		  success: function(data){
			  succCallback(data);
		  },
		  error: function () {
			  console.log("请求失败");
			  if (!isEmpty(failCallback)) {
					failCallback();
			  }
		  }
	});
};
var ltrim = function(s) {
	return s.replace( /^\s*/, "");
};
var rtrim = function(s) {
	return s.replace( /\s*$/, "");
};
var trim = function (s) {
	return rtrim(ltrim(s));
};
var xssCheck = function (s) {
	var specialCheck = RegExp(/[(\~)(\!)(\@)(\#)(\$)(\%)(\^)(\&)(\*)(\()(\))(\-)(\_)(\+)(\=)(\[)(\])(\{)(\})(\|)(\\)(\;)(\:)(\')(\")(\,)(\.)(\/)(\<)(\>)(\?)(\)]+/);      
    return specialCheck.test(s);
};
var isEmpty = function (s) {
	if (s == '' || s == null || s == undefined || s == 'undefined') {
		return true;
	}
	return false;
};
var toJsonStr = function (s) {
	return JSON.stringify(s);
};
var strToJson = function (s) {
	var obj = eval('(' + s + ')');
	return obj;
};
var shareLink = function(url, title, descr){
	var sysName = getSystemName();
	if ("IOS" == sysName) {
		window.location.href='native://shareWebPage?url=' + url + '&webTitle=' + title + '&webDesc=' + descr;
	} else {
		android.shareWebPage(url, title, descr);
	}
};
var verifyRealName = function() {
	try{
		var client = getSystemName();
		if(client == "android"){
			android.start("REALNAME", "verifyRealNameCallback");
		}
		else if(client == "IOS"){
			window.location.href = "native://start?name=REALNAME&callback=verifyRealNameCallback";
		}
	}catch(e){
		console.log("客户端接口调用失败");
	}
};
var getClientInfo = function(callbackName) {
	var systemName = getSystemName();
	if ("IOS" == systemName) {
		window.location.href="native://getInfo?callback=" + callbackName;
	} else {
		android.getInfo(callbackName);
	}
}
var initClientInfo = function() {
	getClientInfo('initClientInfoCallback');
};

var wystat = function (eventname) {
	var client = getSystemName();
	if ("IOS" == client) {
		window.location.href = "native://wystat?event="+eventname;
	} else {
		android.wystat(eventname);
	}
};
return {
	setTitle: setTitle,
	getSystemName: getSystemName,
	getClientInfo:getClientInfo,
	shareLink: shareLink,
	wystat: wystat,
	ltrim: ltrim,
	rtrim: rtrim,
	trim: trim,
	xssCheck:xssCheck,
	isEmpty: isEmpty,
	ajaxGet: ajaxGet,
	ajaxPost: ajaxPost,
	toJsonStr: toJsonStr,
	initClientInfo:initClientInfo,
	verifyRealName:verifyRealName
};
}();

function verifyRealNameCallback() {
	location.reload(true);
}
function initClientInfoCallback(args) {
args = args.replace(/\r\n/g,'');
args = args.replace(/\n/g,'');
var json = eval('('+args+')');
if (json.isLogin == 1) {
  ClientInfo.isLogin = json.isLogin;
  ClientInfo.isRealName = json.isRealName;
  ClientInfo.wyPin = json.wyPin;
  ClientInfo.jdPin = json.jdPin;
  ClientInfo.version = json.version;
  ClientInfo.clientName = json.clientName;
  ClientInfo.loginName = json.loginName;
  ClientInfo.auth = json.auth;
  ClientInfo.isInit = true;
  ClientInfo.args = args;
}
}

var ClientInfo = {
	isInit:false,
	args:"",
	serverLogin:false,
	isLogin:0,
	isRealName:0,
	wyPin:"",
	jdPin:"",
	version:"",
	clientName:"",
	auth:"",
	loginName:""
};


(function(){
     window.WyStat = window.WyStat ||  {
        site : 'card'
    };
    (function(){
        var ja = document.createElement('script');
        ja.type = 'text/javascript';
        ja.async = true;
        ja.src = 'https://tongjissl.wangyin.com/wystat.js';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(ja, s);
    })();
 })()
