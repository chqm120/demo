define([
    'iscroll-probe',
    'zepto',
    'backbone',
    'common/utils',
    'app/trade-record/list',
    'widget/alert-modal',
    'widget/tip'
    ], function(IScroll, $, Backbone, Utils, List , AlertModal,Tip) {

        var RecordRouter = Backbone.Router.extend({
            routes: {
                '': 'recordList',
                'record/:category/': 'recordList',
                'record-detail/:id/': 'recordDetail'
            }
        });

        var RecordCollections = {}; 

        RecordMain = Backbone.View.extend({
            el: $('#J_RecordScroller'),
            events: {
                'click .my-order-btn': 'alertWin',
                // 'click .order-cancelorder-btn': 'Unorder',
            },

            initialize: function(){
                this.router = new RecordRouter();
                this.listen();                
                this.initIscorll();

                this.$pullUpTip = this.$el.find('.J_pullUp');
            },
            alertWin: function(e){
                // 点击按钮事件···
                var me = this,
                    $curBtn = $(e.currentTarget),
                    type = $curBtn.data('type'),
                    tmpTxt = '确认订单',
                    orderid = $curBtn.parents("dl").attr('data-orderid');//获取当前点击对象的订单ID 

                e.preventDefault();

                this.alertModal = new AlertModal({
                    title: '确认订单'
                    // content: tmpTxt
                });

                this.alertModal.show();

                if ( !this.alertModal.eventsBinded ) {
                    this.alertModal.on({
                        'cancel': function(ctx){
                            ctx.close();
                        },
                        'confirm': function(ctx){
                            //在这里做出订单处理
                            // me.Handleorder(orderid);
                            console.log(orderid);
                            
                            // 隐藏弹出框并且重新加载 页面
                            me.alertModal.hide();
                            window.location.reload();

                        }
                    });

                    this.alertModal.eventsBinded = true;
                }
            },
            // Handleorder: function(orderid){
            //     var me = this;
            //     Tip.showLoading('', 'withMask');
            //     Utils.remote({                
            //         url: '',
            //         type: 'POST',
            //         dataType: 'json',
            //         data: {
            //             orderId: orderid
            //         },
            //         done: function(){
            //             Tip.showMsg('取消成功');
            //             me.alertModal.hide();
            //             window.location.reload();
            //         },
            //         fail: function(r){
            //             if ( r.data ) {
            //                 if ( r.data.isTag ) {
            //                     // me.showflagOrderTip();
            //                 } else if ( r.data.isCoffer ) {
            //                     // me.showflagOrderTip();
            //                 }
            //             }
            //         }
            //     });
            // },

            // showflagOrderTip: function () {
            //     var me = this;

            //     Tip.hide();

            //     me.destoryAlertModal();

            //     me.flagCardModal = new AlertModal({
            //         title: '',
            //         content: '<span style="line-height:1.2;">关闭前，请先确保没有提现中的订单，且此卡转入到钱包余额和小金库的资金已全部提现，否则无法关闭。</span>',
            //         btnCancel: '详细说明',
            //         btnConfirm: '关闭'
            //     });

            //     me.flagCardModal.on({
            //         'cancel': function (ctx) {
            //             this.close();
            //             me.showFlagCardIntro();
            //         },
            //         'confirm': function () {
            //             this.close();
            //         }
            //     });
            // },

            listen: function(){
                var me = this;

                this.router.on({
                    'route:recordList': function(category){
                        category = category || 'all';
                        me.renderListViewByCategory(category);
                    },
                    'route:recordDetail': function(id){
                        console.log(id);
                    }
                });
            },

            renderListViewByCategory: function(category){
                var me = this,
                    curCol;

                if ( !RecordCollections[category] ) {
                    RecordCollections[category] = new List.Collection([], {
                        type: category
                    });
                }

                curCol = RecordCollections[category];

                console.log(curCol.type);

                this.$pullUpTip.addClass('vh');

                if ( !me.listView ) {
                    me.listView = new List.View({
                        collection: curCol,
                        indexView: me
                    });

                    me.listView.on({
                        'addNewItems renderEmpty': function(){
                            me.scroller.refresh();
                            console.log('列表更新了');
                        },
                        'itemLoaded': function(){
                            me.scrollLoadCallback( checkCol() );
                        }
                    });
                } else {
                    me.listView.swithCollection( curCol );
                    me.scrollLoadCallback( checkCol() );
                }

                function checkCol (col) {
                    col = col || curCol;
                    return !(col.length && me.listView.hasNext());
                }
            },

            _loadMore: function(){
                this.loadMore();
            },

            loadMore: function(callback){
                this.listView.loadData(callback);
            },


            initIscorll: function(){
                this.scroller = new IScroll('#J_RecordScroller', {
                    probeType: 1,
                    mouseWheel:true,
                    click: true,
                    useTransition: true
                });

                this.listenScroller();

                document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);

            },

            checkScrollAble: function () {
                return this.scroller.onLoading || !this.listView.hasNext();
            },

            listenScroller: function () {                
                var me = this;

                me.scroller.onLoading = false;
                me.scroller.onReadyToFlip = false;

                me.scroller.on(
                    'scroll', function(){
                        if ( me.checkScrollAble() ) return;

                        // 当向下拉的距离 大于 最大可拉动距离 并且当前不处于 
                        // 可释放状态(me.scroller.onReadyToFlip)
                        if ( this.y <= this.maxScrollY &&
                            !me.scroller.onReadyToFlip ){

                            me.scroller.onReadyToFlip = true;
                            me.$pullUpTip.text('松开加载更多');

                        // 当向下拉的距离 小于 最大可拉动距离 并且当前处于
                        // 可释放状态(me.scroller.onReadyToFlip)
                        } else if (this.y > this.maxScrollY &&
                            me.scroller.onReadyToFlip){                                        

                            me.scroller.onReadyToFlip = false;
                            me.$pullUpTip.text('上拉加载更多');
                        }
                    });

                me.scroller.on(
                    'scrollEnd', function(){
                        if ( me.checkScrollAble() ) return;

                        if ( this.y <= this.maxScrollY && 
                            me.scroller.onReadyToFlip){

                            me.$pullUpTip.text('加载中...');

                            me.scroller.onLoading = true;
                            me.scroller.onReadyToFlip = false;

                            me.loadMore(); //上拉加载数据
                        }
                    });

            },

            scrollLoadCallback: function( hidePullTip ) {
                var me = this;

                me.$pullUpTip.toggleClass('vh', hidePullTip);
                me.scroller.onLoading = false;
                me.$pullUpTip.text('上拉加载更多').removeClass('loading');
            }
        });

        function RecordMain(){}

        var main = new RecordMain();
        !Backbone.History.started && Backbone.history.start();

        return main;
});
