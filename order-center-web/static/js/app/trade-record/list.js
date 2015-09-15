define(['zepto', 'backbone', 'underscore', 'common/utils'], function($, Backbone, _, commonUtils) {

        var recordModel = Backbone.Model.extend({
            defaults: {
                store: '京东',
                t_status: '交易完成',
                desc: '京东E卡经典卡200面值（电子卡）',
                date: '2015-01-01',
                link: 'XXX',
                amount: '1',
                cost:'100.00',
                price: '100.00',
                b_status: '确认收货',
                orderid:'1230'
            }
        });

        var RecordCollection = Backbone.Collection.extend({
            model: recordModel,
            url: '/transaction/recordList.htm',
            initialize: function(models, options){
                this.type = options.type || 'all';
                this.hasNext = true;
                this.currentPage = options.currentPage;
            }
        });


        var RecordItemView = Backbone.View.extend({
            tagName: 'div',
            template: _.template($('#J_recordItemTmp').html()),
            initialize: function(){
                this.render();
                //console.log(this.model.toJSON(), this.template);
            },
            render: function(){
                var itemModel = this.model.toJSON();
                this.$el.html(this.template(itemModel));

                if ( itemModel.boundary ) {
                    this.$el.addClass('record-date');
                }
            }
        });


        var RecordListView = Backbone.View.extend({
            el: '#J_recordList',
            className: 'record-list',
            initialize: function(){                
                var me = this;

                this.checkCollection();

                this.on('itemLoaded', function () {
                    me.checkEmpty();
                    // console.log('1');
                });
            },

            hasNext: function () {
                return this.collection.hasNext;
            },

            renderNewItems: function(){
                var cols = this.collection;

                var addedModels = cols.slice(this.itemLen, cols.length);

                this.render(addedModels);

                this.itemLen = this.collection.length;
            },

            render: function(models){
                var tmp = [];

                if ( !models ) {
                    models = this.collection.slice(0, this.collection.length);
                }

                models.forEach(function(recordItem){
                    var recordItemView = new RecordItemView({model: recordItem});
                    tmp.push(recordItemView.el.outerHTML);
                });
                this.$el.find(".empty-record").hide()
                this.$el.append(tmp.join(''));
                this.trigger('addNewItems');
            },

            renderEmpty: function () {
                this.$el.html('<span class="empty-record">暂无记录</span>');

                this.trigger('renderEmpty');
            },

            swithCollection: function(collection){
                this.collection = collection;
                this.$el.empty();

                this.checkCollection();
            },

            checkCollection: function(){
                var col = this.collection,
                    me = this;

                this.collection.on('add', _.debounce(function(){
                    me.renderNewItems();
                }) );

                this.itemLen = me.collection.length;

                if ( col.length == 0 ) {
                    console.log('当前collection为空，从后台获取数据');
                    me.loadData();
                } else {
                    me.render();
                }
            },

            checkEmpty: function () {
                var len = this.collection.length,
                    hasNext = this.collection.hasNext;

                if ( !len && !hasNext) {
                    this.renderEmpty();
                }
            },

            loadData: function(){
                var me = this,
                    currentPage = me.collection.currentPage,
                    nextPage = currentPage ? (parseInt(currentPage, 10) + 1) : 1;

                if ( !me.collection.hasNext ) {
                    me.trigger('itemLoaded');
                    return;
                }

                commonUtils.remote({
                    url: me.collection.url,
                    data: {
                        type: me.collection.type,
                        pageNum: nextPage
                    },
                    done: function(r){
                        me.collection.add(r.records);
                        me.collection.currentPage = r.nowPageNum;
                        me.collection.hasNext = r.hasNext;
                        me.trigger('itemLoaded');
                    }
                });
            }
        });

        return {
            View: RecordListView,
            Collection: RecordCollection
        }
});


