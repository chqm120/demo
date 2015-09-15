<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
 --%>
 <%@ include file="../comm/taglibs.jsp"%>
 <%--
  --%>
 <!DOCTYPE html>
<html>
<head>
<title>结算页</title>
    <jsp:include page="../comm/static-resources.jsp"></jsp:include>
    <script type="text/javascript" src="${ctx }/static/js/lib/zepto.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/lib/zepto.cookie.js"></script>
</head>

<body>
<form action="${payDTO.serverUrl}" name="frm" method="post" id="frm">
	<input type="hidden" id="orderNoId" name="orderNo" value="${order}"/>
	<input type="hidden" id="orderStatusId" name="orderStatus" value="13"/>
	<input type="hidden" id="scoreId" name="score" value="0"/>
	<input type="hidden" id="tradeAmount" name="type" value="1"/>
	<input type="hidden" name="version" value="${payDTO.version}"/>
	<input type="hidden" name="token" value="${payDTO.token}"/>
	<input type="hidden" name="merchantSign" value="${payDTO.merchantSign}"/>
	<input type="hidden" name="merchantNum" value="${payDTO.merchantNum}"/>
	<input type="hidden" name="merchantRemark" value="${payDTO.merchantRemark}"/>
	<input type="hidden" name="tradeNum" value="${payDTO.tradeNum}"/>
	<input type="hidden" name="tradeName" value="${payDTO.tradeName}"/>
	<input type="hidden" name="tradeDescription" value="${payDTO.tradeDescription}"/>
	<input type="hidden" name="tradeTime" value="${payDTO.tradeTime}"/>
	<input type="hidden" name="tradeAmount" value="${payDTO.tradeAmount}"/>
	<input type="hidden" name="currency" value="${payDTO.currency}"/>
	<input type="hidden" name="notifyUrl" value="${payDTO.notifyUrl}"/>
	<input type="hidden" name="successCallbackUrl" value="${payDTO.successCallbackUrl}"/>
	<input type="hidden" name="failCallbackUrl" value="${payDTO.failCallbackUrl}"/>
	<input type="hidden" name="jdPin" value="${payDTO.jdPin}">
</form>
</body>

<script>
window.onload = function(){
	$("#frm").submit();
}
</script>
</html>