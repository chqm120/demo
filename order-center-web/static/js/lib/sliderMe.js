/**
 * Created by zhouyunkui on 2015/4/13.
 */
 define(function(require) {
 	require("zepto");
 	require("zepto.touch");
	 	return (function($){
	    var sliderMe={
	        init: function (opt) {
	            /*
	             * slider�¼�
	             */
	            opt.sliderObj=typeof opt.sliderObj=="string"?$(opt.sliderObj):opt.sliderObj;
	            opt.downUpArrowObj=typeof opt.downUpArrowObj=="string"?$(opt.downUpArrowObj):opt.downUpArrowObj;
	            opt.progressBarObj=typeof opt.progressBarObj=="string"?$(opt.progressBarObj):opt.progressBarObj;
	            var liXY={};
	            var liCount=opt.sliderObj.find("li").size();
	            var liWidth=opt.sliderObj.find("li").width();
	            liXY.liCount=liCount;
	            liXY.liWidth=liWidth;
	            opt=$.extend(opt,liXY);
	            /*
	             * ��Ƭ��
	             */
	            var sliderBox=$("#slider");
	//��굱ǰ����
	            var currentX;
	//slider����С���
	            var smallestWidth=opt.liCount*opt.liWidth;
	//sliderλ��
	            var miniX=0;
	//progressbarλ��
	            var px=0;
	//ʵ����Ļ���
	            var realClientWidth=document.body.offsetWidth;
	            /*
	             * ��Ƭ��������ͷ
	             */
	//var arrowUpWrapper=$("span#arrow_nav");
	            var arrowWidth=opt.downUpArrowObj.width();
	//��Ļ���(��ʵ��)
	            var clientWidth;
	            //slider�����߽�
	            var rightLimit;
	            if(realClientWidth>=smallestWidth+arrowWidth){
	                clientWidth=realClientWidth;
	            }else{
	                clientWidth=realClientWidth-arrowWidth;
	            }
	            rightLimit=opt.sliderObj.width()-clientWidth;
	            window.onresize=function (e) {
	                realClientWidth=document.body.offsetWidth;
	                if(realClientWidth>=smallestWidth+arrowWidth){
	                    clientWidth=realClientWidth;
	                }else{
	                    clientWidth=realClientWidth-arrowWidth;
	                }
	                rightLimit=opt.sliderObj.width()-clientWidth;
	            };
	//����touches
	            var touches;
	//��ʱ����
	            function updateTimer(){
	                var offsetX=touches.clientX;
	                var diffrenceX=offsetX-currentX;
	                currentX=offsetX;
	                miniX=miniX+diffrenceX;
	                if(miniX<-rightLimit){
	                    miniX=-rightLimit;
	                }else if(miniX>0){
	                    miniX=0;
	                }else{
	                    px=px+diffrenceX;
	                }
	                var cssAttr={
	                    "-webkit-transform": "translate3d("+miniX+"px,0px,0px)",
	                    "transform": "translate3d("+miniX+"px,0px,0px)"
	                };
	                var attribute={
	                    "-webkit-transform": "translate3d("+px+"px,0px,0px)",
	                    "transform": "translate3d("+px+"px,0px,0px)"
	                };
	                opt.progressBarObj.css(attribute);
	                opt.sliderObj.css(cssAttr);
	            }
	            opt.sliderObj.on({
	                "touchstart":function(e){
	                    currentX= e.touches[0].clientX;
	                    $(document.body).on({
	                        "touchmove":function(e){
	                            e.preventDefault();
	                            touches= e.touches[0];
	                            setTimeout(updateTimer,32);
	                        },
	                        "touchend": function (e) {
	                            if(miniX<-rightLimit){
	                                miniX=-rightLimit;

	                            }else if(miniX>0){
	                                miniX=0;
	                            }
	                            var currentActiveItem=opt.sliderObj.find("li.active-color");
	                            var index=currentActiveItem.prop("id").replace(/slider_item/,"");
	                            px=miniX+(index-1)*opt.liWidth;
	                            var cssAttr={
	                                "-webkit-transform": "translate3d("+miniX+"px,0px,0px)",
	                                "-moz-transform": "translate3d("+miniX+"px,0px,0px)",
	                                "-ms-transform": "translate3d("+miniX+"px,0px,0px)",
	                                "-o-transform": "translate3d("+miniX+"px,0px,0px)",
	                                "transform": "translate3d("+miniX+"px,0px,0px)"
	                            };
	                            var attribute={
	                                "-webkit-transform": "translate3d("+px+"px,0px,0px)",
	                                "-moz-transform": "translate3d("+px+"px,0px,0px)",
	                                "-ms-transform": "translate3d("+px+"px,0px,0px)",
	                                "-o-transform": "translate3d("+px+"px,0px,0px)",
	                                "transform": "translate3d("+px+"px,0px,0px)"
	                            };
	                            opt.progressBarObj.css(attribute);
	                            opt.sliderObj.css(cssAttr);
	                            $(this).off();
	                        }
	                    })
	                }
	            });

	            /*
	             *  �����Ƭ�Աߵļ�ͷ��չʾ�����Ź���
	             */
	            opt.downUpArrowObj.on("tap",function(e){
	                sliderBox.find("ul.ul-list-view").toggleClass("nine-box-show");
	                if($(this).hasClass("mui-icon-arrowup")){
	                    $(this).removeClass("mui-icon-arrowup").addClass("mui-icon-arrowdown");
	                }else{
	                    $(this).addClass("mui-icon-arrowup").removeClass("mui-icon-arrowdown");
	                }
	            });
	            /*
	             * ����progressbar����Ч��
	             */
	            function alternateBoxProgressBar(item){
	                item=typeof item=="string"?"#"+item:item;
	                opt.sliderObj.find("li").removeClass("active-color");
	                $(item).addClass("active-color");
	                var index=$(item).prop("id").replace(/slider_item/,"");
	                px=miniX+(index-1)*opt.liWidth;
	                var attribute={
	                    "-webkit-transform": "translate3d("+px+"px,0px,0px)",
	                    "-moz-transform": "translate3d("+px+"px,0px,0px)",
	                    "-ms-transform": "translate3d("+px+"px,0px,0px)",
	                    "-o-transform": "translate3d("+px+"px,0px,0px)",
	                    "transform": "translate3d("+px+"px,0px,0px)"
	                };
	                opt.progressBarObj.css(attribute);
	            }
	            /*
	             * ���slider�еĵ�����progressbar������Ӧ�������棬���Ҽ�������
	             */
	            opt.sliderObj.find("li").on("tap",function(e){
	                alternateBoxProgressBar(this);
	            });
	            /*
	             * ����Ź�����slider����
	             */
	            sliderBox.on("tap","ul.ul-list-view li",function(e){
	                var suffix= $(this).prop("id").replace(/nb_/,"");
	                var itemId=$("#slider_content li").eq(0).prop("id").replace(/[0-9]/,suffix);
	                var diffX=suffix*opt.liWidth+miniX;
	                if(diffX<=0){
	                    miniX=miniX+(-diffX+opt.liWidth);
	                }else if(diffX>0&&diffX<=opt.liWidth){
	                    miniX=miniX+(opt.liWidth-diffX);
	                }else if(diffX>opt.liWidth&&diffX<=clientWidth){
	                }else if(diffX>clientWidth){
	                    miniX=miniX-(diffX-clientWidth);
	                }
	                alternateBoxProgressBar(itemId);
	                var cssAttr={
	                    "-webkit-transform": "translate3d("+miniX+"px,0px,0px)",
	                    "-moz-transform": "translate3d("+miniX+"px,0px,0px)",
	                    "-ms-transform": "translate3d("+miniX+"px,0px,0px)",
	                    "-o-transform": "translate3d("+miniX+"px,0px,0px)",
	                    "transform": "translate3d("+miniX+"px,0px,0px)"
	                };
	                opt.sliderObj.css(cssAttr);
	                sliderBox.find("ul.ul-list-view").toggleClass("nine-box-show");
	            });
	        }
	    };
	    	return sliderMe;
		})(Zepto)
})
