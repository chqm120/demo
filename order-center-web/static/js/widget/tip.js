// var whichTransitionEvent = (function (){
//     var t;
//     var el = document.createElement('fakeelement');
//     var transitions = {
//       'transition'       :'transitionEnd',
//       'OTransition'      :'oTransitionEnd',
//       'MSTransition'     :'msTransitionEnd',
//       'MozTransition'    :'transitionend',
//       'WebkitTransition' :'webkitTransitionEnd'
//     }

//     for(t in transitions){
//         if( el.style[t] !== undefined ){
//             return transitions[t];
//         }
//     }
// } ());


define(['zepto'], function($){
    var tipInstance,
        transitionEndTimer,
        timmerDelayHide;

    function Tip(msg){
        var $tip = $('<div class="g-tip"/>'),
            $body = $('body');

        this.$el = $tip;
        this.$inner = $('<div class="g-tip-inner"/>');

        this.$inner.appendTo(this.$el);

        this.setMsg(msg);

        $tip.appendTo($body);
    }


    Tip.prototype = {
        constructor: Tip,

        show: function(autoHide){           
            var me = this;

            me.reset();

            me.$el.show();

            me.$inner.css({
                'transition': 'opacity .2s linear',
                'opacity': 1
            });


            if ( !autoHide ) return;

            timmerDelayHide = setTimeout(function(){

                var support = 'webkitTransitionEnd' in document.documentElement;

                me.$inner.css({
                    'opacity': 0
                });


                if ( support )
                    me.$inner.on('webkitTransitionEnd', function(){
                        me.hide();
                    });
                else {
                    transitionEndTimer = setTimeout(function(){
                        //alert('垃圾浏览器不支持 transtionEnd 事件');
                        me.hide();
                    }, 200);
                }


            }, 1000);

        },

        reset: function(){
            if (this.withMask) {
                this.withMask = false;
                this.$el.removeClass('g-tip-mask');
            }
            timmerDelayHide && clearTimeout(timmerDelayHide);
            transitionEndTimer && clearTimeout(transitionEndTimer);
            this.$inner.off('webkitTransitionEnd').css({
                'transition-duration': '0s'
            });
        },

        hide: function(){
            this.reset();
            this.$el.hide();
            this.destory();
        },

        destory: function(){
            this.$el.remove();
            tipInstance = null;
        },

        showLoading: function(msg, withMask){
            this.setMsg(msg || '<span class="g-loading"></span>');
            

            withMask && this.$el.addClass('g-tip-mask');
            this.show();
            
            this.withMask = true;
        },

        setMsg: function(msg){
            var me = this;
            this.$inner.html(msg);
            

            return this;
        }
    }

    return {
        showMsg: function(msg){
            tipInstance = tipInstance || new Tip();
            tipInstance.setMsg(msg).show('autoHide');
        },
        showLoading: function(msg, withMask){
            tipInstance = tipInstance || new Tip();

            tipInstance.showLoading(msg, withMask);
        },
        hide: function(){
            //tipInstance = tipInstance || new Tip();
            tipInstance && tipInstance.hide();
        },
        destory: function(){
            tipInstance.destory();
        }
    }
});