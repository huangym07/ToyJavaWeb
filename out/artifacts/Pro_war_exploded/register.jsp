<%--
  Created by IntelliJ IDEA.
  User: 19646
  Date: 2024/7/7
  Time: 15:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <script src="js/Vue.js"></script>
    <script src="js/index.js"></script>
    <script src="js/axios.js"></script>
    <link rel="stylesheet" href="css/index.css"/>
    <style type="text/css">
        #box {
            width: 400px;
            height: 400px;
            margin: 0px auto;
            /*background-color: aqua;*/
            background-color: #ffffff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            position: absolute;
            top: 22%;
            left: 35%;
        }
        body{
            background-image: url("image/img3.jpg");
            background-size: cover;
        }
        .el-input {
            width: 80%;
        }
        .form-title {
            text-align: center;
            font-size: 24px;
            color: #1890ff; /* 主色调蓝色 */
            margin-bottom: 20px;
        }
        .form-button {
            text-align: center;
            font-size: 15px;
            color: #1890ff; /* 主色调蓝色 */
            margin-bottom: 20px;
        }

    </style>
</head>
<body >
<div id="box">
    <div class="form-title">
        用户注册
    </div>
    <!-- 进行验证，ref就会返回一个user -->
    <el-form :rules="rules" ref="user" :model="user" label-width="80px">
        <el-form-item label="用户名" prop="username">
            <el-input v-model="user.username"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
            <el-input v-model="user.password"></el-input>
        </el-form-item>
        <el-form-item label="姓名" prop="name">
            <el-input v-model="user.name"></el-input>
        </el-form-item>
        <el-form-item label="电话号" prop="phonenumber">
            <el-input v-model="user.phonenumber"></el-input>
        </el-form-item>
        <div class="form-button">
        <el-form-item>
            <el-button @click="register('user')">注册</el-button>
        </el-form-item>
        </div>
    </el-form>
</div>

<script>
    new Vue({
        el: "#box",
        data: {
            user: {
                username: "",
                password: "",
                name:"",
                phonenumber:""
            },
            rules:
                {
                    username: [{
                        required: true, //是否校验
                        message: '请输入用户名', //提示信息
                        trigger: 'blur' //trigger触发器，blur失去焦点
                    },
                        {
                            min: 2,
                            max: 8,
                            message: '长度在 2 到 8 个字符',
                            trigger: 'blur'
                        }
                    ],
                    //验证密码
                    password: [{
                        required: true,
                        message: '请输入密码',
                        trigger: 'blur'
                    },
                        {
                            min: 2,
                            max: 8,
                            message: '长度在 2 到 8 个字符',
                            trigger: 'blur'
                        }
                    ],
                    // 验证姓名
                    name: [{
                        required: true,
                        message: '请输入姓名',
                        trigger: 'blur'
                    },
                        {
                            min: 2,
                            max: 8,
                            message: '长度在 2 到 8 个字符',
                            trigger: 'blur'
                        }
                    ],
                    // 验证电话号
                    phonenumber: [{
                        required: true,
                        message: '请输入电话号（11 位）',
                        trigger: 'blur'
                    },
                        {
                            min: 2,
                            max: 15,
                            message: '请输入 11 位电话号码',
                            trigger: 'blur'
                        }
                    ]
                }
        },
        methods: {
            register: function (user) {
                this.$refs[user].validate((valid) => {
                    if (valid) {
                        var username = this.user.username;
                        var password = this.user.password;
                        var name = this.user.name;
                        var phonenumber = this.user.phonenumber;
                        axios.get("/UserSignUpController?username=" + username + "&password=" + password + "&name=" + name + "&phonenumber=" + phonenumber).then(function (res) {
                            if (res.data.status){
                                alert("注册成功，请登录");
                                location.href="login.jsp";
                            }else{
                                alert(res.data.message)
                            }
                        })
                    } else {
                        alert("请完整地输入正确的信息")
                    }
                });
            }
        }
    })
</script>
</body>
</html>
