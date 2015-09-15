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
        <div class="goods-list clearfix">
            <div class="list-thumb"><img src="${icon}"/></div>
            <div class="list-descriptions clearfix ms10">
                <div class="list-descriptions-wrapper">
                    <p class="product-name">${productInfoDTO.skuName}</p>
                    <p class="product-name">&nbsp;</p>
                    <div>
                    <div class="quantity-wrapper fr" style="display:none;">
                        <input type="hidden" id="limitSukNum" value=""/>
                        <a class="quantity-decrease disabled" id="subWareBybutton" target-id="${productInfoDTO.skuid}">-</a>
                        <input type="text" size="4" value="1" name="num" id="" class="quantity"onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" />
                        <a class="quantity-increase" id="addWareBybutton" target-id="${productInfoDTO.skuid}">+</a>
                    </div>
                        <p class="fl">¥<span class="price" id="price_${productInfoDTO.skuid }">${price}</span></p>
                    </div>
                </div>
            </div>
        </div>
        <dl class="info-warp">
        </dl>
        <dl class="amount-warp mt10">
            <dd>
                <p><span class="fr">－  ¥ 0.00</span>返现</p>
                <p><span class="fr">+  ¥ ${postage}</span>运费</p>
                <p><span class="fr" id="view_deno">－  ¥ ${discount }</span>商品优惠</p>
            </dd>
            <dt><span class="fr fontCol">¥<font id="pay_amount">${payAmount}</font></span><label class="gray-col">实付款</label></dt>
        </dl>
        <p class="buyList-tips">请在 30分钟内完成付款，否则订单将自动关闭。</p>
        <p class="form-item btn-wrap mt10"><button type="button" class="btn-large btn-primary" id="submit_Order">提交订单</button></p>
    </div>
    <form class="form-inline" method="POST" action="${ctx }/order/create/v1">
    <div class="popWin">
        <div class="popWin-content">
            <div class="title">确认订单</div>
            <dl class="amount-warp bottom-line">
                <dd>
                    <p><span class="fr">${productInfoDTO.skuName}</span>商品名称</p>
                    <p><span class="fr" id="view_sku_num">x1</span>数量</p>
                    <p><span class="fr" id="view_sku_amount">－  ¥ ${payAmount}</span>商品总额</p>
                    <%-- <p><span class="fr">－  ¥ 0.00</span>返现</p> --%>
                    <p><span class="fr">+  ¥ ${postage }</span>运费</p>
                    <p><span class="fr" id="confirm_deno">－  ¥ ${discount }</span>商品优惠</p>
                </dd>
            </dl>
            <div class="total">共计：<font class="price" id="view_amount">¥ ${payAmount}</font></div>
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
<input type="hidden" id="denomination" value="${productInfoDTO.denomination }">
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
<script type="text/javascript" src="${ctx }/static/js/tip.js"></script>
<script type="text/javascript" src="${ctx }/static/js/ordercenter.js"></script>
<script type="text/javascript" src="${ctx }/static/js/pay.js"></script>

<script type="text/javascript">
var orderId = "";

(function(){
$.fn.cookie('from', 'confirm', {path:'/',expires:1800});
$(".submit-btn").on('click',function(){
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
    OC.ajaxPost("${ctx}/order/create/jddj",{},succCallback,failCallback);
});

function pay(orderId) {
    window.location.href='${ctx}/wangyin/pay/' + orderId;
}

})();
</script>

<script type="text/javascript">
function centerBox(){
    var winWidth = $(window).width(),
        winHeight = $(window).height(),
        popWin = $(".popWin"),
        pop_c = popWin.find(".popWin-content"),
        popWin_W = popWin.width(),
        popWin_H = popWin.height(),
        pop_c_W = pop_c.width(),
        pop_c_H = pop_c.height(),
        w = (popWin_W-pop_c_W)/2,
        h = (popWin_H-pop_c_H)/2,
        cw = winWidth-30;
    pop_c.css({"width":cw+"px","margin-top":h+"px"});
}

var $quantity_wrapper = $(".quantity-wrapper"),
	$subWareBybutton = $quantity_wrapper.find("#subWareBybutton"),
	$addWareBybutton = $quantity_wrapper.find("#addWareBybutton"),
	$quantity = $quantity_wrapper.find(".quantity"),
	$back_btn = $(".back-btn"),
	$limitSukNum = $quantity_wrapper.find("#limitSukNum");
var $submit_Order = $("#submit_Order");
//点击提交订单
$submit_Order.on("click",function(){
    //判断商品数量为数值
    var sku_num = 1;
    $.fn.cookie('o_num', sku_num, {path:'/',expires:1800});
    $(".popWin").show();
    centerBox();
});
//弹窗返回
$back_btn.on("click",function(){
    $(".popWin").hide();
});
$(".addReceiverInfo").on('click',function(){
    window.location.href=domain+'/receiver/list';
});
//输入框 变更事件
$quantity.on("input",function(){
    var me = $(this),
        meVal = parseFloat(me.val()==''? 0 : me.val()),
        length = meVal.length,
        buyBtn = $(".buy-btns-fixed .nowbuy-btn");
    if(!meVal){
        Tip.showMsg('购买数量不能为空');
        $submit_Order && $submit_Order.attr("disabled","disabled");
        buyBtn && (buyBtn.attr("buy","false") && buyBtn.addClass("on"));
    }else if(meVal > $stock_count){
        Tip.showMsg("没有那么多库存啦~");
        $submit_Order &&  $submit_Order.attr("disabled","disabled");
        buyBtn && (buyBtn.attr("buy","false") && buyBtn.addClass("on"));
        return;
    }else if(meVal >= 1000 ){
        Tip.showMsg('购买数量过大~');
        $submit_Order && $submit_Order.attr("disabled","disabled");
        buyBtn && (buyBtn.attr("buy","false") && buyBtn.addClass("on"));
        return;
    }else{
        buyBtn && (buyBtn.attr("buy","true") && buyBtn.removeClass("on"));
        $submit_Order && $submit_Order.removeAttr("disabled");
        $("#limitSukNum").val(meVal);
        $("#sku_num").val(meVal);
        countPrice(meVal);
    }
})

function round2(number,fractionDigits){
    with(Math){
        return round(number*pow(10,fractionDigits))/pow(10,fractionDigits);
    }
}
//计算弹窗里的数值
function countPrice(numb){
    var targetId = $("#subWareBybutton").attr("target-id");
    var price = parseFloat($("#price_" + targetId).text());                  // 单价
    var postage = $("#postage").val();
    var count = (parseFloat(numb * price) + parseFloat(postage));                               // 总价
    var denomination = $("#denomination").val();                 // 单价
    var newDenomination = (denomination - price) * numb;          // 
    newDenomination = newDenomination.toFixed(2);                // 商品优惠总额
    if(count>10000){
        Tip.showMsg('单笔总金额不能超过1万噢~');
        $("#submit_Order").attr("disabled","disabled");
    }else{
        $("#view_amount").text(round2(count,2));                               // 确认弹窗-商品共计
        $("#pay_amount").text(round2(count,2));                                // 实付款
        $("#view_deno").text("- ¥ " + newDenomination);              // 商品优惠总额
        $("#confirm_deno").text("- ¥ " + newDenomination);           // 确认弹窗-商品优惠总额
        $("#submit_Order").removeAttr("disabled");
    }
}
</script>
</body>
</html>
</body>
</html>
