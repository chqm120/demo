//计数
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
        h = (popWin_H-pop_c_H)/2,
        cw = winWidth-30;
    pop_c.css({"width":cw+"px","margin-top":h+"px"});
}
function countNum(obj){
    var qv = $("#"+obj).siblings(".quantity").val(),
        numb = parseInt(qv == '' ? 0 : qv),
        stock_numb = parseFloat($("#stock_count").val()),
        stock_count,
        buyBtn = $(".buy-btns-fixed .nowbuy-btn");;
    if(numb==''){
        numb = 0;
        numb = parseInt(numb);
    }
    var $quantity_wrapper = $(".quantity-wrapper"),
        $subWareBybutton = $quantity_wrapper.find("#subWareBybutton"),     //减号
        $addWareBybutton = $quantity_wrapper.find("#addWareBybutton"),     //加号
        $quantity = $quantity_wrapper.find(".quantity"),
        $limitSukNum = $quantity_wrapper.find("#limitSukNum");
    if (obj == "addWareBybutton") {
        //点击 + 号时 执行下方操作
        numb += 1;
        stock_count = stock_numb + 1;
        $quantity.val(numb);
        $limitSukNum.val(numb);
        computeAmount(obj, numb);
    } else {
        //点击 - 号时 执行下方操作
        if (numb<=0) {
            $quantity.val(0);
            $limitSukNum.val(0);
        } else {
            numb-=1;
            stock_count = stock_numb + 1;
            $quantity.val(numb);
            $limitSukNum.val(numb);
            computeAmount(obj, numb);
        }
    }

    function computeAmount(obj, numb) {
        var targetId = $("#"+obj).attr("target-id");
        var price = parseFloat($("#price_" + targetId).text());
        var postage = $("#postage").val();
        var denomination = $("#denomination").val();
        var stock_numb = parseFloat($("#stock_count").val());
        var payAmount = (parseFloat(numb * price) + parseFloat(postage));
        var newDenomination = (denomination - price) * numb;
        var $submit_Order = $("#submit_Order");
        payAmount = payAmount.toFixed(2);
        newDenomination = newDenomination.toFixed(2);
        $("#sku_num").val(numb);
        if (payAmount > parseFloat(10000)) {
            Tip.showMsg('单笔总金额不能超过1万噢~');
            $submit_Order.attr("disabled","disabled");
            if(obj == 'addWareBybutton'){
                return false;
            }
        }else if(parseFloat($(".quantity").val())+1 > stock_count){
            if(obj == 'addWareBybutton'){
                Tip.showMsg("没有那么多库存啦~");
                $submit_Order && $submit_Order.attr("disabled","disabled");
                buyBtn && (buyBtn.attr("buy","false") && buyBtn.addClass("on"));
                return false;
            }
        }else{
            $submit_Order.removeAttr("disabled");
            buyBtn && (buyBtn.attr("buy","true") && buyBtn.removeClass("on"));
        }
        $("#pay_amount").text(payAmount);
        $("#view_amount").text("<font style=\"font-family:Arial;\">¥</font> " + payAmount);
        $("#confirm_deno").text("- <font style=\"font-family:Arial;\">¥</font> " + newDenomination);
        $("#view_deno").text("- <font style=\"font-family:Arial;\">¥</font> " + newDenomination);

        console.log("numb:" + numb + " price:" + price + " postage:" + postage + " payAmount:" + payAmount);
        $.fn.cookie('o_num', numb, {path:'/',expires:1800});
        return true;
    }
    
}

var $indexNav = $('#J_indexNav'),
    $quantity_wrapper = $(".quantity-wrapper"),
    $subWareBybutton = $quantity_wrapper.find("#subWareBybutton"),//减号
    $addWareBybutton = $quantity_wrapper.find("#addWareBybutton"),//加号
    $quantity = $quantity_wrapper.find(".quantity"),
    $submit_Order = $("#submit_Order"),
    $popWin = $(".popWin"),
    $back_btn = $popWin.find(".back-btn"),
    $submit_btn = $popWin.find(".submit-btn"),
    $stock_obj =  $("#stock_count"),
    $stock_count = parseFloat($stock_obj.val());
//发票
$("#invoice").on('click',function() {
    window.location.href=domain + "/invoice/tochoose?skuId=" + skuId;
});
//减号
$subWareBybutton.on("click",function(){
    countNum("subWareBybutton");
});
//加号
$addWareBybutton.on("click",function(){
        countNum("addWareBybutton");
});
//点击提交订单
$submit_Order.on("click",function(){

    //判断商品数量为数值
    var sku_num = parseFloat($quantity.val());
    if(sku_num <= 0) {
        Tip.showMsg("数量请输入大于零的整数噢~");
        $(this) && $(this).attr("disabled","disabled");
        return;
    }else if(sku_num >= 1000) {
        Tip.showMsg('购买数量过大~');
        $submit_Order && $submit_Order.attr("disabled","disabled");
        return;
    }
    $.fn.cookie('o_num', sku_num, {path:'/',expires:1800});
    //进行实名认证
  //  if(ClientInfo.isRealName == 1) {
        $("#view_sku_num").text("x" + sku_num);
        var sku_price = $("#sku_price").val();
        var sku_amount = parseFloat(sku_num) * parseFloat(sku_price);
        sku_amount = sku_amount.toFixed(2);
        $("#view_sku_amount").html("－  <font style=\"font-family:Arial;\">¥</font> " + sku_amount);
        var needAddr = $("#needAddr").val();
        if (needAddr == true || needAddr == 'true') {
            var hasAddr = $("#hasAddr").val();
            if (hasAddr == false || hasAddr == 'false') {
                Tip.showMsg('请填写收货地址');
                return;
            }
        }
//    } else {
        //用户未实名，调用实名认证接口
//        OC.verifyRealName();
//        return;
//    }
    $(".popWin").show();
    centerBox();
});
//弹窗返回
$back_btn.on("click",function(){
    $(".popWin").hide();
});
$(".addReceiverInfo").on('click',function(){
    window.location.href=domain+'/receiver/list';
});
//输入框 变更事件
$quantity.on("input",function(){
    var me = $(this),
        meVal = parseFloat(me.val()==''? 0 : me.val()),
        length = meVal.length,
        buyBtn = $(".buy-btns-fixed .nowbuy-btn");
    if(!meVal){
        Tip.showMsg('购买数量不能为空');
        $submit_Order && $submit_Order.attr("disabled","disabled");
        buyBtn && (buyBtn.attr("buy","false") && buyBtn.addClass("on"));
    }else if(meVal > $stock_count){
        Tip.showMsg("没有那么多库存啦~");
        $submit_Order &&  $submit_Order.attr("disabled","disabled");
        buyBtn && (buyBtn.attr("buy","false") && buyBtn.addClass("on"));
        return;
    }else if(meVal >= 1000 ){
        Tip.showMsg('购买数量过大~');
        $submit_Order && $submit_Order.attr("disabled","disabled");
        buyBtn && (buyBtn.attr("buy","false") && buyBtn.addClass("on"));
        return;
    }else{
        buyBtn && (buyBtn.attr("buy","true") && buyBtn.removeClass("on"));
        $submit_Order && $submit_Order.removeAttr("disabled");
        $("#limitSukNum").val(meVal);
        $("#sku_num").val(meVal);
        countPrice(meVal);
    }
})

function round2(number,fractionDigits){
    with(Math){
        return round(number*pow(10,fractionDigits))/pow(10,fractionDigits);
    }
}
//计算弹窗里的数值
function countPrice(numb){
    var targetId = $("#subWareBybutton").attr("target-id");
    var price = parseFloat($("#price_" + targetId).text());                  // 单价
    var postage = $("#postage").val();
    var count = (parseFloat(numb * price) + parseFloat(postage));                               // 总价
    var denomination = $("#denomination").val();                 // 单价
    var newDenomination = (denomination - price) * numb;          // 
    newDenomination = newDenomination.toFixed(2);                // 商品优惠总额
    if(count>10000){
        Tip.showMsg('单笔总金额不能超过1万噢~');
        $("#submit_Order").attr("disabled","disabled");
    }else{
        $("#view_amount").text(round2(count,2));                               // 确认弹窗-商品共计
        $("#pay_amount").text(round2(count,2));                                // 实付款
        $("#view_deno").html("- <font style=\"font-family:Arial;\">¥</font> " + newDenomination);              // 商品优惠总额
        $("#confirm_deno").html("- <font style=\"font-family:Arial;\">¥</font> " + newDenomination);           // 确认弹窗-商品优惠总额
        $("#submit_Order").removeAttr("disabled");
    }
}
