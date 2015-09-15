<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%--
 --%><%@ include file="comm/taglibs.jsp"%><%--
  --%><html lang="zh_CN">
<head>
<meta charset="UTF-8">
<title>礼品卡超市</title>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no">
<link rel="stylesheet" href="${ctx }/static/css/global.css"/>
<link rel="stylesheet" href="${ctx }/static/css/trade-record.css"/>
<script type="text/javascript" src="${ctx }/static/js/lib/zepto.js"></script>
<script type="text/javascript" src="${ctx }/static/js/lib/zepto.cookie.js"></script>
<script type="text/javascript" src="${ctx }/static/js/ordercenter.js"></script>
</head>
<body class="record-detail-body">
    <div >
        <div class="record-detail">
        	<c:if test="${status == 'pay_succ' }">
            <div class="record-status g-status g-status-success">
                <div class="record-infoWarp">
                    <p class="title">付款成功</p>
                    <p class="info">${msg }</p>
                    <p class="mt10"><a class="link" href="javascript:;">分享给朋友</a></p>
                </div>
            </div>
            </c:if>
            <c:if test="${status == 'succ' }">
            <div class="record-status g-status g-status-success">
                <div class="record-infoWarp">
                    <p class="info">${msg }</p>
                </div>
            </div>
            </c:if>
            <c:if test="${status == 'fail' }">
            <div class="record-status g-status g-status-error">
                <div class="record-infoWarp">
                	<p class="title">${msgTitle}</p>
                    <p class="info">${msg }</p>
                </div>
            </div>
            </c:if>
            <c:if test="${status == 'warn' }">
            <div class="record-status g-status g-status-warn">
                <div class="record-infoWarp">
                    <p class="title">警告状态</p>
                    <p class="info">${msg }</p>
                </div>
            </div>
            </c:if>
            <c:if test="${status == 'unknown' }">
            <div class="record-status g-status g-status-unknown">
                <div class="record-infoWarp">
                    <p class="title">疑问状态</p>
                    <p class="info">${msg }</p>
                </div>
            </div>
            </c:if>
            <c:if test="${status == 'info' }">
            <div class="record-status g-status g-status-info">
                <div class="record-infoWarp">
                    <p class="title">通知状态</p>
                    <p class="info">${msg }</p>
                </div>
            </div>
            </c:if>
        </div>
        <form class="form-inline" method="POST">
        <c:if test="${status == 'pay_succ' || status == 'pay_fail' }">
        <p class="form-item btn-wrap mt10">
        <button type="button" class="btn-large btn-primary">查看订单</button>
        </p>
        </c:if>
        <p class="form-item btn-wrap">
        <button type="button" class="btn-large goon">继续逛逛</button>
		</p>
		</form>
    </div>
<!--<script src="../js/lib/require.js" data-main="../js/pages/trade-record"></script>-->
<script type="text/javascript">
window.onload=function() {
	OC.setTitle("错误");
}
$(".goon").on('click',function(){
	window.location.href="${cardshopDomain}";
});
</script>
</body>
</html>
