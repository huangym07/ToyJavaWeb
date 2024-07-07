<%--
  Created by IntelliJ IDEA.
  User: 19646
  Date: 2024/7/7
  Time: 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>车次信息</title>
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


<!-- 主内容区域 -->
<div class="main-content">

    <div id="box">
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
                    <el-button type="text" size="small" @click="add(scope.row)">购票</el-button>
                    <el-button type="text" size="small" @click="del(scope.row)">退票</el-button>
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

        <el-dialog title="购票确认" :visible.sync="addOrderVis" width="53%">
            <span>请问您确认要购买该车次票一张吗?</span>
            <span slot="footer" class="dialog-footer">
    <el-button @click="addOrderVis = false">取 消</el-button>
    <el-button type="primary" @click="addTOrder">确 定</el-button>
        </span>
        </el-dialog>

        <el-dialog title="退票确认" :visible.sync="delOrderVis" width="53%">
            <span>请问您确认要退票该车次票一张吗?</span>
            <span slot="footer" class="dialog-footer">
    <el-button @click="delOrderVis = false">取 消</el-button>
    <el-button type="primary" @click="delTOrder">确 定</el-button>
        </span>
        </el-dialog>
    </div>

</div>


<script>
    new Vue({
        el: "#box",
        data: {
            trainList: [],
            total: 0,//数据总量
            currentPage: 1,//当前页码
            pageSize: 5,//一页显示多少条
            addOrderVis: false, //购票面板
            delOrderVis: false,
            train: {
                trainno:""
            }
        },
        methods: {
            add: function (train) {
                this.train = train;
                this.addOrderVis = true;
            },
            addTOrder:function() {
              var trainno = this.train.trainno;
              var that = this;
              axios.get("BuyTOrderController?trainno=" + trainno).then(function(res){
                  if (res.data.status) {
                      alert("购票成功")
                      that.addOrderVis = false;
                      that.selectTrain();
                  } else {
                      alert(res.data.message);
                      that.addOrderVis = false;
                  }
              })
            },
            del: function (train) {
                this.train = train;
                this.delOrderVis = true;
            },
            delTOrder:function() {
                var trainno = this.train.trainno;
                var that = this;
                axios.get("CancelTOrderController?trainno=" + trainno).then(function(res){
                    if (res.data.status) {
                        alert("退票成功")
                        that.delOrderVis = false;
                        that.selectTrain();
                    } else {
                        alert(res.data.message);
                        that.delOrderVis = false;
                    }
                })
            },
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
            selectAllTrain : function() {
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
