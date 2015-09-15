function toPrompt(status){
	if(status==80){
		Tip.showLoading("系统处理中。");
	}else{
		Tip.showLoading("卡片定制中，请耐心等候。");
	}
} 

function pageRedirect(url){
	window.location.href=url;
}
function touchstart(data_val){
	$("#user_star_score").val(data_val);
	$("#user_star_warp").width(data_val*25);
}

function toScore(orderId){
	var ctx = $("#ctx").val();
	var score = $("#user_star_score").val();
	var url = ctx+"/ajax/mine/od/detail/score?orderId="+orderId+"&score="+score;
	ajaxPost(url, null, function(data){
		//location.reload();
		$("#sys_star_score").val(score);
		$("#sys_star_warp").width(score*25);
		$("#div_toScore").hide();
		$("#div_hadScore_toShop").show();
		$("#p_buy_agine").hide();
	});
}
function toOrderConfirm(orderId){
	var option = {  
        title: '确定收货吗?',
        content: '',
        btnCancel: '取消',
        btnConfirm: '确认',
        callbackCancel: function(){
        	//nothing
        },
        callbackConfirm: function(){
        	var ctx = $("#ctx").val();
        	var url = ctx+"/ajax/mine/od/detail/receipt/confirm?orderId="+orderId;
        	ajaxPost(url, null, function(data){
        		$("#span_orderStatus").text('已收货');
        		$("#btn_toSubmit").hide();
        		//$("#div_toScore").show();
        		$("#p_buy_agine").show();
        	});
        }
	};
	G.getTemplate(option);
}

function toOrderCancel(orderId) {
	var ctx = $("#ctx").val();
	var url = ctx+"/ajax/mine/od/list/cancel?orderId="+orderId;
	ajaxPost(url, null, function(data){
		location.reload();
	});
}
function ajaxGet(uri, callback) {
	$.ajax({
		type:"get",
		url :uri,
		success:function(data){
			callback(data);
		},
		error: function () {
			//请求失败
			//alert("请求失败");
			console.log("请求失败");
		}
	});
};
function ajaxPost(url, data, callback) {
	$.ajax({
		  type: 'POST',
		  url: url,
		  data: data,
		  dataType: 'json',
		  success: function(data){
			  callback(data);
		  },
		  error: function () {
			  console.log("请求失败");
		  }
	});
};
function handlMoneyNum(){
	$("span[id^='money_']").each(function(){
		var num = $(this).text();
		if (num == null || num == "") {
			return;
		}
		if(num.lastIndexOf(".")>-1){
			var tem1 = num.substring(0,num.lastIndexOf("."));
			var tem2 = num.substring(num.lastIndexOf("."));
			if(tem2.length ==1){
				num = tem1+tem2+"00";
			}else if(tem2.length ==2){
				num = tem1+tem2+"0";
			}
		}else{
			num = num+".00";
		}
		$(this).text(num);
	  });
}
$().ready(function(){
	//处理涉及钱的数字格式：
	handlMoneyNum();
});