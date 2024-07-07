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
    <style>
        body {
            background-image: url("image/img3.jpg");
            background-size: cover;
            display: flex;
            justify-content: center; /* 水平居中 */
            align-items: center; /* 垂直居中 */
            height: 100vh; /* 使父元素占据整个视口高度 */
            margin: 0; /* 移除 body 的默认外边距 */
        }
        #box {
            background-color: #ffffff; /* 白色背景 */
            border-radius: 10px; /* 圆角 */
            /* 根据需要设置宽度、内边距等 */
            width: 20%; /* 示例宽度 */
            padding: 20px; /* 内边距 */
            /* 如果需要阴影效果 */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: center; /* 水平居中 */
            align-items: center; /* 如果需要垂直居中也可以添加，但这里主要是为了让表单在div中居中 */
            flex-direction: column; /* 如果表单项需要垂直堆叠，则保留此属性；否则可以移除 */
            margin: 20px auto; /* 上下外边距20px，左右自动外边距以实现水平居中（与justify-content: center一起使用时可能不是必需的，但有助于在页面中更好地定位div） */
            padding: 20px; /* 内边距，为表单内容提供一些空间 */
            /* 如果需要整个div占据视口的一部分或全部，可以添加以下属性 */
            /* height: calc(100vh - 40px); /* 示例高度，这里假设顶部和底部有20px的间隙 */
            /* box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 可选：添加一些阴影效果 */
        }
        .form-title {
            text-align: center;
            font-size: 24px;
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
        <el-form-item>
            <el-button @click="register('user')">注册</el-button>
        </el-form-item>
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
