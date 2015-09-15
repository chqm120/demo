<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../comm/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>我的订单</title>
<jsp:include page="../comm/static-resources.jsp"></jsp:include>
<link rel="stylesheet" href="${ctx }/static/css/global.css" />
</head>

<body>
<div class="no-order ">
	<div class="no-pic"></div>
	<p class="order-info">您还没有订单噢~</p>
	<form class="form-inline" method="GET">
		<c:if test="${tenantId != 15}">
		<p class="form-item btn-wrap mt10">
			<a class="btn-large btn-primary" href="${cardshopDomain}">继续逛逛</a>
		</p>
		</c:if>
		<p class="form-item btn-wrap">
			<a class="btn-large" href="javascript:;" id="back">返回</a>
		</p>
	</form>
</div>
<script type="text/javascript" src="${ctx }/static/js/lib/zepto.js"></script>
<script type="text/javascript" src="${ctx }/static/js/ordercenter.js"></script>
<script type="text/javascript">
window.onload = function() {
<c:if test="${tenantId != 15}">OC.setTitle("我的订单");</c:if>
 $("#back").on('click',function(){
	 history.go(-1);
 });
}
</script>
</body>
</html>