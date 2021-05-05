<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style type="text/css">
        .talk_con{
            width:60%;
            height:800px;
            border:1px solid #666;
            margin:50px auto 0;
            background-image: linear-gradient(#000000,#666666);
            border-radius: 15px;
        }
        .talk_show{
            width:90%;
            height:80%;
            border:1px solid #666;
            /*background-image: url("img/img.png");*/
            /*background-color: #f9f9f9;*/
            background-image: linear-gradient(to right,#f9f9f9,#095f88);
            border-radius: 12px;
            margin:10px auto 0;
            margin-top: 3%;
            overflow:auto;
        }
        .talk_input{
            width:90%;
            margin:40px auto 0;
        }
        /*.whotalk{*/
        /*    width:30px;*/
        /*    height:30px;*/
        /*    float:left;*/
        /*    outline:none;*/
        /*}*/
        .talk_word{
            width:80%;
            height:36px;
            padding:0px;
            float:left;
            /*margin-left:10px;*/
            margin-bottom: 10px;
            outline:none;
            text-indent:10px
        }
        .talk_sub{
            width:56px;
            height:30px;
            float:right;
            margin-left:10px;
        }
        .atalk{
            margin:10px;
        }
        .atalk span{
            display:inline-block;
            background:#0181cc;
            border-radius:10px;
            color:#fff;
            padding:5px 10px;
        }
        .btalk{
            margin:10px;
            text-align:right;
        }
        .btalk span{
            display:inline-block;
            background:#ef8201;
            border-radius:10px;
            color:#fff;
            padding:5px 10px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/emojionearea/3.4.2/emojionearea.css">
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/emojionearea/3.4.2/emojionearea.min.js"></script>
    </script>
</head>

<body>
<div class="talk_con">
    <div class="talk_show" id="words">
        <div style="height: 100%; width: 20%;float: right;">
            <div id="online_members" style="height: 49%;border:1px solid #666666;">在线用户：
                <div id="members" style="height: auto;text-align: left"></div>
            </div>
            <div id="file_list" style="height:50%;border:1px solid #666666;">
                上传的文件：
                <div id="files" style="height: auto;text-align: left"></div>
            </div>
        </div>
    </div>
    <div class="talk_input">
<%--        <select class="whotalk" id="who">--%>
<%--        </select>--%>
        <input type="text" class="talk_word" id="talkwords">
     <input type="button" value="发送" class="talk_sub" id="talksub"onclick="send()">
    <div style="float: left;color: #f9f9f9">
        <form id="uploadf" action="http://localhost:8080/Socket_war/user/test" method="post" target="frame1" enctype="multipart/form-data">
            <%--                name:<input type="text" name="username">--%>
            <input type="file" name="file" id="upload_i" accept=".doc,.docx,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document"/>
            <input type="button" value="上传" onclick="sub()">
<%--                <input type="submit" value="上传">--%>
        </form>
        <iframe name="frame1"  frameborder="0" height="40"></iframe>
    </div>
         </div>
</div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $("#talkwords").emojioneArea();
    });

    //判断当前浏览器是否支持WebSocket
    urlinfo=window.location.href;
    arr= urlinfo.split("?");
    userID=arr[1]
    onlines=[]
    if('WebSocket' in window){
        websocket = new WebSocket("ws://localhost:8080/Socket_war/websocketTest/"+userID);
        console.log("link success")
    }else{
        alert('Not support websocket')
    }

    //连接发生错误的回调方法
    websocket.onerror = function(){
        setMessageInnerHTML("error");
    };

    //连接成功建立的回调方法
    websocket.onopen = function(event){
        setOnline(userID);
        setMessageInnerHTML("已连接");
    }
    console.log("-----")
    //接收到消息的回调方法
    websocket.onmessage = function(event){
        // var str=event.data
        var dataType=event.data.substring(0,1);
        var data=event.data.substring(1)
        if (dataType=="1") {
            setMessageInnerHTML(data);
        }
        //显示在线人数
        else if (dataType=="0"){
            if (!onlines.includes(data)){
                onlines.push(data);
                setOnline();
            }
        }
        else {
            setfilesname(data)
        }

    }

    //连接关闭的回调方法
    websocket.onclose = function(){
        setMessageInnerHTML("close");
    }

    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。

    //将消息显示在网页上
    function setMessageInnerHTML(innerHTML){
        document.getElementById('words').innerHTML += innerHTML + '<br/>';
    }

    //关闭连接
    function closeWebSocket(){
        websocket.close();
    }

    //发送消息
    function send(){
        var message =document.getElementById('talkwords').value;
        // document.getElementById('talkwords').value="";
        $(".emojionearea-editor").html('');
        //使用此方法才能清空输入框
        websocket.send("1"+message);
    }
    //上传文件(防止页面跳转使用ajax的方式提交表格数据）
    // function sub() {
    //     fl=document.getElementById("upload_i")
    //     console.log(fl.files)
    //      $.ajax({
    //             // cache: true,
    //             type: "POST",
    //             url: "http://localhost:8080/Socket_war/user/test",
    //             data: $('#uploadf').serialize(),// 你的formid
    //             async: false,
    //             error: function (request) {
    //                 // alert("Connection error:"+request.error);
    //                 alert("上传失败")
    //             },
    //             success: function (data) {
    //                 alert("上传成功!");
    //             }
    //         });
    //     if (fl.value!=undefined) {
    //         websocket.send("f" + fl.files[0].name)
    //     }
    // else {
    //     alert("未上传文件！")
    //     }
    // }
    function sub() {
        fl=document.getElementById("upload_i")
        console.log(fl.files)
        $("#uploadf").submit();
        var t = setInterval(function() {
            //获取iframe标签里body元素里的文字。即服务器响应过来的"上传成功"或"上传失败"
            var word = $("iframe[name='frame1']").contents().find("body").text();
            if (word != "") {
                alert(word);        //弹窗提示是否上传成功
                clearInterval(t);   //清除定时器
            }
        }, 1000);
        if (fl.value!=undefined) {
            websocket.send("f" + fl.files[0].name)
        }
    else {
        alert("未上传文件！")
        }
    }
    function setOnline(){
        document.getElementById('members').innerHTML=''
        for (i in onlines){
            document.getElementById('members').innerHTML += onlines[i]+'<br/>' ;
        }
    }
    function setfilesname(flies) {
        flies_array=flies.split(",")
        document.getElementById('files').innerHTML=''
        console.log(flies)
        console.log(flies_array)
        for (i in flies_array) {
            if (flies_array[i]=="null")
            {
                continue;
            }
            document.getElementById('files').innerHTML += flies_array[i] + '<br/>';
        }
    }

</script>
</body>
</html>