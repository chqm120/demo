<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../comm/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>卡片信息</title>
<jsp:include page="../comm/static-resources.jsp"></jsp:include>
<link rel="stylesheet" href="${ctx }/static/css/global.css" />
<link rel="stylesheet" href="${ctx }/static/css/display.css" />
<script type="text/javascript" src="${ctx }/static/js/lib/zepto.js"></script>
<script type="text/javascript" src="${ctx }/static/js/lib/zepto.cookie.js"></script>
<script type="text/javascript" src="${ctx }/static/js/lib/zepto.touch.js"></script>
</head>
<body>
<c:if test="${showBarCode==1}">
<div class="barcode_con">
	<ul class="barcode_con_ul">
		<c:forEach var="card" items="${cardInfos }"  varStatus="status">
			<c:if test="${not empty card.orderCard.pass }">
				<c:if test="${card.type == 0 }">
					<li class="numbar_zc">
				      	<span class="barcode_num">${ status.index + 1}</span>
				       	<div class="bcbarcode_box clearfix"><img src="${ctx }/barcode?fmt=png&msg=${card.orderCard.pass }&type=code128&height=20&hrsize=2mm" /></div>
				        <span class="barcode_iden">未使用</span>
				    </li>
			    </c:if>
			    <c:if test="${card.type != 0 }">
				    <li class="numbar_no">
			        	<span class="barcode_num">${ status.index + 1}</span>
			        	<div class="bcbarcode_box"><img src="${ctx }/barcode?fmt=png&msg=${card.orderCard.pass }&type=code128&height=20&hrsize=2mm" /></div>
			            <c:if test="${card.type == 1 }"><span class="barcode_iden">已使用</span></c:if>
			            <c:if test="${card.type == 2 }"><span class="barcode_iden">已退回</span></c:if>
			            <c:if test="${card.type == 3 }"><span class="barcode_iden">已过期</span></c:if>
			            <c:if test="${card.type == 4 }"><span class="barcode_iden">已锁定</span></c:if>
			            <c:if test="${card.type != 1 && card.type != 2 && card.type != 3 && card.type != 4}"><span class="barcode_iden">无效劵</span></c:if>
			        </li>
			    </c:if>
			</c:if>
		</c:forEach>
    	<%-- <li class="numbar_zc">
        	<span class="barcode_num">1</span>
        	<div class="bcbarcode_box clearfix"><img src="${ctx }/barcode?fmt=png&msg=123456789012345678&type=code128&height=20&hrsize=2mm" /></div>
            <span class="barcode_iden">未使用</span>
        </li>
        <li class="numbar_zc">
        	<span class="barcode_num">2</span>
        	<div class="bcbarcode_box clearfix"><img src="${ctx }/static/img/111.png" /></div>
            <span class="barcode_iden">未使用</span>
        </li>
        <li class="numbar_no">
        	<span class="barcode_num">3</span>
        	<div class="bcbarcode_box"><img src="${ctx }/barcode?fmt=png&msg=11114131112123&type=code128&gray=false&height=9&hrsize=2mm&bgcolor=red" /></div>
            <span class="barcode_iden">已使用</span>
        </li>  --%>
       
    
    </ul>
</div>
<div class="fitter_con"></div>
<div class="fitter_cen"><img src="" class="fitter_boost" /></div>
</c:if>
<c:if test="${showBarCode!=1}">
<!-- 头部End -->
	<div class="text-tips">客官，长按卡号或卡密可复制噢~</div>
	<form class="form-inline" method="POST">
		<div class="main">
		<c:forEach var="card" items="${cards }">
			<dl class="amount-warp">
				<dt>
					<span class="fr">${card.name }</span><label class="">${card.merchantName }</label>
				</dt>
				<dd style="background: #fff;">
					<c:if test="${not empty card.cardNo }">
					<p>
						<span class="fr">${card.cardNo }</span>卡号
					</p>
					</c:if>
					<c:if test="${not empty card.pass }">
					<p>
						<span class="fr">${card.pass }</span>卡密
					</p>
					</c:if>
				</dd>
				<c:if test="${showBarCode==1 && not empty card.pass}">
				<dd style="background: #fff;">
					<p>
					<span style="align:center;">
					<img style="display:block; margin:0 auto;margin-top:10px;" src="${ctx}/getBarCodeImage/${card.pass }"/>
					</span>
					</p>
				</dd>
				</c:if>
			</dl>
		</c:forEach>
		</div>
	</form>
<script type="text/javascript" src="${ctx }/static/js/ordercenter.js"></script>    
<script type="text/javascript">
<c:if test="${tenantId !=15}">OC.setTitle("卡片信息");</c:if>
(function(){
    var u = navigator.userAgent;
    if(u.indexOf('iPhone OS') > -1){
        $(".text-tips").hide();
    }
})();
</script>

</c:if>
	



<script>
$(function(){
	var winW= $(window).width();
	var listHpic=(10*winW-5)/27;
	$(".bcbarcode_box img").css("height",111+'px');
	$(".barcode_con ul li.numbar_zc").click(function(){
		var src=$(this).find(".bcbarcode_box img").attr("src");
		$(".fitter_boost").attr("src",src);
		$(".fitter_con").show();
		$(".fitter_cen").show();
		pupalt();
	})
	$(".fitter_cen,.fitter_con").click(function(){
		$(".fitter_con").hide();
		$(".fitter_cen").hide();
	})
	
})

function pupalt(){
		var winW = $(window).width();
		var winH = $(window).height();
		$(".fitter_con").css("min-height",winH);
		$(".fitter_cen img").css("height",0.5*winW+'px');
		$(".fitter_cen img").css("width",0.64*winH+'px');
		if(winH<winW){
			$(".fitter_cen img").css({"transform":"rotate(0deg)","-moz-transform":"rotate(0deg)","-o-transform":"rotate(0deg)","-webkit-transform":"rotate(0deg)","transform":"rotate(0deg)"});
		}
		var picW=$(".fitter_cen").width();
		var picH=$(".fitter_cen").height();
		if (picH==0){
			picH=0.4565*winW;
		}
		var martt=(winH-picH)/2;
		$(".fitter_cen").css({"top":martt+'px'});
		//var tuW=$(".fitter_boost").width();
		//var tuH=$(".fitter_boost").height();

}
</script>
</body>
</html>
