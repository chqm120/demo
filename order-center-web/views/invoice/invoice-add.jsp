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
    <form class="form-inline" method="POST" action="${ctx}/invoice/choose">
    <div class="main">
        <dl class="invoice-list">
        	<dt><span class="fr red-col cost <c:if test="${isWriteInvoice == false }">hide</c:if>">配送费用：${postage }元</span><label class="">发票内容</label></dt>
            <dd><a href="javascript:;" class="invoice-content <c:if test="${isWriteInvoice == false}">on</c:if>" invoice_id="-1" ><i></i>不开发票</a>
            	<c:forEach var="item" items="${list }">
            	<c:if test="${oc.invoiceId == item.id }"><a href="javascript:;" class="invoice-content on" invoice_id="${item.id}"><i></i>${item.name }</a></c:if>
            	<c:if test="${oc.invoiceId != item.id }"><a href="javascript:;" class="invoice-content   " invoice_id="${item.id}"><i></i>${item.name }</a></c:if>
            	</c:forEach>
            </dd>
        </dl>
        <div class="invoice-info <c:if test="${isWriteInvoice == false}">hide</c:if>">
            <div class="clearfix invoice-title"><p class="fl invoicetag">发票抬头</p>
            <c:if test="${isWriteInvoice == false}"><c:set var="invoiceTitle" value="个人"/></c:if>
            <c:if test="${isWriteInvoice == true }"><c:set var="invoiceTitle" value="${oc.invoiceTitle }"/></c:if>
            <p class="clearfix"><input type="text" id="invoice_title" class="invoice-edit" name="invoice_title"  value="${invoiceTitle}" /></p></div>
        </div>
        <p class="form-item btn-wrap mt10">
            <button type="submit" class="btn-large btn-primary" disabled="disabled" submit="false">确定</button>
        </p>
    </div>
    <input id="invoice_id" name="invoice_id" value="${oc.invoiceId }" type="hidden"/>
    <input id="merchant_id" name="merchant_id" value="${merchantId }" type="hidden"/>
    </form>

    <script type="text/javascript" src="${ctx }/static/js/lib/zepto.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/ordercenter.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/tip.js"></script>
    <script type="text/javascript">
    window.onload=function(){
        function check() {
        	var invoice_id = $("#invoice_id").val();
        	if (invoice_id == -1 || invoice_id == '-1') {
        		return true;
        	}
        	if (OC.isEmpty(invoice_id)) {
        		return false;
        	}
        	
        	var title = $("#invoice_title").val();
        	if (OC.isEmpty(title)) {
        		return false;
        	} else if (OC.xssCheck(title)) {
        		return false;
        	}
        	return true;
        }
        function uptStatus() {
        	var result = check();
    		if (result == true) {
    			console.log(true);
    			$(".btn-primary").removeAttr("disabled");
    			$(".btn-primary").attr("submit", "true");
    		} else {
    			$(".btn-primary").attr("disabled","disabled");
    			$(".btn-primary").attr("submit", "false");
    		}
        }
        
        var interval = setInterval(function(){
        	uptStatus();
    	}, 500);
        
        var $invoice_list = $(".invoice-list"),
            $invoice_list_a = $invoice_list.find("a");
        
        $invoice_list_a.on("click",function(e){
            $(".invoice-list").find("a").removeClass("on");
            $(this).addClass("on");
            var invoice_id = $(this).attr("invoice_id");
            if (invoice_id == '-1') {
            	$(".cost").hide();
            	$(".invoice-info").hide();
            } else {
            	$(".cost").show();
            	$(".invoice-info").show();
            }
            $("#invoice_id").val(invoice_id);
        });
        uptStatus();
    }
    </script>
</body>
</html>
