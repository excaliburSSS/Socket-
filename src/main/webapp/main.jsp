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
            width:80%;
            height:600px;
            border:1px solid #666;
            margin:50px auto 0;
            background-image: linear-gradient(#000000,#666666);
        }
        .talk_show{
            width:90%;
            height:80%;
            border:1px solid #666;
            /*background-image: url("../resources/b.jpg");*/
            background: #f9f9f9;
            margin:10px auto 0;
            overflow:auto;
        }
        .talk_input{
            width:90%;
            margin:40px auto 0;
        }
        .whotalk{
            width:80px;
            height:30px;
            float:left;
            outline:none;
        }
        .talk_word{
            width:80%;
            height:26px;
            padding:0px;
            float:left;
            margin-left:10px;
            outline:none;
            text-indent:10px;
        }
        .talk_sub{
            width:56px;
            height:30px;
            float:left;
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
</head>

<body>
<div class="talk_con">
    <div class="talk_show" id="words">
    </div>
    <div class="talk_input">
        <select class="whotalk" id="who">
        </select>
        <input type="text" class="talk_word" id="talkwords">
        <input type="button" value="发送" class="talk_sub" id="talksub"onclick="send()">
    </div>
</div>
</div>
<script type="text/javascript">
    //判断当前浏览器是否支持WebSocket
    urlinfo=window.location.href;
    arr= urlinfo.split("?");
    userID=arr[1]
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
        setMessageInnerHTML("已连接");
    }
    console.log("-----")
    //接收到消息的回调方法
    websocket.onmessage = function(event){
        setMessageInnerHTML(event.data);
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
        websocket.send(message);
        document.getElementById("talkwords").value=""
    }
</script>
</body>
</html>