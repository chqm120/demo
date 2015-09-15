/**
 * 倒计时组件
 *
 * @require zepto
 * @author fiture (wywumin@jd.com)
 * @date 2015-03-18
 *
 */

define(['zepto', 'common/utils'],function($, Utils){

    function Countdown(opts){
        var btn = opts.btn,
            time = opts.time || 59,
            timmer,
            data = opts.data,
            autoStart = opts.autoStart || false,
            disabledCLS = opts.disabledCLS || 'btn-disabled',
            oriTxt = btn.text(),
            resendTxt = opts.resendTxt || '重新获取',
            countdownTxt = opts.countdownTxt || ' 秒';

        this.setData = function (params) {
            data = params;
        };

        this.setOption = function(options){
            options = options || {};

            opts = $.extend(opts, options);

            console.log(opts);
        }

        this.setBtnTxt = function (txt) {
            btn.text(txt || resendTxt);
        };

        this.start = function(){
            this.reset();
            start();
        }

        if ( autoStart ) {
            start();
        }

        btn.click(function(e){
            e.preventDefault();
            if ( btn.data('disabled') ) return;
            start();
        });

        if (this instanceof arguments.callee) {
            this.reset = function(){
                reset();
                btn.text(oriTxt);
            };

            return this;
        }

        function start() {

            if (isFuc(opts.before) && opts.before.call(this) === false) {
                return;
            }

            btn.prop('disabled', true);
            btn.addClass(disabledCLS).data('disabled', true);

            fetch();
            countdown();
        }

        function fetch() {
            if ( !opts.url ) return;

            $.ajax({
                url: Utils.config.rootUrl + opts.url,
                type: 'POST',
                dataType: 'json',
                data: data,
                success: function(r){

                    if ( r.code == 'A00000') {
                        Tip.hide();
                        isFuc(opts.done) && opts.done.call(this, r);
                    } else {                        
                        Tip.showMsg(r.data.msg || '服务器繁忙，请重试');
                        isFuc(opts.fail) && opts.fail.call(this, r);
                    }

                },
                error: function(r){
                    isFuc(opts.fail) && opts.fail.call(this, r);
                }
            });
        }

        function isFuc(fn) {
            return fn && (typeof fn === 'function');
        }

        function countdown() {

            function count(){
                btn.text(time + countdownTxt);
                if ( time === 0 ) {
                    reset();
                    btn.text(resendTxt);
                    isFuc(opts.end) && opts.end.call(this);
                }
                time--;
            }

            count();

            timmer = setInterval(function(){
                count();
            }, 1000);

        }

        function reset() {
            clearInterval(timmer);
            time = opts.time || 59;
            btn.prop('disabled', false).data('disabled', false);
            btn.removeClass(disabledCLS);
        }
    }


    return Countdown;
});
