<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%--
 --%><%@ include file="../comm/taglibs.jsp"%><%--
  --%><html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>确定订单</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no">
    <jsp:include page="../comm/static-resources.jsp"></jsp:include>
    <link rel="stylesheet" href="${ctx }/static/css/global.css"/>
    <link rel="stylesheet" href="${ctx }/static/css/display.css"/>
    <script type="text/javascript">
    var domain='${domain}';
    var sn = '${serialNumber}';
    // var numb = ${num};
    var skuId = '${productInfoDTO.skuid}';
    </script>
</head>
<body>
    <div class="main">
        <c:if test="${needAddr == true}">
        <dl class="text-warp clearfix addReceiverInfo" >
            <dt class="clearfix" style="padding:0px; margin:0px 15px;">
            <div class="look-card-userName" style="padding-left:0px;">
                <a href="javascript:;">
                <c:if test="${not empty address }"><span class="arrow-ico"></span><span class="fr ms10">选择地址</span><label>收货信息 </label></c:if>
                <c:if test="${    empty address }"><span class="arrow-ico"></span><span class="fr ms10">新增地址</span><label>收货信息 </label></c:if>
                </a>
            </div>
            </dt>
            <c:if test="${not empty address }">
            <dd><label>收货人：</label><p>${address.name }</p></dd>
            <dd><label>手机号码：</label><p>${receiver_mobile }</p></dd>
            <dd><label>收货地址：</label><p>${address.address.detail }</p></dd>
            </c:if>
        </dl>
        </c:if>
        <div class="goods-list clearfix">
            <div class="list-thumb"><img src="${icon}"/></div>
            <div class="list-descriptions clearfix ms10">
                <div class="list-descriptions-wrapper">
                    <p class="product-name">${productInfoDTO.skuName}</p>
                    <p class="product-name">&nbsp;</p>
                    <div>
                        <div class="quantity-wrapper fr">
                             <input type="hidden" id="limitSukNum" value=""/>
                             <%-- <a class="quantity-decrease disabled" id="subWareBybutton" target-id="${productInfoDTO.skuid}">-</a> --%>
                             <input type="hidden" size="4" value="${num==null? 1 : num}" name="num" id="" class="quantity"onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" />
                            <%--  <a class="quantity-increase" id="addWareBybutton" target-id="${productInfoDTO.skuid}">+</a> --%>
                         </div>
                         <p class="fl"><font style="font-family:Arial;">¥</font><span class="price" id="price_${productInfoDTO.skuid }">${price}</span></p>
                    </div>
                </div>
            </div>
        </div>
        <dl class="info-warp">
        <c:if test="${productInfoDTO.type == 1 }"><dd><c:if test="${empty productInfoDTO.sellMerchantName }">&nbsp;</c:if><c:if test="${not empty productInfoDTO.sellMerchantName }">${productInfoDTO.sellMerchantName }</c:if><label class="gray-col">配送商家</label></dd></c:if>
        <c:if test="${supportInvoice == true}">
        <c:if test="${isWriteInvoice == true }">
        <dd><a href="javascript:;" id="invoice"><font style="margin-right:15px;" class="gray-col">${invoiceContent}</font><div class="right-ico"></div><label class="gray-col">是否开具发票</label></a></dd>
        </c:if>
        <c:if test="${isWriteInvoice == false }">
        <dd><a href="javascript:;" id="invoice"><font style="margin-right:25px;" class="gray-col">不开具发票</font><div class="right-ico"></div><label class="gray-col" clstag="card|card_buypage|card_buypage_invoice">是否开具发票</label></a></dd>
        </c:if>
        </c:if>
        </dl>
        <dl class="amount-warp mt10">
            <dd>
                <p><span class="fr">－  <font style="font-family:Arial;">¥</font> 0.00</span>返现</p>
                <p><span class="fr">+  <font style="font-family:Arial;">¥</font> ${postage}</span>运费</p>
                <p><span class="fr" id="view_deno">－  <font style="font-family:Arial;">¥</font> ${discount }</span>商品优惠</p>
            </dd>
            <dt><span class="fr fontCol"><font style="font-family:Arial;">¥</font><font id="pay_amount">${payAmount}</font></span><label class="gray-col">实付款</label></dt>
        </dl>
        <p class="buyList-tips">请在 30分钟内完成付款，否则订单将自动关闭。</p>
        <p class="form-item btn-wrap mt10"><button type="button" class="btn-large btn-primary" id="submit_Order">提交订单</button></p>
    </div>
    <form class="form-inline" method="POST" action="${ctx }/order/create/v1">
    <div class="popWin">
        <div class="popWin-content">
            <div class="title">确认订单</div>
            <c:if test="${productInfoDTO.type == 1 }">
            <div class="my-info bottom-line">
            <ul>
            <li><label class="tag ">收货人</label><p class="desc"><span class="">${address.name }</span><font class="ms10">|</font><span>${receiver_mobile }</span></p></li>
            <li><label class="tag f12 ">收货地址</label><p class="desc f12">${address.address.detail }</p></li>
            </ul>
            </div>
            </c:if>
            <dl class="amount-warp bottom-line">
                <dd>
                    <p><span class="fr">${productInfoDTO.skuName}</span>商品名称</p>
                    <p><span class="fr" id="view_sku_num">x1</span>数量</p>
                    <p><span class="fr" id="view_sku_amount">－  <font style="font-family:Arial;">¥</font> ${payAmount}</span>商品总额</p>
                    <%-- <p><span class="fr">－  <font style="font-family:Arial;">¥</font> 0.00</span>返现</p> --%>
                    <p><span class="fr">+  <font style="font-family:Arial;">¥</font> ${postage }</span>运费</p>
                    <p><span class="fr" id="confirm_deno">－ <font style="font-family:Arial;">¥</font> ${discount }</span>商品优惠</p>
                </dd>
            </dl>
            <div class="total">共计：<font class="price" id="view_amount"><font style="font-family:Arial;">¥</font> ${payAmount}</font></div>
            <div class="btn-warp">
                <p class="btn-warp-box">
                    <button type="button" class="back-btn">返回</button>
                </p>
                <p class="btn-warp-box">
                    <button type="button" class="submit-btn">提交</button>
                </p>
            </div>
        </div>
        <div class="popWin-bg"></div>
    </div>
<input type="hidden" id="sku_id" name="sku_id" value="${productInfoDTO.skuid }"/>
<input type="hidden" id="sku_num" name="num" value="${num}">
<input type="hidden" id="sku_price" name="sku_price" value="${price}">
<input type="hidden" id="postage" name="postage" value="${postage}"/>
<input type="hidden" id="denomination" value="${productInfoDTO.denomination }" />
</form>
<input type="hidden" name="stock_count" id="stock_count" value="${stockCount}" />
<c:if test="${needAddr == true }">
<input type="hidden" id="needAddr" value="true">
<c:if test="${empty address }"><input type="hidden" id="hasAddr" value="false"></c:if>
<c:if test="${not empty address }"><input type="hidden" id="hasAddr" value="true"></c:if>
</c:if>
<c:if test="${needAddr == false }"><input type="hidden" id="needAddr" value="false"></c:if>

<div style="display:none">
 	<form id="myform"  name="myform" method="POST" action="">
 		<input type="hidden" name="orderId" id="orderId" />
 		<input type="hidden" name="payChannel" id="payChannel" />
 		<input type="hidden" name="payStatus" id="payStatus" />
 	</form>
 </div>
<script type="text/javascript" src="${ctx }/static/js/lib/zepto.js"></script>
<script type="text/javascript" src="${ctx }/static/js/lib/zepto.cookie.js"></script>
<script type="text/javascript" src="${ctx }/static/js/order-confirm.js"></script>
<script type="text/javascript" src="${ctx }/static/js/tip.js"></script>
<script type="text/javascript" src="${ctx }/static/js/ordercenter.js"></script>
<script type="text/javascript" src="${ctx }/static/js/pay.js"></script>

<script type="text/javascript">
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
(function(){

<c:if test="${tenantId == '10'}">
OC.setTitle("购买");
OC.initClientInfo();
</c:if>
$.fn.cookie('from', 'confirm', {path:'/',expires:1800});

$(".submit-btn").on('click',function(){
     //if(ClientInfo.isRealName == 1) {
         if (OC.isEmpty(orderId)) {
             //用户已经实名认证
            Tip.showLoading('加载中.....');
            var succCallback = function (args) {
                Tip.destory();
                if (args.code == 200) {
                    orderId = args.data;
                    pay(orderId);
                } else {
                    Tip.showMsg(args.data);
                }
            };
            var failCallback = function (args) {
                Tip.destory();
                Tip.showMsg("提交订单失败，请重试");
            };
            OC.ajaxPost("${ctx}/order/create/v1",{},succCallback,failCallback);
         } else {
            pay(orderId);
         }
   // } else {
        //用户未实名，调用实名认证接口
   //     OC.verifyRealName();
  //  }
});

function pay(orderId) {
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
}

})();
</script>
</body>
</html>
</body>
</html>
