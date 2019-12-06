<%@page contentType="text/html; UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<script>
    $(function () {
        $("#bannerTable").jqGrid(
            {
                url: "${pageContext.request.contextPath}/emp/queryAll",
                datatype: "json",
                colNames: ['ID', '姓名', '年龄', '薪资', '入职时间', "操作"],
                colModel: [
                    {name: 'id', hidden: true},
                    {name: 'name', align: "center", editable: true, editrules: {required: true}},
                    {name: 'age', align: "center", editable: true, editoptions: {required: true}},
                    {name: 'salary', align: "center"},
                    {name: 'create_time', align: "center", editable: true, editoptions: {required: true}},
                    {
                        name: "options",
                        formatter: function (value, options, row) {
                            return `` +
                                `<button class="btn btn-primary" onclick="editRow('` + row.id + `');">修改</button>&nbsp;&nbsp;` +
                                `<button class="btn btn-danger" onclick="delRow('` + row.id + `');">删除</button>`;
                        }, search: false
                    },
                ],
                rowNum: 4,
                rowList: [4, 10, 20, 30],
                pager: '#bannerPage',
                mtype: "post",
                viewrecords: true,
                styleUI: "Bootstrap",
                autowidth: true,
                multiselect: true,
                editurl: "${pageContext.request.contextPath}/emp/edit",
                closeAfterEdit: true,
            }).navGrid(
            '#bannerPage',//参数1: 分页工具栏id
            {add: true},   //参数2:开启工具栏编辑按钮
            {closeAfterEdit: true, reloadAfterSubmit: true},//编辑面板的配置
            {closeAfterAdd: true, reloadAfterSubmit: true},//添加面板的配置
            {},//删除的配置
            {
                sopt: ['eq', 'ne', 'cn']
            }//搜索的配置
        );


    });

    //添加一行
    function saveRow() {
        $("#empList").jqGrid('editGridRow', "new", {
            height: 400,
            reloadAfterSubmit: true,
            closeAfterAdd: true
        });
    }

    //删除一行
    function delRow(id) {
        if (window.confirm("您确定要删除吗?")) {
            //发送ajax请求删除
            $.post("${pageContext.request.contextPath}/emp/edit", {id: id, oper: "del"}, function () {
                //刷新表格
                $("#bannerPage").trigger('reloadGrid');//刷新表格
            });
        }

    }

    //修改一行
    function editRow(id) {
        console.log(id);
        $("#bannerPage").jqGrid('editGridRow', id, {
            height: 400,
            reloadAfterSubmit: true,
            closeAfterEdit: true,
        });
    };
</script>

<div class="col-sm-10">

    <div class="page-header">
        <h1>员工列表</h1>
    </div>

    <%--员工列表--%>
    <table id="bannerTable"></table>

    <%--分页工具栏--%>
    <div id="bannerPage"></div>

</div>
