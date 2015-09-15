define(['zepto'],function(){
    //菜单栏权限拦截
    (function(){
        var $invoice_list = $(".invoice-list"),
            $invoice_list_a = $invoice_list.find("a");
    		$invoice_list_a.on("click",function(e){
                if($(this).attr("cost")){
                    $(this).parents("dl").find(".cost").hide();
                    $(".invoice-list").find("a").removeClass("on");
                    $(this).addClass("on");
                    var invoiceId = $(this).attr("invoice_id");
                    $("#invoice_id").val(invoiceId);
                }else{
                    $(this).parents("dl").find(".cost").show();
        			$(".invoice-list").find("a").removeClass("on");
        			$(this).addClass("on");
        			var invoiceId = $(this).attr("invoice_id");
        			$("#invoice_id").val(invoiceId);
                }
    		})
    	    
    	    function check() {
    	    	var invoice_id = $("#invoice_id").val();
    	    	if (OS.isEmpty(invoice_id)) {
    	    		return false;
    	    	}
    	    	var title = $("#invoice_title").val();
    	    	if (OS.isEmpty(title)) {
    	    		return false;
    	    	} else if (OS.xssCheck(title)) {
    	    		return false;
    	    	}
    	    	return true;
    	    }
    	    var interval = setInterval(function(){
    			var result = check();
    			if (result == true) {
    				$("#btn-primary").removeAttr("disabled");
    				$("#btn-primary").attr("submit", "true");
    			}
    		}, 500);
    })();
});