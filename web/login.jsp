<%--
  Created by IntelliJ IDEA.
  User: 19646
  Date: 2024/7/5
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="utf-8"/>
    <title></title>
    <script src="js/Vue.js"></script>
    <script src="js/index.js"></script>
    <script src="js/axios.js"></script>
    <link rel="stylesheet" href="css/index.css">
</head>
<style>
    #box {
        width: 400px;
        height: 260px;
        background-color: aqua;
        margin: 100px auto;
    }

    .el-input {
        width: 200px;
    }
</style>
<body>
<div id="box">
    <!-- v-bind:model 属性的双向绑定 -->
    <el-form :model="user" :rules="rules" ref="user" label-width="80px">
        <!-- <el-form-item>一个作用域  -->
        <!-- prop 绑定的规则名称要与表单双向绑定的变量名一致 -->
        <el-form-item label="账号" prop="username">
            <el-input v-model="user.username"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
            <el-input v-model="user.password"></el-input>
        </el-form-item>
        <el-form-item>
            <!-- user 就是字符串对象 -->
            <el-button @click="login('user')">登录</el-button>
        </el-form-item>
    </el-form>
</div>

<script>
    new Vue({
        el: "#box",
        data: {
            user: {
                username: "",
                password: ""
            },
            rules: {
                username: [
                    {
                        required: true,
                        message: '账号不能为空',
                        trigger: 'blur', // 失去焦点时触发器触发，从而进行验证
                    },
                    {
                        min: 2,
                        max: 10,
                        message: '长度在 2 到 5 个字符',
                        trigger: 'blur',
                    }
                ],
                password: [
                    {
                        required: true,
                        message: '密码不能为空',
                        trigger: 'blur',
                    },
                    {
                        min: 3,
                        max: 10,
                        message: "aaa",
                        trigger: 'blur'
                    }
                ]
            }
        },
        methods: {
            login: function (user) {
                // this.$refs[formRule] 获取 formRule 对象的规则验证
                // valid 验证的结果
                this.$refs[user].validate((valid) => {
                    if (valid) {
                        var username = this.user.username;
                        var password = this.user.password;
                        // get 代表用明文请求, post 密文请求
                        // then 后端返回的结果
                        // axios.get(路径和参数).then(function(res){});
                        // function 回调函数：res 是后端返回的结果
                        axios.get("UserSignInController?username="+username + "&password=" + password).then(function(res) {
                            if (res.data.status) {
                                // 成功后跳转到主页
                                location.href = "index.jsp";
                            } else {
                                alert(res.data.message);
                            }
                        });
                    } else {
                        alert("输入格式错误");
                    }
                });
            }
        }
    })
</script>

</body>
</html>
