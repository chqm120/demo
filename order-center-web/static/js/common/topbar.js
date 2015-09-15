define(['zepto', 'backbone'],function($, Backbone){


    var HeaderView = Backbone.View.extend({
        el: $('#J_header'),
        events: {
            'click .J_navBack': '_goBackHandler',
            'click .J_togSubNav': '_subNav',
            'click .J_subNavList a': '_subNav',
        },
        initialize: function(){
            this._setTitle();
        },

        //后退按钮
        _goBackHandler: function(e){
            e.preventDefault();
            var url = $(e.currentTarget).find('a').attr('href');

            if ( !checkUrl(url) ) {
                window.history.back();
            } else {
                window.location.href = url;
            }

            function checkUrl(url){     
                return !(url.indexOf('#') == 0 || url.indexOf('javascript') == 0);
            }
        },

        _subNav: function(e){
            var me = this,
                $curSub = $(e.currentTarget);


            this.$togSubNav = this.$el.find('.J_togSubNav');
            this.$subNav = this.$el.find('.J_subNav');
            this.$curSub = this.$curSub || this.$subNav.find('.active');


            if ( $curSub.is('a') ) {
                this.$curSub.removeClass('active');
                $curSub.addClass('active');
                this.$curSub = $curSub;
            }

            if ( this.$subNav.length ) {
                this.$subNav.toggle();
                setTimeout(function(){
                    me.$el.toggleClass('with-mask');
                });
            }

        },

        _setTitle : function() {
            var u = navigator.userAgent, 
                app = navigator.appVersion,
                isAndroid = u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
                isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),//ios终端
                title = document.title; 
            if(isAndroid){
                android.setTitleName(title);
            }else{
                window.location.href = "native:// setTitleName?titleName="+title;
            }
        }
    });
    //返回头部
    function gotop() {
        var topbtn = $(".gotop-btn");
        topbtn.on("click",function(){document.body.scrollTop = 0;},false);
        window.addEventListener("scroll",function(){
            if(document.body.scrollTop > 40){
                topbtn.addClass("gotop-show");
            }else{
                topbtn.removeClass("gotop-show");
            }
        },false);
    }
    (function(){
        var $my_btn = $(".my-btn"),
            $gotop = $(".gotop-btn");
        //我的按钮
        $my_btn.on("click",function(){
            var me = $(this);
            if(me.find(".my-btn-warp").hasClass("on")){
                me.removeClass("on");
                me.find("a").removeClass("on");
                me.find(".my-btn-warp").removeClass("on");
            }else{
                me.addClass("on");
                me.find("a").addClass("on");
                me.find(".my-btn-warp").addClass("on");
            }
        })
        if($(".gotop-btn").length>0){
            gotop()
        }
    })()

    return new HeaderView();

});