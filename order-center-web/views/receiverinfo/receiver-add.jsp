<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%--
 --%><%@ include file="../comm/taglibs.jsp"%><%--
  --%><html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>我的收货地址</title>
    <jsp:include page="../comm/static-resources.jsp"></jsp:include>
    <link rel="stylesheet" href="${ctx }/static/css/global.css"/>
    <link rel="stylesheet" href="${ctx }/static/css/addr-list.css"/>
    <script type="text/javascript" src="${ctx }/static/js/lib/zepto.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/lib/zepto.touch.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/tip.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/ordercenter.js"></script>
</head>
<body>
    <div >
        <form class="form-inline" method="POST" onsubmit="return validate();" id="frm" action="/receiver/addOrEdit">
            <p class="form-item pl15 bottom-line">
                <label for="J_tel" class="form-label">收货人</label>
                <input type="text" class="form-ctl" id="J_name" name="J_name" value="${address.name }" placeholder="请输入收货人名称"/>
            </p>
            <p class="form-item ps15">
                <label for="J_tel" class="form-label">联系手机</label>
                <input type="tel" class="form-ctl" id="J_tel" name="J_mobile" maxlength="11" value="${address.mobilePhone }" placeholder="11位手机号"/>
            </p>
            <p class="form-item ps15 mt10 bottom-line">
                <label for="J_tel" class="form-label">详细地址</label>
                <!-- <input type="text" class="form-ctl" id="J_detail" name="J_detail"  value="${address.address.detail }" placeholder="请输入"/> -->
                <textarea class="form-ctl form-text" rows="3" cols="15" id="J_detail" name="J_detail"  placeholder="请输入">${address.address.detail }</textarea>
            </p>
            <p class="form-item btn-wrap mt40">
            	<input type="hidden" name="receiver_id" value="${addr_id }">
                <button type="button" class="btn-large btn-primary" disabled="disabled" submit="false">保存并使用</button>
            </p>
        </form>
    </div>
    <script>
	var interval;
    window.onload = function(){
    	//setTitle(getSystemName(),"我的收货地址");
    	OC.setTitle("我的收货地址");
    	$(".J_navBack").on('click',function(){
    		history.go(-1);
    	});
    	
    	//去左空格;
    	function ltrim(s){
    	return s.replace( /^\s*/, "");
    	}
    	//去右空格;
    	function rtrim(s){
    	return s.replace( /\s*$/, "");
    	}
    	//去左右空格;
    	function trim(s){
    	return rtrim(ltrim(s));
    	}
    	//判断是否有特殊字符：
    	function containSpecial( s ) {      
    	    var containSpecial = RegExp(/[(\~)(\!)(\@)(\#)(\$)(\%)(\^)(\&)(\*)(\()(\))(\-)(\_)(\+)(\=)(\[)(\])(\{)(\})(\|)(\\)(\;)(\:)(\')(\")(\,)(\.)(\/)(\<)(\>)(\?)(\)]+/);      
    	    return ( containSpecial.test(s) );      
    	}
    	
    	//收货人姓名：20    手机 20  address 256
    	
    	function checkFill(){
    		  //校验手机号: 
    		 var regMobilePhone = /1[3-8]+\d{9}/;
    		  //校验空：
    		 var reg = /^\s*$/g;
    		 var j_name = $("#J_name").val();
    		 var j_tel = $("#J_tel").val();
    		 
    		 //var j_province = $("#J_province").val();
    		 //var j_city = $("#J_city").val();
    		 //var j_area = $("#J_area").val();
    		 
    		 var j_detail = $("#J_detail").val();

    		  //判断是否为空：
    		  if (reg.test(j_name)) {
    			  return false;
    		  } else if (reg.test(j_tel)) {
    			  return false;
    		  } else if (reg.test(j_detail)) {
    			  return false;
    		  }
    		  
    		  //判断是否有特殊字符：
    		  if (containSpecial(j_name)) {
    			  return  false;
    		  } else if(containSpecial(j_tel)) {
    			  return  false;
    		  } else if (containSpecial(j_detail)) {
    			  return false;
    		  } else if (j_name.length > 20) {
    			  return false;
    		  } else if (j_tel.length>16) {
    			  return false;
    		  } else if(j_detail.length>250){
    			  return false;
    		  }
    		  //校验手机：
    		  if(!regMobilePhone.test(j_tel)){
    			  return false;
    		  }
    		return true;
    	}
    	
    	$(".btn-primary").on("click",function(e){
    		var submit =$(e.target).attr('submit');
    		if (submit == 'true') {
    			$("#frm").submit();
    		} else {
    			console.log("false");
    		}
    	},false);
    	
    	var updateStatus = function(status) {
    		var $confirm = $(".btn-primary");
    		if (status == false) {
    			$confirm.attr("disabled","disabled");
    			$confirm.attr("submit","false");
    		} else {
    			$confirm.removeAttr("disabled");
    			$confirm.attr("submit","true");
    		}
    	}
    	
    	var result = checkFill();
    	updateStatus(result);
    	
    	interval = setInterval(function(){
    		var result = checkFill();
    		updateStatus(result);
    		console.log("result:" + result);
    	},500);
    }
    </script>
</body>
</html>
