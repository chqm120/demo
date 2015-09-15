<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%--
 --%><%@ include file="../comm/taglibs.jsp"%><%--
  --%><html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>我的收货地址</title>
    <jsp:include page="../comm/static-resources.jsp"></jsp:include>
    <link rel="stylesheet" href="${ctx }/static/css/global.css?v=${version}"/>
    <link rel="stylesheet" href="${ctx }/static/css/addr-list.css?v=${version}"/>
    <script type="text/javascript" src="${ctx }/static/js/lib/zepto.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/lib/zepto.cookie.js"></script>
    <script type="text/javascript" src="${ctx }/static/js/ordercenter.js"></script>
</head>
<body>
    <form class="form-inline" method="get" action="${ctx }/receiver/default">
    <div>
        <div id="J_addrList">
            <ul class="addr-list">
            	<c:forEach var="item" items="${list }">
                <li>
                <c:if test="${defaultAddress.id == item.id }"><span class="icon-addr addr-ccb on" item_id="${item.id }"></span></c:if>
                <c:if test="${defaultAddress.id != item.id }"><span class="icon-addr addr-ccb" item_id="${item.id }"></span></c:if>
                    <div class="addr-info">
                        <h3>${item.address.detail }</h3>
                        <p>${item.name } <span class="short-num">${item.mobilePhone }</span></p>
                    </div> <a href="javascript:;" class="btn ctl-btn J_ctlBtn" data_id="${item.id }" ></a>
                </li>
                </c:forEach>
            </ul>
        </div>
        <p class="f12 tc red-col mt10 hide prompt">客官～地址只能保存5个呦！您可以选择修改已有地址～</p>
        <c:if test="${not empty list }">
        <p class="form-item btn-wrap mt10">
            <button type="submit" class="btn-large btn-primary">确定</button>
        </p>
        </c:if>
        <p class="form-item btn-wrap">
            <a href="javascript:;" class="btn-large addReceiverInfo">新增收货地址</a>
        </p>
    </div>
    <input type="hidden" id="select_id" name="select_id" value="${defaultAddress.id }" />
    <c:if test="${list != null }"><input type="hidden" id="receiver_count" value="${fn:length(list)}"></c:if>
    <c:if test="${list == null }"><input type="hidden" id="receiver_count" value="0}"></c:if>
    </form>
    <script src="${ctx }/static/js/lib/zepto.js"></script>
    <script>
    	var domain = "${domain}";
        (function(){
        	
            OC.setTitle("我的收货地址");
            <c:if test="${ empty list }">
            window.location.href = domain + "/receiver/to/addOrEdit";
			</c:if>
        	//点击文字
            var $addrList = $(".addr-list .addr-info");
            $addrList.on('click',function(e){
                e.preventDefault();
                $(".addr-list li").find(".icon-addr").removeClass("on");
                $(this).siblings(".icon-addr").addClass("on");
                var item_id = $(this).siblings(".icon-addr").attr("item_id");
                $("#select_id").val(item_id);
            });
            //点击小圆点
            var $addricon = $(".addr-list .icon-addr");
            $addricon.on('click',function(e){
                e.preventDefault();
                $(".addr-list li .icon-addr").removeClass("on");
                $(this).addClass("on");
                var item_id = $(this).attr("item_id");
                $("#select_id").val(item_id);
            });
            $(".J_ctlBtn").on('click', function(event){
            	var select_id = $(event.target).attr("data_id");
            	window.location.href = domain + "/receiver/to/addOrEdit?addr_id=" + select_id;
            });
            
            $(".addReceiverInfo").on('click',function(event) {
            	var receiverCount = $("#receiver_count").val();
            	receiverCount = parseInt(receiverCount);
            	if (receiverCount >= 5) {
            		$(".prompt").removeClass("hide");
            	} else {
            		window.location.href = domain + "/receiver/to/addOrEdit";
            	}
            });
            
            $(".J_navBack").on('click', function(event){
            	history.go(-1);
            });
        })()
    </script>
</body>
</html>
