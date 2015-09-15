<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%--
 --%><%@ include file="../comm/taglibs.jsp"%><%--
 --%>
<c:choose>
<c:when test="${skuInfo.type == 1}">
<div class="mt10 bgwhite lh25 pt10 pb10 pl15 pr15 J_addcode disbox posrel">
<div class="gray mw90">
	<div class="disbox fs18 .recevierInfo">
		<p class="">收货信息</p>
		<div class="black5 flex1 ml10">
		<c:if test="${not empty userAddress }">
			<p class=""><span>${userAddress.name }</span><span class="gray ml10 mr10">|</span><span>${userAddress.mobilePhone}</span></p>
			<p class="fs14 pt5 lh20">${userAddress.address.detail}</p>
		</c:if>
		</div>
	</div>
</div>
<span class="angle mr10"></span>
</div>
</c:when>
<c:when test="${skuInfo.type == 3}">
<div class="mt10 bgwhite lh25 pt10 pb10 pl15 pr15 J_addcode disbox posrel">
<div class="gray">
	<p class="fs18">手机号码<span class="black5 ml10" id="phone_no">${memberPhoneInfo.mobilePhone}</span></p>
	<p class="fs12">购买成功后请您前往交易记录查看订单信息。</p>
</div>
<span class="angle mr10"></span>
</div>
</c:when>
<c:when test="${skuInfo.type == 6}">
<div class="mt10 bgwhite lh25 pt10 pb10 pl15 pr15 J_addcode disbox posrel">
<div class="gray">
	<p class="fs18">手机号码<span class="black5 ml10" id="phone_no">${memberPhoneInfo.mobilePhone}</span></p>
	<p class="fs12">购买成功后请您前往交易记录查看订单信息。</p>
</div>
<span class="angle mr10"></span>
</div>
<div class="mt10 list">
<p class="pl15 lh30 bgwhite gray fs14">个人信息</p>
<ul class="lh40 fs14 lsn bgwhite pl15 borderb">
	<li class="row disbox borderb pr15">
		<div class="black3 ww12">真实姓名</div>
		<div class="gray">${realname }</div>
	</li>
	<li class="row disbox borderb pr15">
		<div class="black3 ww12" >
			身份证号
		</div>
		<div class="gray">${certiNo}</div>
	</li>
	<c:if test="${skuInfo.subType == 2 }">
	<li class="row disbox pr15">
		<div class="black3 ww12">投保城市</div>
	</li>
	</c:if>
</ul>
<c:if test="${skuInfo.subType == 2 }">
<div class="bgwhite">
	<textarea class="textarea w100 p-15-15 vam bsb" placeholder="填写前请仔细阅读投保城市范围"></textarea>
</div>
</c:if>
</div>
</c:when>
</c:choose>
