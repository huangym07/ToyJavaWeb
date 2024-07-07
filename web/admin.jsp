<%--
  Created by IntelliJ IDEA.
  User: 19646
  Date: 2024/7/7
  Time: 18:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>车次管理</title>
    <script src="js/Vue.js"></script>
    <script src="js/index.js"></script>
    <script src="js/axios.js"></script>
    <link rel="stylesheet" href="css/index.css"/>

    <style>
        body {
            background-color: #f0f0f0; /* 浅灰色背景 */
            font-family: "Fira Code";
        }
    </style>
</head>
<body>


<div id="box">

    <el-button type="primary" @click="add">增加车次</el-button>


    <el-table :data="trainList" style="width: 100%" @selection-change="ChangeFun">
        <el-table-column prop="trainno" label="车次" width="80"></el-table-column>
        <el-table-column prop="startpos" label="出发站"></el-table-column>
        <el-table-column prop="endpos" label="到达站"></el-table-column>
        <el-table-column prop="startdate" label="出发日期"></el-table-column>
        <el-table-column prop="enddate" label="到达日期"></el-table-column>
        <el-table-column prop="price" label="票价"></el-table-column>
        <el-table-column prop="soldtickets" label="已售"></el-table-column>
        <el-table-column prop="avalibletickets" label="余票"></el-table-column>
        <el-table-column fixed="right" label="操作" width="100">
            <%--            scope:这一行所有的数据都存在于scope中--%>
            <template slot-scope="scope">
                <el-button type="text" size="small" @click="edit(scope.row)">编辑</el-button>
                <el-button type="text" size="small" @click="del(scope.row)">删除</el-button>
            </template>
        </el-table-column>
    </el-table>

    <el-pagination
            @size-change="handleSizeChange"<%--    切换一页多少条触发        --%>
            @current-change="handleCurrentChange"<%--    切换页码触发        --%>
            :current-page="currentPage" <%--  当前的页码数  --%>
            :page-sizes="[10, 15, 20, 225]"<%--一页显示多少条--%>
            :page-size="pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total">
    </el-pagination>
</div>
<script>
    new Vue({
        el: "#box",
        data: {
            trainList: [],
            total: 0,//数据总量
            currentPage: 1,//当前页码
            pageSize: 10,//一页显示多少条
            checkBoxData: [],//存储rid,
            addTrainVis: false,
            delTrainVis: false,
            editTrainVis: false,//编辑面板关闭
            train: {},
            addTrainVis: false,//新增面板
        },
        methods: {
            //一页显示多少条
            handleSizeChange: function (val) {
                this.pageSize = val;
                this.selectTrain();
            },
            //当前页码
            handleCurrentChange: function (val) {
                this.currentPage = val;
                this.selectTrain();
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
            //分页查询所有车次信息
            selectTrain: function () {
                var currentPage = this.currentPage;
                var pageSize = this.pageSize
                var that = this;//相当于把data中的属性，定义为全局变量
                axios.get("SelectTrainController?currentPage=" + currentPage + "&pageSize=" + pageSize).then(function (res) {
                    if (res.data.status) {
                        that.trainList = res.data.list;
                    } else {
                        that.$message.error(res.data.message);
                    }
                })
            },
            selectAllTrain: function () {
                var that = this;
                axios.get("SelectTrainAllController").then(function (res) {
                    if (res.data.status) {
                        that.trainList = res.data.list;
                        that.total = res.data.total;
                        that.selectTrain();
                    } else {
                        that.$message.error(res.data.message);
                    }
                })
            }
        },
        mounted: function () {
            this.selectAllTrain();
        }
    })
</script>


</body>
</html>
