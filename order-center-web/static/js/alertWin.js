var G = {};
(function () {
    var getTemplate = function (o){
        var option = o ||{};
        var template = '<div class="g-modal-mask ani-modal-in"><div class="g-alert"><h3 class="g-alert-title">'+ option.title +'</h3><div class="g-alert-content">' + option.content +'</div><footer class="g-alert-footer"><a href="#" class="btn btn-cancel J_btn" data-type="cancel">'+option.btnCancel+'</a><a href="#" class="btn J_btn" data-type="confirm">'+option.btnConfirm+'</a></footer></div></div>';
        var alertObj = $(template);

        alertObj.on('click','.J_btn',function(e){
            var type = $(this).data("type");
            
            if(type=="cancel"){
                hide($(this));
                o.callbackCancel && o.callbackCancel.call(this);
            }else{
                hide($(this));
                o.callbackConfirm && o.callbackConfirm.call(this);
            }
        });

        $('body').append(alertObj);

        function hide(o){
            var $el = o.parents(".g-modal-mask");

            if ( $el.css('display') == 'none' ) {
                inTheEnd();
            } else {
                $el.on('webkitAnimationEnd', function(e){
                    if ( !$(e.target).hasClass('ani-modal-out') ) {
                        inTheEnd();
                    }
                });
                $el.removeClass('ani-modal-in')
                    .addClass('ani-modal-out');
            }
            function inTheEnd(){
                $el.removeClass('ani-modal-out');
                $el.off('webkitAnimationEnd');
                $el.hide();
                $el.remove();
            }
        }
    };
    G.getTemplate = getTemplate;
})();

/*
(function(){
    //页面上只需要像下面这样写
    var alertObj = document.getElementById('alertWin');
    alertObj.addEventListener("click",function(){
        var option = {  
                    title: '哈哈哈',
                    content: '',
                    btnCancel: '取消',
                    btnConfirm: '确认',
                    callbackCancel: function(){
                        //这里是 点击取消后的业务逻辑
                        
                    },
                    callbackConfirm: function(){
                        //这里是 点击确认后的业务逻辑

                    }
        };
        G.getTemplate(option);
    });
})();
*/