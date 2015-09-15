<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%--
 --%><%@ include file="../comm/taglibs.jsp"%><%--
  --%><html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>支付完成</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no">
    <link rel="stylesheet" href="${ctx }/static/css/global.css"/>
    <link rel="stylesheet" href="${ctx }/static/css/trade-record.css"/>
    <script type="text/javascript" src="${ctx }/static/js/lib/zepto.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/lib/zepto.cookie.js"></script>
</head>
<body class="record-detail-body">
    <div class="record-detail">
        <div class="record-status g-status g-status-success">
            <div class="record-infoWarp">
            <c:if test="${status == 'fail' }">
             <p class="title">支付失败</p>
             <p class="info">&nbsp;</p>
             <p class="mt10">&nbsp;</p>
            </c:if>
            <c:if test="${status == 'succ' }">
            <p class="title">支付成功</p>
            <p class="info">将尽快为您发货，请耐心等候</p>
            <p class="mt10"><a class="link" pname="${skuName}" href="javascript:;" id="share">分享给朋友</a></p>
            </c:if>
            <c:if test="${status == 'ing' }">
               <p class="title">购买申请已提交</p>
               <p class="info">请3分钟后刷新订单详情页查看结果</p>
            </c:if>
            </div>
        </div>
    </div>
    <form class="form-inline" method="POST">
    	<c:if test="${status == 'succ' }">
    	<p class="form-item btn-wrap mt10">
        <button type="button" class="btn-large btn-primary">查看订单</button>
        </p>
        <c:if test="${tenantId != 15 }">
        <p class="form-item btn-wrap">
        <button type="button" class="btn-large goon">继续逛逛</button>
        </p>
        </c:if>
        </c:if>
        <c:if test="${status == 'fail' && tenantId != 15}">
        <p class="form-item btn-wrap">
        <button type="button" class="btn-large goon">继续逛逛</button>
        </p>
        </c:if>
        <c:if test="${status == 'ing' }">
        <p class="form-item btn-wrap mt10">
        <button type="button" class="btn-large btn-primary">查看订单</button>
        </p>
        <c:if test="${tenantId != 15 }">
        <p class="form-item btn-wrap">
        <button type="button" class="btn-large goon">继续逛逛</button>
        </p>
        </c:if>
        </c:if>
    </form>
<script type="text/javascript" src="${ctx }/static/js/tip.js"></script>
<script type="text/javascript" src="${ctx }/static/js/ordercenter.js"></script>
<script type="text/javascript">
//卡超市域名
var domain = '${cardshopDomain}';
OC.setTitle("支付完成");
$(".goon").on('click',function(){
	window.location.href='${cardshopDomain}';
});
$(".btn-primary").on('click',function(){
	window.location.href="${domain}/mine/od/detail/${orderId}";
});
$(".link").bind('click',function(){
	OC.wystat("/qiang-front/share");//锚点，统计分享量
	OC.shareLink(domain+"/share","${skuName}","我在嗨购只花1分钱就抢到了这个，不信你看~");
});
</script>
</body>
</html>
