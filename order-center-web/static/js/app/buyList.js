define(['zepto'],function($){
    //计数
    var numb = 1;
    function countNum(obj){
    	
    	var computeAmount = function(obj, numb) {
       	 	var targetId = $("#"+obj).attr("target_id");
            $("#sku_num").val(numb);
            var price = $("#price_" + targetId).text();
            var postage = $("#postage").val();
            
            var payAmount = (parseFloat(numb * price) + parseFloat(postage));
            //console.log(payAmount.toFixed(2));
            payAmount = payAmount.toFixed(2);
            console.log("numb:" + numb + " price:" + price + " postage:" + postage + " payAmount:" + payAmount);
            if (payAmount > parseFloat(10000)) {
            	return false;
            }
            $("#pay_amount").text(payAmount);
            $("#view_amount").text("<font style=\"font-family:Arial;\">¥</font> " + payAmount);
            $.fn.cookie('num', numb, {path:'/',expires:1800});
            return true;
       }
    	
    	
        var $quantity_wrapper = $(".quantity-wrapper"),
            $subWareBybutton = $quantity_wrapper.find("#subWareBybutton"),     //减号
            $addWareBybutton = $quantity_wrapper.find("#addWareBybutton"),     //加号
            $quantity = $quantity_wrapper.find(".quantity"),
            $limitSukNum = $quantity_wrapper.find("#limitSukNum"),
            $goods_num = $quantity_wrapper.next("span").find("#goods_num");
        if (obj == "addWareBybutton") {
            numb += 1;
            var res = computeAmount(obj, numb);
            if (res == true) {
            	$quantity.val(numb);
                $limitSukNum.val(numb);
                $goods_num.html($goods_num.html()-1);
            } else {
            	numb -= 1;
            }
            
        } else {
            if (numb<=1) {
                $quantity.val(1);
                $limitSukNum.val(1);
            } else {
                numb-=1;
                var res = computeAmount(obj, numb);
                if (res == true) {
                	$quantity.val(numb);
                    $limitSukNum.val(numb);
                    $goods_num.html( parseInt($goods_num.html())+1);
                } else {
                	numb += 1;
                }
            }
        }
    }
    function centerBox(){
        var winWidth = $(window).width(),
            winHeight = $(window).height(),
            popWin = $(".popWin"),
            pop_c = popWin.find(".popWin-content"),
            popWin_W = popWin.width(),
            popWin_H = popWin.height(),
            pop_c_W = pop_c.width(),
            pop_c_H = pop_c.height(),
            w = (popWin_W-pop_c_W)/2,
            h = (popWin_H-pop_c_H)/2;
            if(winWidth<=640){
                pop_c.css({
                    "margin":"0px 15px",
                    "margin-top":h+'px',
                });
            }else{
                pop_c.css({
                    "margin-left":w+'px',
                    "margin-top":h+'px',
                });
            }
            
    }
    //菜单栏权限拦截
    (function(){
        var $indexNav = $('#J_indexNav'),
            $quantity_wrapper = $(".quantity-wrapper"),
            $subWareBybutton = $quantity_wrapper.find("#subWareBybutton"),//减号
            $addWareBybutton = $quantity_wrapper.find("#addWareBybutton"),//加号
            $quantity = $quantity_wrapper.find(".quantity"),
            $submit_Order = $("#submit_Order"),
            $popWin = $(".popWin"),
            $back_btn = $popWin.find(".back-btn"),
            $submit_btn = $popWin.find(".submit-btn");
        $subWareBybutton.on("click",function(){
            countNum("subWareBybutton")
        })
        $addWareBybutton.on("click",function(){
            countNum("addWareBybutton")
        })
        $submit_Order.on("click",function(){
        	var sku_num = $("#sku_num").val();
        	$("#view_sku_num").text("x" + sku_num);
        	var sku_price = $("#sku_price").val();
        	var sku_amount = parseFloat(sku_num) * parseFloat(sku_price);
        	sku_amount = sku_amount.toFixed(2);
        	$("#view_sku_amount").text("－  <font style=\"font-family:Arial;\">¥</font> " + sku_amount);
            $(".popWin").show();
            centerBox();
        })
        $back_btn.on("click",function(){
            $(".popWin").hide();
        });
        $(".addReceiverInfo").on('click',function(){
        	window.location.href=domain+'/receiver/list';
        });
    })();

});
