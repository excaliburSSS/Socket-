<%-- Created by IntelliJ IDEA. User: abyss Date: 2021/4/10 Time: 10:25 To change this template use File | Settings |
    File Templates. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body {
            margin: 0;
            overflow: hidden;
            background: linear-gradient(to bottom, #19778c, #095f88);
            background-size: 1400% 300%;
            animation: dynamics 6s ease infinite;
            -webkit-animation: dynamics 6s ease infinite;
            -moz-animation: dynamics 6s ease infinite;
            font-size: 14px;
            color: #ffffff;
            min-height: 700px;
        }

        /*登录样式*/
        .main {
            position: fixed;
            text-align: center;
            top: 182px;
            width: 100%;
            height: auto;
            display: flex;
            justify-content: center;
        }

        .login {
            width: 470px;
            height: 470px;
            background: linear-gradient(to bottom, #19778c, #095f88);
            animation: dynamics 6s ease infinite;
            -webkit-animation: dynamics 6s ease infinite;
            -moz-animation: dynamics 6s ease infinite;
            opacity: 0.9;
            border: solid 1px #13a1fc;
            background-size: 1400% 300%;
        }

        @keyframes dynamics {
            0% {
                background-position: 0% 0%;
            }

            50% {
                background-position: 50% 100%;
            }

            100% {
                background-position: 100% 0%;
            }
        }

        .log-con {
            background: linear-gradient(#13a1fc, #13a1fc) left top, linear-gradient(#13a1fc, #13a1fc) left top,
            linear-gradient(#13a1fc, #13a1fc) right top, linear-gradient(#13a1fc, #13a1fc) right top,
            linear-gradient(#13a1fc, #13a1fc) left bottom, linear-gradient(#13a1fc, #13a1fc) left bottom,
            linear-gradient(#13a1fc, #13a1fc) right bottom, linear-gradient(#13a1fc, #13a1fc) right bottom;
            background-repeat: no-repeat;
            background-size: 3px 20px, 20px 3px;
            height: 100%;
            margin: -2px;
            padding: 3px 1px 1px 0;
            border-radius: 3px;
        }

        .log-con>span {
            font-size: 30px;
            font-weight: bold;
            line-height: 24px;
            letter-spacing: 2px;
            display: block;
            margin: 20px 0 44px 0;
        }

        .log-con>span::after {
            display: block;
            content: '';
            width: 57px;
            height: 3px;
            background: #ffffff;
            margin-top: 16px;
            justify-content: center;
            position: relative;
            left: 206px;
        }

        .log-con>input {
            display: block;
            margin: 10px 0 32px 70px;
            width: 330px;
            height: 42px;
            background-color: #ffffff;
            border-radius: 4px;
            opacity: 0.9;
            border: 0;
            font-size: 16px;
            outline: none;
            padding-left: 10px;
            color: #000000;
        }

        .log-con>button {
            width: 340px;
            height: 44px;
            background-color: #0090ff;
            color: #f9f9f9;
            border-radius: 4px;
            display: block;
            margin: 10px 0 0 70px;
            text-align: center;
            line-height: 44px;
            cursor: pointer;
            opacity: 1;
        }

        input::-webkit-input-placeholder {
            color: #000000;
            font-size: 16px;
        }

        .log-con>.code {
            width: 216px;
            display: inline-block;
            margin-left: 6px;
        }

        .log-con>#code {
            width: 94px;
            display: inline-block;
            margin-left: 14px;
            cursor: pointer;
        }

        /*logo*/
        .logo {
            width: 168px;
            height: 75px;
            position: fixed;
            left: 150px;
            top: 26px;
        }

        .logo>img {
            max-width: 100%;
            max-height: 100%;
        }

        /*版权样式*/
        .copyright {
            position: fixed;
            bottom: 10px;
            font-size: 16px;
            display: block;
            width: 100%;
            text-align: center;
        }
    </style>
</head>

<body>
<div class="main">
    <div class="login">
        <div class="log-con">
            <span>登录</span>
            <input type="text" class="name" placeholder="请输入用户名">
            <input type="password" class="password" placeholder="请输入密码">
            <button onclick="login()">立即登录</button>
        </div>
    </div>
</div>
<script type="text/javascript">
    var data = [
        {
            "name": "Alice",
            "password": 123456
        },
        {
            "name": "Bob",
            "password": 123456
        },
        {
            "name": "John",
            "password": 123456
        },
        {
            "name": "Tom",
            "password": 123456
        }
    ]
    function login() {
        name = document.getElementsByClassName("name").item(0).value
        password = document.getElementsByClassName("password").item(0).value
        //验证用户名和密码
        check(name, password)
    }
    function check(name, pw) {
        //账号校对
        var a = 0
        for (i in data) {
            if (name == data[i]["name"] && pw == data[i]["password"]) {
                console.log()
                console.log(i)
                alert("成功")
                window.location.href = "./main.jsp?"+name
                a = 1
            }
        }
        if (!a) {
            alert("账号或密码错误")
        }
    }
</script>
</body>

</html>