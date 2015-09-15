define(['backbone', 'common/utils'], function(Backbone, Utils){ 

    var GloabModal = Backbone.View.extend({
        template: getModalTemplate(),
        tagName: 'div',
        className: 'g-modal-mask',
        events: function(){
            var evtObj = {};
            evtObj[Utils.config.clickEvt + ' .close-btn'] = 'close';
            return evtObj;
        }(),
        initialize: function(option){
            this.title = option.title || 'Title';
            this.content = option.content || 'Content';

            this._render();
            this.ready(option);
        },

        setContent: function(content){
            this.$content && this.$content.html(content || this.content);
        },

        setTitle: function(title){
            this.$title && this.$title.html(title || this.title);
        },

        close: function(){
            var me = this;

            this.hide(function(){
                me.remove();
            });
        },

        show: function(){
            this.$el.show();
            this.$el.addClass('ani-modal-in');
        },

        hide: function(callback){
            //this.$el.hide();
            var $el = this.$el;

            if ( $el.css('display') == 'none' ) {
                inTheEnd();
            } else {
                this.$el.on('webkitAnimationEnd', function(e){
                    if ( !$(e.target).hasClass('ani-modal-out') ) {
                        inTheEnd();
                    }
                });

                this.$el.removeClass('ani-modal-in')
                    .addClass('ani-modal-out');
            }

            function inTheEnd(){
                $el.removeClass('ani-modal-out');
                $el.off('webkitAnimationEnd');
                $el.hide();
                callback && callback.call(this);
            }
        },

        _render: function(){
            var $modal = $(this.template);
            this.$title = $modal.find('.g-modal-title');
            this.$content = $modal.find('.g-modal-content');


            this.setTitle(this.title);
            this.setContent(this.content);

            this.$el.html($modal);
            this.$el.appendTo('body');
            this.show();

            this.$modal = $modal;
        }
    });

    function getModalTemplate(){
        var modalTemp = 
            '<div class="g-alert g-modal login-modal">'+
                '<div class="g-alert-nav">'+
                    '<span class="close-btn">X</span>'+
                    '<div class="g-modal-title login-modal-title"></div>'+
                '</div>' +
                '<div class="g-modal-content"></div>'+
            '</div>';

        return modalTemp;
    }

    return GloabModal;
});