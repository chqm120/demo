<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../comm/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>我的订单</title>
<jsp:include page="../comm/static-resources.jsp"></jsp:include>
<link rel="stylesheet" href="${ctx }/static/css/global.css" />
<link rel="stylesheet" href="${ctx }/static/css/display.css" />
<script type="text/javascript" src="${ctx }/static/js/lib/zepto.js"></script>
<script type="text/javascript" src="${ctx }/static/js/lib/zepto.cookie.js"></script>
<script type="text/javascript" src="${ctx }/static/js/tip.js"></script>
<script type="text/javascript" src="${ctx}/static/js/alertWin.js"></script>
<script type="text/javascript" src="${ctx}/static/js/mine/order-list.js"></script>
<script type="text/javascript" src="${ctx}/static/js/ordercenter.js"></script>
<script type="text/javascript" src="${ctx}/static/js/pay.js"></script>
</head>

<body>
    <input type="hidden" id="ctx" name="ctx" value="${ctx }">
    <!-- 头部End -->
    <form class="form-inline" method="POST">
        <input type="hidden" id="pageNum" name="pageNum" value="1">
        <div class="main" >
             <c:forEach var="order" items="${orders }">
             <c:set var="rel" value="${ produectRels[0]}"></c:set>
             <c:forEach var="rel1" items="${produectRels }">
                 <c:if test="${order.orderId==rel1.orderId }">
                     <c:set var="rel" value="${rel1 }"></c:set>
                 </c:if>
             </c:forEach>
             <dl class="my-order-warp mt10" id="order_dl_${order.orderId}" >
                 <dd class="tr">
                     <font class="red-col">
                         <c:if test="${order.status==10 }">未付款</c:if> 
                         <c:if test="${order.status==11 }">订单取消</c:if>
                         <c:if test="${order.status==12 }">交易关闭</c:if>
                         <c:if test="${order.status==13 }">等待支付结果</c:if>
                         <c:if test="${order.status==15 }">已支付</c:if>
                         <c:if test="${order.status==16 }">等待确认</c:if>  
                         <c:if test="${order.status==20 }">已发货</c:if> 
                         <c:if test="${order.status==21 }">发货失败</c:if> 
                         <c:if test="${order.status==25 }">已收货</c:if> 
                         <c:if test="${order.status==35 }">交易完成</c:if> 
                         <c:if test="${order.status==80 }">退款中</c:if> 
                         <c:if test="${order.status==85 }">退款失败</c:if> 
                         <c:if test="${order.status==85 }">退款驳回</c:if>
                         <c:if test="${order.status==90 }">退款完成</c:if>
                     </font>
                     <label class="">${rel.merchantName }</label>
                 </dd>
                 <dd class="clearfix">
                     <a href="${ctx }/mine/od/detail/${order.orderId}">
                         <div class="my-order-list clearfix">
                             <div class="list-thumb">
                                 <img src="${rel.icon }" />
                             </div>
                             <div class="list-descriptions">
                                 <div class="list-descriptions-wrapper">
                                     <p class="product-name">${rel.name }</p>
                                     <p class="number gray-col">x${rel.count }</p>
                                 </div>
                                 <div class="list-descriptions-info" class="tr">
                                     <p class="cost">原价：<font style="font-family:Arial;">¥</font> <span id="money_1_${order.orderId}">${rel.denomination }</span></p>
                                     <p class="price ">优惠价：<font style="font-family:Arial;">¥</font><span id="money_2_${order.orderId}">${rel.price }</span></p>
                                 </div>
                             </div>
                         </div>
                     </a>
                 </dd>
                 <dd class="clearfix">
                     <lebel class="fr">实付：<span><font style="font-family:Arial;">¥</font><font
                         class="red-col f18 fontB"><span id="money_3_${order.orderId}">${order.amountPayable }</span></font></span></lebel>
                     <span>共${order.productCount }件商品</span>
                 </dd>
                 <dd class="tr">
                     <c:if test="${order.status==10 }">
                         <a href="javascript:toOrderCancel('${order.orderId }');" class="order-cancelorder-btn">取消订单</a>
                         <c:choose>
                         <c:when test="${tenantId == 15}">
                         <a href="${ctx}/wangyin/pay/${order.orderId }" class="my-order-btn" order="${order.orderId }" trade="$">立即支付</a>
                         </c:when>
                         <c:otherwise>
                         <a href="javascript:;" class="my-order-btn gotopay" order="${order.orderId }" trade="$">立即支付</a>
                         </c:otherwise>
                         </c:choose>
                     </c:if>
                     <c:if test="${order.status==20 }">
                     <c:if test="${tenantId != 15 }">
                     <a href="javascript:toOrderConfirm('${order.orderId }');" class="my-order-btn">确认收货</a>
                     </c:if>
                     </c:if>
                     <c:if test="${(order.status==25 || order.status==35)&&(empty order.score || (order.score<1||order.score>5))  }">
                     <%-- <c:if test="${tenantId != 15 }"><a href="${ctx }/mine/od/detail/${order.orderId}" class="my-order-btn">立即评分 </a></c:if> --%>
                     </c:if>
                     <c:if test="${order.status!=10 && order.status!=20}">
                     <c:if test="${tenantId != 15 }"><a href="${cardshopDomain}" class="my-order-btn">继续逛逛 </a></c:if>
                     </c:if>
                 </dd>
             </dl>
             </c:forEach>
        </div>
    </form>
 
 <div style="display:none">
 	<form id="myform"  name="myform" method="POST" action="">
 		<input type="hidden" name="orderId" id="orderId" />
 		<input type="hidden" name="payChannel" id="payChannel" />
 		<input type="hidden" name="payStatus" id="payStatus" />
 	</form>
 </div>
<script type="text/javascript">
var ctx = '${ctx}';
var orderId = "";
window.onload=function() {
	OC.setTitle("我的订单");
}
function payCompleteCallback(args) {
	if(args == "0") {
		return;
	}
	var json = eval('('+args+')');
	var payStatus = -1;
	if(json.status == "SUCCESS") {
		payStatus = 1;
	} else if(json.status == "FAIL") {
		payStatus = 0;
	} else if(json.status == "ING") {
		payStatus = 2;
	}
	if(orderId != "") {
		document.myform.action="${ctx}/wallet/pay/complete";
		$("#orderId").val(orderId);
		$("#payChannel").val('20');
		$("#payStatus").val(payStatus);
		document.myform.submit();
		//OC.ajaxPost("${ctx}/wallet/pay/complete",{"orderId":orderId,"payStatus":payStatus,"payChannel":20},succCallback,failCallback);
	} else {
		console.log("客户端无支付流水");
	}
}
$(".gotopay").on('click',function(event){
	orderId = $(event.target).attr("order");
	Tip.showLoading("生成支付信息.....");
    $(".popWin").hide();
	<c:if test="${tenantId == '10'}">
    var succCallback = function (json) {
        Tip.destory();
        if (json.code == 200) {
            tradeId = json.data.merchantTradeNum;
            PAY.launchPayWindow(json.data, 'payCompleteCallback');
        } else {
            Tip.showMsg(json.data);
        }
    }
    var failCallback = function (args) {
        Tip.destory();
        Tip.showMsg("付款失败");
    }
    OC.ajaxGet("${ctx}/wallet/pay/data?orderId="+orderId,null,succCallback, failCallback);
    </c:if>
    <c:if test="${tenantId == '12' || tenantId == '13'}">
    window.location.href="${ctx}/wangyin/pay/"+orderId;
    </c:if>
});
</script>
</body>
</html>