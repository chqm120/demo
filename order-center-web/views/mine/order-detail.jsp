<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../comm/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util"  uri="/wyUtilsTag"%>
<%--
 --%><!DOCTYPE html>
<html>
<head>
<title>我的订单</title>
	<jsp:include page="../comm/static-resources.jsp"></jsp:include>
	<link rel="stylesheet" href="${ctx}/static/css/global.css"/>
    <link rel="stylesheet" href="${ctx}/static/css/display.css"/>
    <script type="text/javascript" src="${ctx }/static/js/lib/zepto.js"></script>
	<script type="text/javascript" src="${ctx }/static/js/lib/zepto.cookie.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/tip.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/alertWin.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/mine/order-detail.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/ordercenter.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/pay.js"></script>
</head>

<body>
    <!-- 头部End -->
    <form class="form-inline" method="POST">
    <div class="main" style="padding-bottom: 60px;">
        <dl class="amount-warp">
            <dt>
            	<span class="fr fontCol" id="span_orderStatus">
            		<c:if test="${order.orderInfo.status==10 }">未付款</c:if> 
            		<c:if test="${order.orderInfo.status==11 }">订单取消</c:if>
            		<c:if test="${order.orderInfo.status==12 }">交易关闭</c:if>
            		<c:if test="${order.orderInfo.status==13 }">等待支付结果</c:if>
					<c:if test="${order.orderInfo.status==15 }">已支付</c:if>
					<c:if test="${order.orderInfo.status==16 }">等待确认</c:if>  
					<c:if test="${order.orderInfo.status==20 }">已发货</c:if> 
					<c:if test="${order.orderInfo.status==21 }">发货失败</c:if> 
					<c:if test="${order.orderInfo.status==25 }">已收货</c:if> 
					<c:if test="${order.orderInfo.status==35 }">交易完成</c:if> 
					<c:if test="${order.orderInfo.status==80 }">退款中</c:if> 
					<c:if test="${order.orderInfo.status==85 }">退款失败</c:if> 
					<c:if test="${order.orderInfo.status==85 }">退款驳回</c:if>
					<c:if test="${order.orderInfo.status==90 }">退款完成</c:if> 
            	</span>
            <label class="">订单状态 </label></dt>
            <!-- 物流情况 -->
            <c:if test="${order.orderLogisticsInfo!=null && (order.orderInfo.status != 10 && order.orderInfo.status != 11 && order.orderInfo.status != 12) }">
            <dd style="background:#fff;">
                <p><span class="fr">
                	<a href="${order.orderLogisticsInfo.queryUrl}">${order.orderLogisticsInfo.name}</a>
                </span>货运人：</p>
                <p><span class="fr">${order.orderLogisticsInfo.code}</span>物流单号：</p>
            </dd>
            </c:if>
        </dl>
        
        <c:if test="${productInfo.type == 2 || productInfo.type == 5 }">
		<c:if test="${order.orderInfo.status != 10 &&  order.orderInfo.status!=11 &&  order.orderInfo.status!=12 &&  order.orderInfo.status!=21 &&  order.orderInfo.status!=90}">
		<div class="look-card-userName mt10 pad10">
		<c:if test="${hasCardCode && order.orderInfo.status != 16}">
        	<a href="${ctx}/mine/od/cards?orderId=${order.orderInfo.orderId }">
        	<c:if test="${showBarCode==1}">
        		<span class="arrow-ico—new">
	            	<img src="${ctx}/static/img/tiaoma.png">
	            	<c:if test="${order.orderInfo.remark != 0 }"><span class="arrow_num">${order.orderInfo.remark }</span></c:if>
	            </span>
        	</c:if>
        	<c:if test="${showBarCode!=1}">
        		<span class="arrow-ico-order"></span>
        	</c:if>
        	<label class="redfont">查看我的卡片信息</label></a>
		</c:if>
		<c:if test="${!hasCardCode || order.orderInfo.status == 16}">
        	<a onclick="toPrompt(${order.orderInfo.status})">
        	<c:if test="${showBarCode==1}">
        		<span class="arrow-ico—new">
	            	<img src="${ctx}/static/img/tiaoma.png">
	            	<span class="arrow_num">21</span>
	            </span>
        	</c:if>
        	<c:if test="${showBarCode!=1}">
        		<span class="arrow-ico-order"></span>
        	</c:if>
        	<label class="redfont ms10">查看我的卡片信息</label></a>
		</c:if>
		</div>
		</c:if>
		</c:if>
        
        <!-- 实体订单收货地址快照 -->
        <c:if test="${not empty order.orderReceiverInfo}">
        <dl class="text-warp mt10 clearfix">
            <dt class="clearfix"><label>收货信息 </label></dt>
            <dd><label>收货人：</label><p>${order.orderReceiverInfo.name }</p></dd>
            <dd><label>手机号码：</label><p><util:subHide numStr="${order.orderReceiverInfo.mobile }"  start="3" end="7" /></p></dd>
            <dd><label>收货地址：</label><p>${order.orderReceiverInfo.address }</p></dd>
        </dl>
        </c:if>
        
        <dl class="order-info-warp mt10">
       	<c:forEach var="product" items="${order.orderProductInfoList}">
       		<dd class="tr"><font class="gray-col">${product.merchantName }</font><label class="">商品信息</label></dd>
            <dd>
            <a href="javascript:;">
            <div class="o-goods-list clearfix" skuid="${product.skuId}" url="${product.url}">
	            <div class="list-thumb" ><img src="${product.icon }" /></div>
	            <div class="list-descriptions">
	              <div class="list-descriptions-wrapper">
	                <p class="product-name">${product.name }</p>
	                <p class="price"><font style="font-family:Arial;">¥</font><span id="money_1_${product.id }">${product.price }</span></p>
	              </div>
	            <div class="list-descriptions-info" class="tr">
	              <p class="cost">原价：<font style="font-family:Arial;">¥</font><span id="money_2_${product.id }">${product.denomination }</span></p>
	              <p class="number grar-col">x${product.count }</p>
	            </div>
	            </div>
            </div>
            </a>
            </dd>
            <dd class="tr"><font>${product.orderId }</font><label class="">订单号：</label></dd>
       	</c:forEach>
        </dl>
        
        <!-- 订单发票信息快照 -->
        <c:if test="${order.orderInfo.status != 12 && not empty order.orderInvoiceInfo}">
        	<dl class="text-warp mt10 clearfix">
	            <dt class="clearfix">
	            <p class="fr gray-col">
	            	<c:if test="${order.orderInvoiceInfo.type==1 }">纸质发票</c:if>
	            	<c:if test="${order.orderInvoiceInfo.type==2 }">电子发票</c:if>
	            	<c:if test="${order.orderInvoiceInfo.type==3 }">增值税发票</c:if>
	            </p>
	            <label>发票信息 </label></dt>
	            <dd><label>发票抬头：</label><p>${order.orderInvoiceInfo.title }</p></dd>
	            <dd><label>发票内容：</label><p>${order.orderInvoiceInfo.content }</p></dd>
	        </dl>
        </c:if>
        
        <c:if test="${not empty order.orderInfo}">
        	<dl class="text-warp mt10 clearfix">
	            <dt class="clearfix"><label>支付信息 </label></dt>
	            <dd><label>商品总额：</label><p class="price"><font style="font-family:Arial;">¥</font> <span id="money_3_${order.orderInfo.orderId}">${order.orderInfo.productAmount }</span></p></dd>
	            <dd><label>返现：</label><p class="price"><font style="font-family:Arial;">¥</font> <span id="money_4_${order.orderInfo.orderId}">0.00</span></p></dd>
	            <dd><label>运费：</label><p class="price"><font style="font-family:Arial;">¥</font> <span id="money_5_${order.orderInfo.orderId}">${order.orderInfo.amountDistribution }</span></p></dd>
	            <dd class="bottom-line"><label>商品优惠：</label><p class="price" style="font-family:Arial;">¥ <span id="money_6_${order.orderInfo.orderId}">${order.orderInfo.amountDiscount }</span></p></dd>
	            <dd class="infoTips">
	                <p class="tr">实付款：<span><font style="font-family:Arial;">¥</font> <font><span id="money_7_${order.orderInfo.orderId}">${order.orderInfo.amountPayable }</span></font></span></p>
	                <p>下单时间：
	                <fmt:formatDate value="${order.orderInfo.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/>  
	                </p>
	            </dd>
	        </dl>
        </c:if>
        
        <c:if test="${order.orderInfo!=null}">
        	<c:if test="${order.orderInfo.status==10 }">
        		<p class="mt10">
        		<a href="${ctx}/wangyin/pay/${order.orderInfo.orderId}" >
					<button type="button" class="btn-large btn-primary" style="position: fixed;width: 100%;bottom: 45px;" id="submit_Order" order="${order.orderInfo.orderId}">立即支付</button>
				</a>
				</p>
			</c:if>
        	<p class="mt10" id="btn_toSubmit">
            	<c:if test="${order.orderInfo.status==10 }">
					<button type="button" class="btn-large btn-primary" style="position: fixed;width: 100%;bottom: 0px;background: #d9cfc8;" id="submit_Order" onclick="toOrderCancel('${order.orderInfo.orderId}')">取消订单</button>
				</c:if>
				<c:if test="${order.orderInfo.status==20 && tenantId != 15}">
					<button type="button" class="btn-large btn-primary" id="submit_Order" onclick="toOrderConfirm('${order.orderInfo.orderId }');">确认收货</button>
				</c:if>
        	</p>
        	<c:if test="${order.orderInfo.status==20 || ((order.orderInfo.status==25 || order.orderInfo.status==35)&&(empty order.orderInfo.score || (order.orderInfo.score<1||order.orderInfo.score>5)) )}">
        		<%-- <div class="score mt10" id="div_toScore" <c:if test="${order.orderInfo.status==20}">style="display: none;"</c:if>>
		            <div class="label">给订单评个分吧！</div>
		            <div class="star">
		                <a href="javascript:;" data-val="1" onclick="touchstart(1)"></a>
		                <a href="javascript:;" data-val="2" onclick="touchstart(2)"></a>
		                <a href="javascript:;" data-val="3" onclick="touchstart(3)"></a>
		                <a href="javascript:;" data-val="4" onclick="touchstart(4)"></a>
		                <a href="javascript:;" data-val="5" onclick="touchstart(5)"></a>
		                <div class="star-warp" id="user_star_warp"  style="width: 125px"></div>
		                <input type="hidden" value="5" name="user_star_score" id="user_star_score" />
		            </div>
		            <div class="score-btn" onclick="toScore('${order.orderInfo.orderId}')">评分</div>
		        </div> --%>
	        	<div class="score mt10" id="div_hadScore_toShop" style="display: none;">
		            <!-- <div class="label">订单评分</div>
		            <div class="star">
		                <a href="javascript:;" data-val="1"></a>
		                <a href="javascript:;" data-val="2"></a>
		                <a href="javascript:;" data-val="3"></a>
		                <a href="javascript:;" data-val="4"></a>
		                <a href="javascript:;" data-val="5"></a>
		                <div class="star-warp" id="sys_star_warp" style="width: 125px"></div>
		                <input type="hidden" value="5" name="sys_star_score" id="sys_star_score" />
		            </div> -->
		            <c:if test="${order.orderProductInfoList!=null && fn:length(order.orderProductInfoList)>0}">
		            <div class="score-btn" onclick="pageRedirect('${cardshopDomain}')">继续逛逛</div>
					</c:if>
	            </div>
        	</c:if>
        	<c:if test="${(order.orderInfo.status==25 || order.orderInfo.status==35)&& not empty order.orderInfo.score && (order.orderInfo.score>0&&order.orderInfo.score<6) }">
	        	<div class="score mt10" >
		            <%-- <div class="label">订单评分</div>
		            <div class="star">
		                <a href="javascript:;" data-val="1"></a>
		                <a href="javascript:;" data-val="2"></a>
		                <a href="javascript:;" data-val="3"></a>
		                <a href="javascript:;" data-val="4"></a>
		                <a href="javascript:;" data-val="5"></a>
		                <div class="star-warp"  style="width: ${order.orderInfo.score*25}px"></div>
		            </div> --%>
		            <c:if test="${order.orderProductInfoList!=null && fn:length(order.orderProductInfoList)>0}">
		            <div class="score-btn" onclick="pageRedirect('${cardshopDomain}')">继续逛逛</div>
					</c:if>
	            </div>
        	</c:if>
        	<c:if test="${(order.orderInfo.status!=10 && order.orderInfo.status!=20) && !((order.orderInfo.status==25 || order.orderInfo.status==35)&& not empty order.orderInfo.score && (order.orderInfo.score>0&&order.orderInfo.score<6) )}">
				<p class="mt10" id="p_buy_agine">
				<a 
				<c:if test="${order.orderProductInfoList!=null && fn:length(order.orderProductInfoList)>0}">
					href="${cardshopDomain}" 
				</c:if>
				class="my-order-btn"> 
				<c:if test="${tenantId != 15 }"><button type="button" class="btn-large btn-primary" id="submit_Order">继续逛逛</button></c:if>
				</a>
				</p>
			</c:if>
        </c:if>
    </div>
    <input type="hidden" id="ctx" name="ctx" value="${ctx }">
    </form>
    <!-- <script type="text/javascript">
     $(".star a").on("touchstart",function(){
         var $me = $(this),
             $data_val = $me.attr("data-val");
         $me.siblings("input[type='hidden']").val($data_val);
         $me.siblings(".star-warp").width($data_val*25);
     })
	 </script> -->
<div style="display:none">
 	<form id="myform"  name="myform" method="POST" action="">
 		<input type="hidden" name="orderId" id="orderId" />
 		<input type="hidden" name="payChannel" id="payChannel" />
 		<input type="hidden" name="payStatus" id="payStatus" />
 	</form>
 </div>
</body>
<script type="text/javascript">
window.onload=function(){
OC.setTitle("订单详情");
$(".o-goods-list").on('click',function(event){
	var url;
	var target = event.target;
	for (var i=0; i<10; i++) {
		url = $(target).attr("url");
		if (OC.isEmpty(url)) {
			target = $(target).parent();
		} else {
			break;
		}
	}
	if (!OC.isEmpty(url)) {
		window.location.href=url;
	}
});

var orderId = "";
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
 var succCallback = function (json) {
  Tip.destory();
  if (json.code == 200) {
	  PAY.launchPayWindow(json.data, 'payCompleteCallback');
  } else {
    Tip.showMsg(json.data);
  }
 }
 var failCallback = function (args) {
Tip.destory();
Tip.showMsg("付款失败");
 }
 Tip.showLoading("加载中...");

 orderId = $(event.target).attr("order");
 OC.ajaxGet("${ctx}/wallet/pay/data?orderId=" + orderId,null,succCallback, failCallback);
});
}
</script>
</html>