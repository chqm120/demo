define(['swipe', 'zepto', 'common/topbar','widget/tip'],function(Swipe , $ , HeaderView ,Tip){

    var $pageWrap = $('<div class="slider-pages">'), //分页包装
        $slider = $('#J_slider'),
        activeCls = 'active',                         //当前分页的class
        $currentPage,                                 //存储当前分页
        pages,                                        //存储所有分页对象
        num;                                          //总页数

    //配置中的dom对象，zepto对象或者原声dom对象都可
    var arrowUpWrapper=$("span#arrow_nav");


    //初始化幻灯片
    slider = new Swipe($slider[0], {
        startSlide: 0,
        speed: 800,
        auto: 3000,
        continuous: true,
        disableScroll: false,
        stopPropagation: false,
        transitionEnd: switchPage
    });

    num = slider.getNumSlides();
    renderPages($pageWrap, num);

    /**
     * @method switchPage
     * 幻灯片分页切换
     */
    function switchPage(index, elem) {
        pages = pages || $pageWrap.children();
        $tempItem = pages.eq(index);
        if ( pages.length > 1 ) {
            $currentPage.removeClass(activeCls);
            $tempItem.addClass(activeCls);  
            $currentPage = $tempItem;
        }
    }

    /**
     * @method renderPages
     * 渲染幻灯片分页
     */
    function renderPages($pageWrap, pages, startIndex) {
        var startIndex = startIndex || 0,
            temp='', classAttr;

        for (var i=0; i< pages; i++){
            classAttr = ( i == startIndex ) ?
                'class="'+ activeCls +'"' : '';
            temp += '<span '+ classAttr +'>'+ i +'</span>';
        }

        $pageWrap.html(temp);
        $pageWrap.appendTo($slider);
        $currentPage = $pageWrap.children().eq(startIndex);
    }
    //修改input:hidden 的值
    function changeVal(obj,val){
        obj.val(val)
    }
    //获取版本信息
	function getSystemName() {
        var u = navigator.userAgent;
        if (u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) {
            return "android";
        } else if (u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1) {
            return "IOS";
        }
        return "android";
	}
	//监听回退按钮
    function listener(){
    	if($(".tag-warp").hasClass("on")){
        	return 1;
        }else{
        	return 0;
        } 
    }
    //菜单栏权限拦截
    $(function(){
        //返回至页面顶部
        var $indexNav = $('#J_indexNav'),
            $slider_item5 = $("#slider_item5"),
            $screen_warp = $(".screen-warp"),
            $screen_item = $screen_warp.find(".screen-item"),
            $second_list = $screen_warp.find(".screen-second-warp li"),
            $card_type_btn = $screen_warp.find(".card-type-btn"),
            $card_pricr = $screen_warp.find(".card-pricr"),
            $Tab_list = $("#card-Tab-list li");

        $indexNav.delegate('a', 'click', function(e){
            var $link = $(this);
            console.log($link.attr("href"))
            if ( !HeaderView.isLogin && $link.data('login') == 'need' ) {
                e.preventDefault();

                HeaderView.showLogin({
                    redirectUrl: $link.attr('href')
                });
            }
        });
        //点击单行 显示/隐藏 二级菜单
        $screen_item.on("click",function(){
            var $me = $(this),
                  card_trade = $me.attr("data-input"),
                  $thisLi = $me.next("ul").find("li"),
                  $thisVal = $("#"+card_trade).val();
            if($me.find("span").length > 0){                
                if($me.hasClass("on")){
                   $me.next(".screen-second-warp").hide();
                   $me.removeClass("on");
                   $me.find(".arrow").removeClass("on");
                }else{
                    // 此交互未完善
                    $(".screen-second-warp").hide();
                    $(".screen-item").removeClass("on");
                    $(".screen-item").find(".arrow").removeClass("on");

                    $me.next(".screen-second-warp").show();
                    $me.addClass("on");
                    $me.find(".arrow").addClass("on");

                    var sw_height = $me.parents(".screen-warp").height(),
                        si_length = ($(".screen-item").length+1) * 46;
                   $me.next(".screen-second-warp").css("max-height",sw_height-si_length);            
                }

            }
            
            if($me.find('.screen-tag').attr('id') == 'trade_type'){
                
            }else{
                /*$.get('/card_shop_web/merchants',function(result){
                    var html = '';
                    for(var i=0;i<result.length;i++){
                        html += '<li data-val='+result[i].id+'><i></i><span>'+result[i].name+'</span></li>'
                    }
                    $me.next().first().append(html);
                });*/
            }
        })
        //二级菜单
       $second_list.on("click",function(e) {
            var $me = $(this),
                thisVal = $(this).attr("data-val"),
                thisHtml = $(this).find("span").html(),
                thisInput = $(this).parent("ul").attr("data-input");
            $me.parent().find("li").removeClass("on");
            $me.addClass("on");
            $me.parents(".screen-second-warp").prev("div").find(".screen-store").html(thisHtml);
            changeVal($("#"+thisInput),thisVal);
       })
       //筛选类型按钮
       $card_type_btn.on("click",function(){
            var $me = $(this),
                $me_input=$me.parent().attr("data-input"),
                $me_val=$me.attr("data-val");
            $me.parent().find("a").removeClass("on");
            $me.addClass("on");
            $("#"+$me_input).val($me_val);
       })
       //价格筛选
       $card_pricr.on("input",function(){
            var $me = $(this),
                $thisInput = $me.attr("data-input"),
                $thisVal = parseFloat($me.val());
            $("#"+$thisInput).val($thisVal);
       })
       
        //菜单滑动效果
        $Tab_list.on("click",function(){
            var $me = $(this),
                  $meleft = Math.floor($me.offset().left - 10),
                   wHeight = window.innerHeight,
                   client = getSystemName();
            $Tab_list.removeClass("active-color");
            $me.addClass("active-color");
            if($me.attr('id') == 'slider_item5'){
                if($me.hasClass("on")){
                    $(".screen-warp").hide();
                    $(".card-Tab-warp").removeClass("on");
                    $(".screen-warp").removeAttr("style").removeClass("on");
                    $me.removeClass("on");
                    $me.find(".arrow").removeClass("on");

                 jdp.goBackListener(function(){
                    return 0;
                 })
                }else{
                        $(".screen-warp").height(wHeight-44).addClass("on").css("display","block");
                        $('body').css("overflow-y","hidden");
                        $('.main').hide();
                        $me.addClass("on");
                        $me.find(".arrow").addClass("on");

                        jdp.goBackListener(function(){
                            return 1;
                        })
                }
                $(".g-tip").css("display","none");
            }else{
                $(".screen-warp").hide();
                $('.main').show();
                $slider_item5.removeClass("on active-color");
                $slider_item5.find(".arrow").removeClass("on");
                $(".card-Tab-warp").removeClass("on");

                Tip.showLoading('加载中....');
                $('.index-card-list').empty();
                $('.index-card-list').load(window.ctx+'/cards?tag='+$me.attr('id')
                        ,function(response,status,xhr){
                            if(response.indexOf('<li') == -1){
                                var html = '<li><div style="text-align: center;margin-top: 20%">\
                                                <div>\
                                                    <img class="no-prod-pic" src="'+ctx+'/static/img/trouble.png"/>\
                                                    <p class="no-prod-tips">客官，没有找到合适的商品噢~</p>\
                                                </div>\
                                            </li></div>';
                                $('.index-card-list').html(html);
                            }
                            Tip.destory();
                         }
                );
            }

        });
        $(".J_btn_submit").click(function(){
            $(this).parents(".form-inline").submit();
        })
        window.addEventListener("scroll",function(){
            var warp = $(".screen-warp");
            if(warp.css("display")=='block'){
                if(document.body.scrollTop > 40){
                    $(".card-Tab-warp").addClass("on")
                }else{
                    $(".card-Tab-warp").removeClass("on")
                }
            }
        },false);
        
        $(".screen-warp .card-pricr").on("input",function(){
            var input1 = parseInt($(".screen-warp .card-pricr").eq(0).val());
            var input2 = parseInt($(".screen-warp .card-pricr").eq(1).val());
            if((input1 != '' && input2 != '') && input1>input2 ){
                Tip.showMsg('起始价格大于终止价格');
                $(".J_btn_submit").attr("disabled","disabled");
                setTimeout(function(){Tip.hide()},1000);
            }else{
                $(".J_btn_submit").removeAttr("disabled");
            }
        });
        //引导层
        var floatZoom = $.fn.cookie('float');
        if(floatZoom == undefined){
            var wHeight = window.innerHeight;
            $(".J_float").removeClass("hide").siblings(".my-btn").addClass("hide").hide();
            $(".my-btn").hide();
            $("html").css({"overflow-y":"hidden","height":wHeight,"padding":"0px"});
            $("body").css({"overflow-y":"hidden","height":wHeight,"padding":"0px"});
            $(".J_float").click(function(){
                $(this).hide();
                $("body").css({"overflow":"auto"});
                $("html").css({"overflow-y":"auto","height":"auto"});
                $(".my-btn").show().removeClass("hide");
                $.fn.cookie('float', "true", {path:'/',expires:1800});
            })
        }else{
            $(".J_float").addClass("hide");
            $(".my-btn").show();
        }
    });
});