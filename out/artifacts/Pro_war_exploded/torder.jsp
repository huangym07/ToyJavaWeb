<%--
  Created by IntelliJ IDEA.
  User: 19646
  Date: 2024/7/7
  Time: 9:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户订单信息</title>
    <script src="js/Vue.js"></script>
    <script src="js/index.js"></script>
    <script src="js/axios.js"></script>
    <link rel="stylesheet" href="css/index.css"/>
    <link rel="stylesheet" href="css/main.css"/>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        .box {
            position: center;
            height: 100%;
            width: 100%;
        }
    </style>
</head>
<body>


<div id="box">
    <el-table :data="torderList" style="width: 100%" @selection-change="ChangeFun">
        <el-table-column prop="username" label="用户名" width="80"></el-table-column>
        <el-table-column prop="trainno" label="车次编号"></el-table-column>
        <el-table-column prop="tickets" label="购票数"></el-table-column>
    </el-table>

    <el-pagination
            @size-change="handleSizeChange"<%--    切换一页多少条触发        --%>
            @current-change="handleCurrentChange"<%--    切换页码触发        --%>
            :current-page="currentPage" <%--  当前的页码数  --%>
            :page-sizes="[10, 15, 20, 25]"<%--一页显示多少条--%>
            :page-size="pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total">
    </el-pagination>

</div>



<script>
    new Vue({
        el:"#box",
        data: {
            torderList: [],
            total: 0,//数据总量
            currentPage: 1,//当前页码
            pageSize: 10,//一页显示多少条
            torder: {
            }
        },
        methods : {
            //一页显示多少条
            handleSizeChange: function (val) {
                this.pageSize = val;
                this.selectTOrder();
            },
            //当前页码
            handleCurrentChange: function (val) {
                this.currentPage = val;
                this.selectTOrder();
            },
            ChangeFun: function (arr) {
                this.checkBoxData = [];//防止追加问题
                //arr:数组

                for (let i = 0; i < arr.length; i++) {
                    // this.checkBoxData.push(arr[i].rid)
                    this.checkBoxData.push(arr[i].rid)
                }
                console.log(this.checkBoxData)
            },
            selectTOrder: function() {
                var currentPage = this.currentPage;
                var pageSize = this.pageSize
                var that = this;
                axios.get("UserTOrderSelectController?currentPage=" + currentPage + "&pageSize=" + pageSize).then(function (res) {
                    if (res.data.status) {
                        that.torderList = res.data.list;
                    } else {
                        that.$message.error(res.data.message);
                    }
                })
            },
            selectAllTOrder: function() {
                var that = this;
                axios.get("UserTOrderSelectAllController").then(function (res) {
                    if (res.data.status) {
                        that.torderList = res.data.list;
                        that.total = res.data.total;
                        that.selectTOrder();
                    } else {
                        that.$message.error(res.data.message);
                    }
                })
            }
        },
        mounted: function () {
            this.selectAllTOrder();
        }
    })
</script>

</body>
</html>
