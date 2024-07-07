<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>
    <script src="js/Vue.js"></script>
    <script src="js/index.js"></script>
    <script src="js/axios.js"></script>
    <link rel="stylesheet" href="css/index.css"/>
    <link rel="stylesheet" href="css/main.css"/>
    <style>
        .main{
            width: 500px;
            height: 500px;
            margin: auto;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
        }
        body {
            font-family: "Fira Code";
        }
    </style>
</head>
<body>

<div id="box" class="main">
    <!-- v-bind:model 属性的双向绑定 -->
    <el-form :model="user" :rules="rules" ref="user" label-width="80px">
        <!-- <el-form-item>一个作用域  -->
        <!-- prop 绑定的规则名称要与表单双向绑定的变量名一致 -->
        <el-form-item label="新密码" prop="password">
            <el-input v-model="user.password"></el-input>
        </el-form-item>
        <el-form-item>
            <!-- user 就是字符串对象 -->
            <el-button @click="updatepasswd('user')">确定</el-button>
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
                        message: '用户名不能为空',
                        trigger: 'blur',
                    },
                    {
                        min: 2,
                        max: 15,
                        message: "用户名长度在 2~8 个字符",
                        trigger: 'blur'
                    }
                ],
                password: [
                    {
                        required: true,
                        message: '密码不能为空',
                        trigger: 'blur',
                    },
                    {
                        min: 2,
                        max: 15,
                        message: "密码长度在 2~8 个字符",
                        trigger: 'blur'
                    }
                ]
            }
        },
        methods: {
            updatepasswd: function (user) {
                // this.$refs[formRule] 获取 formRule 对象的规则验证
                // valid 验证的结果
                this.$refs[user].validate((valid) => {
                    if (valid) {
                        var password = this.user.password;
                        axios.get("UserUpdatePasswordController?password=" + password).then(function(res) {
                            if (res.data.status) {
                                // 成功后跳转到主页
                                alert("修改成功，请重新登录");
                                top.location.replace("LogOutController")
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
