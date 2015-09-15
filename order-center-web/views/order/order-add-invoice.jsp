<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%--
 --%><%@ include file="../comm/taglibs.jsp"%><%--
  --%><html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>京东钱包</title>
    <jsp:include page="../comm/static-resources.jsp"></jsp:include>
    <link rel="stylesheet" href="${ctx }/static/css/global.css"/>
    <link rel="stylesheet" href="${ctx }/static/css/display.css"/>
</head>
<body>
    <form class="form-inline" method="POST" action="/invoice/choose">
    <div class="main">
        <dl class="invoice-list">
            <dt><label class="">发票内容</label></dt>
            <dd>
            	<c:forEach var="item" items="${list }"><a href="javascript:;" class="invoice-content" invoice_id="${item.id}"><i></i>明细</a></c:forEach>
            </dd>
        </dl>
        <div class="invoice-info">
            <div class="clearfix invoice-title"><p class="fl  invoicetag">发票抬头</p>
            <p class="clearfix"><input type="text" id="" class="invoice-edit" name="invoice_title"  value="" /></p></div>
        </div>
        <p class="form-item btn-wrap mt10">
            <button type="submit" class="btn-large btn-primary">确定</button>
        </p>
    </div>
    <input id="invoice_id" name="invoice_id" value="" type="hidden"/>
    <input id="merchant_id" name="merchant_id" value="${merchantId }" type="hidden"/>
    </form>
<script src="${ctx }/static/js/lib/require.js?v=${version}" data-main="${ctx }/static/js/pages/invoice"></script>
<script type="text/javascript" src="${ctx }/static/js/ordercenter.js"></script>    
<script type="text/javascript">
OC.setTitle("选择发票");
</script>
</body>
</html>
