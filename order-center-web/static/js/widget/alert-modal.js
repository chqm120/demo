define(['backbone', 'widget/modal'], function(Backbone, Modal){

    var AlertModal = Backbone.View.extend({
        tagName: 'div',
        className: 'g-modal-mask',
        template: getTemplate(),
        'events': {
            'click .J_cancel': 'cancel',
            'click .J_confirm': 'confirm'          
        },
        initialize: function(options){
            options = options || {};

            this.options= _.extend({
                title: '',
                content: '',
                btnCancel: '取消',
                btnConfirm: '确认'
            }, options);

            this.render();
        },
        cancel: function(e){
            e.preventDefault();
            this.trigger('cancel', this);
        },
        confirm: function(e){
            e.preventDefault();
            this.trigger('confirm', this);
        },

        hide: function(callback){
            Modal.prototype.hide.call(this, callback);
        },

        show: function(){
            Modal.prototype.show.call(this);
        },

        close: function(){
            Modal.prototype.close.call(this);
        },

        resetContent: function(options){
        	var compiled = _.template(this.template)(options);
        	this.$el.html(compiled);
        },

        render: function(){

            var options = this.options;

            var compiled = _.template(this.template)({
                title: options.title,
                content: options.content,
                btnConfirm: options.btnConfirm,
                btnCancel: options.btnCancel
            });

            this.$el.html(compiled);

            this.$el.appendTo( $(document.body) );
        }
    });

    function getTemplate(){
        return '<div class="g-alert">' +
            '<h3 class="g-alert-title"><%= title %></h3>' +

            '<div class="g-alert-content">' +
                '<%= content %>' +
            '</div>' +

            '<footer class="g-alert-footer">' +
                '<% if ( btnCancel ) { %>' +
                    '<a href="#" class="btn btn-cancel J_cancel"><%= btnCancel %></a>' +
                '<% } %>'+

                '<% if ( btnConfirm ) { %>'+
                    '<a href="#" class="btn J_confirm"><%= btnConfirm %></a>'+
                '<% }%>'+
            '</footer>'+
        '</div>'
    }

    return AlertModal;
});

