define(['widget/tip'], function (Tip) {

    var config = {
        rootUrl: '/card-shop', // + '/login/xx.htm';
        clickEvt: (('ontouchstart' in window) || 
            window.DocumentTouch && document instanceof DocumentTouch) ? 
            'touchstart' : 'click'
    };
    function remote(options){
        Tip.showLoading('<span class="g-loading"></span>', true);
        $.ajax({
            url: '../js/json.json',
            type: options.type,
            dataType: 'json',
            data: options.data,
            success: function(r){
                if ( r.code == 'A00000') {
                  Tip.hide();
                  options.done && options.done(r);
                } else {
                  Tip.showMsg(r.data.msg || '服务器繁忙，请重试');
                  options.fail && options.fail(r);
                }
            },
            error: function(r){
                options.fail && options.fail(r);
                Tip.showMsg('网络异常，请重试');
            }
        });
    }
    
    return {
        remote: remote,
        config: config
    }
});