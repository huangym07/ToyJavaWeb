<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2024/7/6
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户登录</title>
    <script src="js/Vue.js"></script>
    <script src="js/index.js"></script>
    <script src="js/axios.js"></script>
    <link rel="stylesheet" href="css/index.css"/>
    <style>
        body {
            font-family: "Fira Code";
            background-image: url(image/img1.jpg);
            background-size: cover;
            background-color: #f0f5ff; /* 主色调蓝色 */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        .form-container {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            width: 300px;
            margin: 0 auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            position: absolute;
            top: 22%;
            left: 40%;
        }

        .form-title {
            text-align: center;
            font-size: 24px;
            color: #1890ff; /* 主色调蓝色 */
            margin-bottom: 20px;
        }

        .form-item {
            margin-bottom: 15px;
        }

        .form-item label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .form-item input,select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-item button {
            width: 100%;
            padding: 10px;
            background-color: #1890ff; /* 主色调蓝色 */
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .form-item button:hover {
            background-color: #40a9ff; /* 深色调蓝色 */
        }
    </style>
</head>
<body>
<div id="app" class="form-container">
    <div class="form-title">用户登录</div>
    <div class="form-item">
        <label for="username">用户名</label>
        <input type="text" id="username" v-model="username" placeholder="请输入用户名" maxlength="20" required>
    </div>
    <div class="form-item">
        <label for="password">密码</label>
        <input type="password" id="password" v-model="password" placeholder="请输入密码" maxlength="20" required>
    </div>
    <div class="form-item">
        <label for="userType">账户类型</label>
        <select v-model="userType" id="userType">
            <option value="普通用户">普通用户</option>
            <option value="管理员">管理员</option>
        </select>
    </div>
    <div class="form-item">
        <button @click="login">登录</button>
        <br><br>
        <button @click="register">注册</button>
    </div>
</div>

<script>
    new Vue({
        el: "#app",
        data: {
            username: "",
            password: "",
            userType: "普通用户"  // 默认为普通用户
        },
        methods: {
            register: function () {
                window.location.href = "/register.jsp";
            },
            login: function () {
                // 根据用户类型跳转到不同的页面
                if (this.userType === '管理员') {

                    let option = {
                        url: <%=request.getContextPath()%>"/AdminSignInController?" +
                            "adminusername="+this.username
                            +"&adminpassword="+this.password,
                        method: "POST"
                    };
                    var that = this; // 保存当前上下文的引用，以便在 Axios 回调函数中使用
                    axios(option).then(function (res) {
                        console.log(res)
                        if (res.data.status) {
                            that.$message("登录成功");
                            window.location.href = "/admin.jsp";
                        } else {
                            that.$message.error(res.data.message);
                        }
                    }).catch(function (error) {
                        console.log(error)
                        that.$message.error("登录失败，请稍后再试.");
                    });
                } else {
                    let option = {
                        url: <%=request.getContextPath()%>"/UserSignInController?" +
                            "username="+this.username
                            +"&password="+this.password,
                        method: "POST"
                    };
                    var that = this; // 保存当前上下文的引用，以便在 Axios 回调函数中使用
                    axios(option).then(function (res) {
                        console.log(res)
                        if (res.data.status) {
                            that.$message("登录成功");
                            window.location.href = "/index.jsp";
                        } else {
                            that.$message.error(res.data.message);
                        }
                    }).catch(function (error) {
                        console.log(error)
                        that.$message.error("登录失败，请稍后再试.");
                    });
                }
            }
        }
    });
</script>
</body>
</html>
