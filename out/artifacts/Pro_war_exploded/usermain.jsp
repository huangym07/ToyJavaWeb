<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>主页</title>
    <script src="js/Vue.js"></script>
    <script src="js/index.js"></script>
    <script src="js/axios.js"></script>
    <link rel="stylesheet" href="css/index.css"/>
    <link rel="stylesheet" href="css/main.css"/>
    <style>
        * {
            margin: 0px;
            padding: 0px;
        }

        /*选中所有的标签设置高度为100%*/
        html, body, #box, .el-container, .el-menu {
            height: 100%;
        }

        .el-header {
            background-color: #B3C0D1;
            color: #333;
            text-align: center;
            line-height: 60px;
        }

        .el-aside {
            background-color: #D3DCE6;
            color: #333;
            text-align: center;
            line-height: 200px;
        }

        .el-main {
            background-color: #E9EEF3;
            color: #333;
            text-align: center;
            line-height: 160px;
        }

        body > .el-container {
            margin-bottom: 40px;
        }

        .el-container:nth-child(5) .el-aside,
        .el-container:nth-child(6) .el-aside {
            line-height: 260px;
        }

        .el-container:nth-child(7) .el-aside {
            line-height: 320px;
        }

        a {
            text-decoration: none;
            color: white;
        }

        .logo {
            float: left;
        }

        .logout {
            float: right;
        }
    </style>

</head>
<body>


<div id="box">
    <el-container>
        <el-header>
            <h2 class="logo">大连大学铁路售票系统</h2>
            <div class="logout">
                <span>欢迎${name}  </span>
                <a href="LogOutController">注销</a>
            </div>
        </el-header>
        <el-container>
            <el-aside width="200px">
                <el-menu
                        default-active="1"
                        class="el-menu-vertical-demo"
                        background-color="#545c64"
                        text-color="#fff"
                        active-text-color="#ffd04b">
                    <el-menu-item index="1">
                        <a href="train.jsp" target="main">
                            <i class="el-icon-menu"></i>
                            <span slot="title">车次信息</span></a>
                    </el-menu-item>
                    <el-menu-item index="2">
                        <a href="torder.jsp" target="main">
                            <i class="el-icon-document"></i>
                            <span slot="title">订单信息</span></a>
                    </el-menu-item>
                    <el-menu-item index="3">
                        <a href="updatepasswd.jsp" target="main">
                            <i class="el-icon-setting"></i>
                            <span slot="title">修改密码</span></a>
                    </el-menu-item>
                </el-menu>
            </el-aside>
            <el-main>
                <iframe name="main" width="95%" height="650px" frameborder="0"></iframe>
            </el-main>
        </el-container>
    </el-container>
</div>

<script>
    new Vue({
        el: "#box",
        data: {}
    })
</script>

</body>
</html>