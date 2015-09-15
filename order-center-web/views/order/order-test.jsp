<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%--
 --%><%@ include file="../comm/taglibs.jsp"%><%--
  --%><!DOCTYPE html>
<html>
<head>
<title>礼品卡超市</title>
<jsp:include page="../comm/static-resources.jsp"></jsp:include>
</head>

<body>


<br><br>
<a href="${ctx }/mock/login/1">模拟登录</a>

<br><br>
<a href="${ctx }/receiver/list">收货地址列表</a>

<br><br>
<a href="${ctx }/order/mylist">我的订单</a>

<h3>进入确认订单页面</h3>
<form action="${ctx }/order/cs/confirm/single" method="get">
<table>
<tr><td>SKU_ID:</td><td><input type="text" value="1" name="sku_id" size="35"></td></tr>
<tr><td>NUM:</td><td><input type="text" value="1" name="num" size="35"></td></tr>
<tr><td colspan="2"><input type="submit" value="SUBMIT"></td></tr>
</table>
</form>

<br><br>
<h3>创建订单</h3>
<form action="${ctx }/order/create/v1" method="post">
<table>
<tr><td>是否需要收货地址:</td><td><input type="text" value="false" name="need_receiver_addr"  size="35"></td></tr>
<tr><td>收货地址id:</td><td><input type="text" value="1" name="receiver_id" size="35"></td></tr>
<tr><td>sku_id:</td><td><input type="text" value="1" name="sku_id" size="35"></td></tr>
<tr><td>num:</td><td><input type="text" value="1" name="num" size="35"></td></tr>
<tr><td>是否需要发票:</td><td><input type="text" value="false" name="need_invoice" size="35"></td></tr>
<tr><td>发票类型id:</td><td><input type="text" value="1" name="invoice_type_id" size="35"></td></tr>
<tr><td>发票title:</td><td><input type="text" value="title" name="invoice_title" size="35"></td></tr>
<tr><td>发票类型:</td><td><input type="text" value="11" name="invoice_content" size="35"></td></tr>
<tr><td colspan="2"><input type="submit" value="SUBMIT"></td></tr>
</table>
</form>


<br><br>
<h3>支付</h3>
<form action="${ctx }/pay" method="post">
<table>
<tr><td>支付平台</td><td><input type="text" name="platform" value="wangyin" size="35"></td></tr>
<tr><td>订单id</td><td><input type="text" name="orderId" value="" size="35"></td></tr>
<tr><td colspan="2"><input type="submit" value="SUBMIT"></td></tr>
</table>
</form>

<br><br>
<h3>退款</h3>
<form action="${ctx }/order/refund" method="get">
<table>
<tr><td>订单id</td><td><input type="text" name="orderId" value="" size="35"></td></tr>
<tr><td colspan="2"><input type="submit" value="SUBMIT"></td></tr>
</table>
</form>

<br><br>
<h3>添加发票</h3>
<form action="${ctx }/invoice/tochoose" method="get">
<table>
<tr><td>商户id</td><td><input type="text" name="merchant_id" value="17" size="35"></td></tr>
<tr><td colspan="2"><input type="submit" value="SUBMIT"></td></tr>
</table>
</form>
<br><br>

</body>
</html>