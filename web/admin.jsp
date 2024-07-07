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


    <el-dialog title="新增提示框" :visible.sync="addTrainVis" width="53%">
        <el-form :model="train" :rules="rules" label-width="100px">
            <el-form-item label="车次编号" prop="trainno">
                <el-input v-model="train.trainno" width="319px"></el-input>
            </el-form-item>
            <el-form-item label="始发站" prop="startpos">
                <el-input v-model="train.startpos" width="319px"></el-input>
            </el-form-item>
            <el-form-item label="终点站" prop="endpos">
                <el-input v-model="train.endpos" width="319px"></el-input>
            </el-form-item>
            <el-form-item label="发车时间" prop="startdate">
                <el-input v-model="train.startdate" width="319px"></el-input>
            </el-form-item>
            <el-form-item label="到达时间" prop="enddate">
                <el-input v-model="train.enddate" width="319px"></el-input>
            </el-form-item>
            <el-form-item label="价格" prop="price">
                <el-input v-model="train.price" width="319px"></el-input>
            </el-form-item>
            <el-form-item label="初始票数" prop="availabletickets">
                <el-input v-model="train.availabletickets" width="319px"></el-input>
            </el-form-item>
        </el-form>
    </el-dialog>

    <el-dialog title="编辑提示框" :visible.sync="editTrainVis" width="53%">
        <el-form :model="train" :rules="rules" label-width="100px">
            <el-form-item label="始发站" prop="startpos">
                <el-input v-model="train.startpos" width="319px"></el-input>
            </el-form-item>
            <el-form-item label="终点站" prop="endpos">
                <el-input v-model="train.endpos" width="319px"></el-input>
            </el-form-item>
            <el-form-item label="发车时间" prop="startdate">
                <el-input v-model="train.startdate" width="319px"></el-input>
            </el-form-item>
            <el-form-item label="到达时间" prop="enddate">
                <el-input v-model="train.enddate" width="319px"></el-input>
            </el-form-item>
            <el-form-item label="价格" prop="price">
                <el-input v-model="train.price" width="319px"></el-input>
            </el-form-item>
            <el-form-item label="售出票数" prop="soldtickets">
                <el-input v-model="train.soldtickets" width="319px"></el-input>
            </el-form-item>
            <el-form-item label="剩余票数" prop="availabletickets">
                <el-input v-model="train.availabletickets" width="319px"></el-input>
            </el-form-item>
        </el-form>

        <span slot="footer" class="dialog-footer">
    <el-button @click="editTrainVis = false">取 消</el-button>
    <el-button type="primary" @click="editTrain">确 定</el-button>
        </span>
    </el-dialog>

    <el-dialog title="删除提示框" :visible.sync="delTrainVis" width="53%">
        <span>请问确定要删除该车次吗?</span>
        <span slot="footer" class="dialog-footer">
    <el-button @click="delTrainVis = false">取 消</el-button>
    <el-button type="primary" @click="delTrain">确 定</el-button>
        </span>
    </el-dialog>
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
            train: {
                trainno: "",
                startpos: "",
                endpos: "",
                startdate: "",
                enddate: "",
                price: "",
                soldtickets: "",
                availabletickets: ""
            },
            addTrainVis: false,//新增面板
            rules:
                {
                    trainno: [{
                        required: true, //是否校验
                        message: '请输入车次编号', //提示信息
                        trigger: 'blur' //trigger触发器，blur失去焦点
                    },
                        {
                            min: 2,
                            max: 15,
                            message: '长度在 2 到 15 个字符',
                            trigger: 'blur'
                        }
                    ],
                    startpos: [{
                        required: true,
                        message: '请输入始发站',
                        trigger: 'blur'
                    },
                        {
                            min: 2,
                            max: 15,
                            message: '长度在 2 到 15 个字符',
                            trigger: 'blur'
                        }
                    ],
                    endpos: [{
                        required: true,
                        message: '请输入终点站',
                        trigger: 'blur'
                    },
                        {
                            min: 2,
                            max: 15,
                            message: '长度在 2 到 15 个字符',
                            trigger: 'blur'
                        }
                    ],
                    startdate: [{
                        required: true,
                        message: '请输入发车时间',
                        trigger: 'blur'
                    },
                        {
                            min: 2,
                            max: 30,
                            message: '请输入合法日期和时间',
                            trigger: 'blur'
                        }
                    ],
                    startdate: [{
                        required: true,
                        message: '请输入到达时间',
                        trigger: 'blur'
                    },
                        {
                            min: 2,
                            max: 30,
                            message: '请输入合法日期和时间',
                            trigger: 'blur'
                        }
                    ],
                    price: [{
                        required: true,
                        message: '请输入价格',
                        trigger: 'blur'
                    },
                        {
                            min: 2,
                            max: 10,
                            message: '请输入合理价格',
                            trigger: 'blur'
                        }
                    ],
                    soldtickets: [{
                        required: true,
                        message: '请输入已卖出车票数目',
                        trigger: 'blur'
                    },
                        {
                            min: 2,
                            max: 10,
                            message: '请输入合理的卖出车票数目',
                            trigger: 'blur'
                        }
                    ],
                    availabletickets: [{
                        required: true,
                        message: '请输入剩余车票数目',
                        trigger: 'blur'
                    },
                        {
                            min: 2,
                            max: 10,
                            message: '请输入合理的剩余车票数目',
                            trigger: 'blur'
                        }
                    ]
                }
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
            },
            add: function () {
                this.addTrainVis = true;
                this.train.trainno = "";
                this.train.startpos = "";
                this.train.endpos = ""
                this.train.startdate = "";
                this.train.enddate = "";
                this.train.price = "";
                this.train.availabletickets = "";
            },
            addTrain: function () {
                var that = this;
                var trainno = this.train.trainno;
                var startpos = this.train.startpos;
                var endpos = this.train.endpos;
                var startdate = this.train.startdate;
                var enddate = this.train.enddate;
                var price = this.train.price;
                var availabletickets = this.train.availabletickets;
                axios.get("AddTrainController?trainno=" + trainno + "&startpos=" + startpos
                    + "&endpos=" + endpos + "&startdate=" + startdate
                    + "&enddate=" + enddate + "&price=" + price + "&availabletickets=" + availabletickets
                ).then(function (res) {
                    if (res.data.status) {
                        alert("添加成功");
                        that.addTrainVis = false;
                        that.selectTrain();
                    } else {
                        alert(res.data.message);
                    }
                })
            },
            edit: function (train) {
                this.editTrainVis = true;
                this.train = train;
            },
            editTrain: function () {
                var that = this;
                var trainno = this.train.trainno;
                var startpos = this.train.startpos;
                var endpos = this.train.endpos;
                var startdate = this.train.startdate;
                var enddate = this.train.enddate;
                var price = this.train.price;
                var soldtickets = this.train.soldtickets;
                var availabletickets = this.train.availabletickets;
                axios.get("UpdateTrainController?trainno=" + trainno + "&startpos=" + startpos
                    + "&endpos=" + endpos + "&startdate=" + startdate
                    + "&enddate=" + enddate + "&price=" + price + "&soldtickets=" + soldtickets + "&availabletickets=" + availabletickets
                ).then(function (res) {
                    if (res.data.status) {
                        alert("编辑成功");
                        that.editTrainVis = false;
                        that.selectTrain();
                    } else {
                        alert(res.data.message);
                    }
                })
            },
            del: function (train) {
                this.train = train;
                this.delTrainVis = true;
            },
            delTrain: function () {
                var that = this;
                trainno = this.train.trainno;
                axios.get("DelTrainController?trainno=" + trainno).then(function (res) {
                    if (res.data.status) {
                        alert("删除车次成功");
                        that.delTrainVis = false;
                        that.selectAllTrain();
                    } else {
                        alert(res.data.message);
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
