requirejs.config({
    //基本路径
    baseUrl: '../js/lib',
    
    //路径快捷方式，基于基础路径
    paths: {
      'app': '../app',
      'pages': '../pages',
      'common': '../common',
      'text': 'require.text',
      'widget': '../widget',
    },

    //加载非AMD库标识
    //shim里面的key: 真实路径 基于baseUrl
    shim: {

        'zepto': {
            exports: '$'
        },
        
        'zepto.touch': ['zepto'],
        'sliderMe':['zepto','zepto.touch'],
        'iscroll-probe': {
            exports: 'IScroll'
        },
        'swipe': {
            deps: ['zepto.touch'],
            exports: 'Swipe' //这里需要对应真正的
        }
    }
});

require(['common/topbar']);
