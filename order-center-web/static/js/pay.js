var PAY;
(function(){
  var launchPayWindow = function (json, callback) {
  var jsonStr = OC.toJsonStr(json);
  var systemName = OC.getSystemName();
  try {
    if ("android" == systemName) {
    	android.pay(jsonStr , callback);
    } else if ("IOS" == systemName) {
      window.location.href='native://commonPay?params=' + jsonStr + '&callback=' + callback;
    }
  } catch (e) {
	  Tip.shoMsg('支付失败');
  }
  }
  
  PAY = {
    launchPayWindow:launchPayWindow
  };
})();
