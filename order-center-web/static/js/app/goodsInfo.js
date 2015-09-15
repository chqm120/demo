define(['swipe', 'common/topbar'],function(Swipe){

    var $pageWrap = $('<div class="slider-pages"/>'), //分页包装
        $slider = $('#J_slider'),
        activeCls = 'active',                         //当前分页的class
        $currentPage,                                 //存储当前分页
        pages,                                        //存储所有分页对象
        slider,                                       //幻灯片对象
        num;                                          //总页数


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
    //计数
    var numb = 1;
    function countNum(obj){
        var $quantity_wrapper = $(".quantity-wrapper"),
            $subWareBybutton = $quantity_wrapper.find("#subWareBybutton"),     //减号
            $addWareBybutton = $quantity_wrapper.find("#addWareBybutton"),     //加号
            $quantity = $quantity_wrapper.find(".quantity"),
            $limitSukNum = $quantity_wrapper.find("#limitSukNum"),
            $goods_num = $quantity_wrapper.next("span").find("#goods_num");
        if(obj == "addWareBybutton"){
            numb += 1;
            $quantity.val(numb);
            $limitSukNum.val(numb);
            $goods_num.html($goods_num.html()-1);
        }else{
            if(numb==1){
                $quantity.val(numb);
                $limitSukNum.val(numb);
            }else{
                numb-=1;
                $quantity.val(numb);
                $limitSukNum.val(numb);
                $goods_num.html( parseInt($goods_num.html())+1);
            }
        }
    }
    //菜单栏权限拦截
    (function(){
        var $indexNav = $('#J_indexNav'),
            $quantity_wrapper = $(".quantity-wrapper"),
            $subWareBybutton = $quantity_wrapper.find("#subWareBybutton"),     //减号
            $addWareBybutton = $quantity_wrapper.find("#addWareBybutton"),     //加号
            $quantity = $quantity_wrapper.find(".quantity");

        $indexNav.delegate('a', 'click', function(e){
            var $link = $(this);

            if ( !HeaderView.isLogin && $link.data('login') == 'need' ) {
                e.preventDefault();

                HeaderView.showLogin({
                    redirectUrl: $link.attr('href')
                });
            }
        });
        $subWareBybutton.on("click",function(){
            countNum("subWareBybutton")
        })
        $addWareBybutton.on("click",function(){
            countNum("addWareBybutton")
        })

    })();

});