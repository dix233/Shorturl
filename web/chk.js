function check(){
    if(document.form1.url.value ==""){
        window.alert("原域名不能为空！");
        document.form1.url.focus();
        return false;
    }
    return true;
}