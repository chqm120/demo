define(function(){
    function checkPwd(){
        var check = {
            init: function(pwd){
                this.pwd = pwd;
            },

            //正则
            regs: {
                LOWER: /[a-z]/,
                UPPER: /[A-Z]/,
                DIGIT: /[0-9]/,
                SPECIAL: /[^a-zA-Z0-9]/
            },

            //检测密码长度
            validLen: function(pwd){
                var pwd = pwd || this.pwd,
                    len,
                    level;

                if ( !pwd ) return false;

                if ( pwd.indexOf(' ') > -1 ) {
                    return false;
                }

                len = pwd.length;

                if ( len >= 6 && len <=20 ) {
                    level = ( len >= 10 ) ? 2 : 1;
                } else {
                    return false;
                }

                return level;
            },

            //检测密码字符数
            validLevel: function(pwd){
                var temp = [],
                    regs = this.regs,
                    pwd = pwd || this.pwd;

                if ( !pwd ) return false;
                if ( pwd.indexOf(' ') > -1 ) return false;

                for ( key in regs ) {
                    if ( regs[key].test(pwd) ) {
                        temp.push('key');
                    }
                }

                return temp.length;
            }
        };

        return check;
    }

    var validator = {
        checkPwd: checkPwd,
        checkSmsCode: function(smsCode){
            return /^\d{6}$/.test(smsCode);
        }
    };

    return validator;
});
