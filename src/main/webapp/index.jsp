<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Index</title>
    <%--<jsp:forward page="/emps"/>--%>
    <script src="js/jquery-3.6.0.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <script src="js/bootstrap.min.js"></script>
</head>

<body>

<%--UpdateModal--%>
<div class="modal fade" id="update_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">Update Employee</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="update_form">
                    <div class="form-group">
                        <label for="empName" class="col-sm-2 control-label">Name: </label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empNameUmd"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empEmail" class="col-sm-2 control-label">E-mail: </label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="empEmailUpdate" name="email"
                                   placeholder="email@qq.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Gender: </label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_male_Update" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_female_Update" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Department: </label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_Update">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="update">Update</button>
            </div>
        </div>
    </div>
</div>

<!-- AddModal -->
<div class="modal fade" id="add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">Add Employee</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="add_form">
                    <div class="form-group">
                        <label for="empName" class="col-sm-2 control-label">Name: </label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName" name="empName" placeholder="HowFun">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empEmail" class="col-sm-2 control-label">E-mail: </label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="empEmail" name="email"
                                   placeholder="email@qq.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Gender: </label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_male" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_female" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Department: </label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="save">Save</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>员工管理系统</h1>
        </div>
    </div>
    <p class="row">
    <p class="col-md-4 col-md-offset-8">
        <button class="btn btn-primary" id="add">Add</button>
        <button class="btn btn-danger" id="delAll">Delete</button>
    </p>
    </p>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="checkAll">
                    </th>
                    <th>ID</th>
                    <th>NAME</th>
                    <th>GENDER</th>
                    <th>E-MAIL</th>
                    <th>DEPARTMENT</th>
                    <th>OPERATION</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" id="page_info">

        </div>
        <div class="col-md-6" id="page_nav">

        </div>
    </div>
</div>

<script>
    var total;
    var pageNum;

    $(function () {
        toPage(1);
    });
    
    $("#delAll").click(function () {
        var names = "";
        var ids = "";

        $.each($(".checkItem:checked"), function (index, item) {
                names += $(this).parents("tr").find("td:eq(2)").text() + ", ";
                ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });

        names = names.substring(0, names.length - 2);
        ids = ids.substring(0, ids.length - 1);


        if (confirm("Are You Sure To DELETE Employees " + names + " ?"))
        {
            $.ajax({
                url: "/emp/" + ids,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    toPage(pageNum);
                }
            })
        }
    });

    $("#checkAll").click(function () {
        $(".checkItem").prop("checked", $(this).prop("checked"));
    });

    $(document).on("click", ".checkItem", function () {
        var isAllChecked = $(".checkItem:checked").length == $(".checkItem").length;
        $("#checkAll").prop("checked", isAllChecked);
    });

    // 更新
    $("#update").click(function () {
        $.ajax({
            url: "/emp/" + $("#update").attr("edt-id"),
            type: "PUT", // 直接写成PUT会造成请求体中存在数据但无法封装
            // Tomcat中会将POST类型请求的数据封装在一个类似Map的容器，然后通过request.getParameter(key)获取，而PUT则不会
            data: $("#update_form").serialize(), // 加入HttpPutFormFilter之后则不再需要后面字段 + "&_method=PUT", // Rest编程风格
            success: function (result) {
                alert(result.msg);
                $("#update_modal").modal("hide");
                toPage(pageNum);
            }
        })
    });

    // ajax请求后端，后端仍需继续进行正则表达式校验，否则会导致显示用户名可用但无法加入（数据库中无，但与前端不匹配）
    $("#empName").change(function () {
        var name = $("#empName").val();

        $.ajax({
            url: "/checks",
            type: "POST",
            data: "empName=" + name,
            success: function (result) {
                if (result.state == 200) {
                    // alert("Illegal Name!")
                    $("#empName").parent().removeClass("has-error has-success");
                    $("#empName").parent().addClass("has-success");
                    $("#empName").next("span").text("This name is legal");
                    $("#save").attr("ajax-ver", "success");
                }
                else {
                    $("#empName").parent().removeClass("has-error has-success");
                    $("#empName").parent().addClass("has-error");
                    $("#empName").next("span").text(result.contents.check);
                    $("#save").attr("ajax-ver", "fail");
                }
            }
        });
    });

    // 点击保存按钮
    $("#save").click(function () {
        // 前端验证
        if (!verify())
            return false;

        // 根据change事件发出的ajax请求获得的属性验证
        if ($("#save").attr("ajax-ver") == "fail")
            return false;

        $.ajax({
            url: "/emp",
            type: "POST",
            data: $("#add_form").serialize(),
            success: function (result) {
                if (result.state == 200) {
                    alert(result.msg);
                    $("#add_modal").modal("hide"); // 关闭模态框
                    toPage(total); // 直接跳到尾页
                }
                else {
                    if (result.contents.errors.empName != undefined) {
                        $("#empName").parent().removeClass("has-error has-success");
                        $("#empName").parent().addClass("has-error");
                        $("#empName").next("span").text(result.contents.errors.empName);
                    }
                    if (result.contents.errors.email != undefined) {
                        $("#empEmail").parent().removeClass("has-error has-success");
                        $("#empEmail").parent().addClass("has-error");
                        $("#empEmail").next("span").text(result.contents.errors.email);
                    }
                }
            }
        })
    });

    // 点击新增按钮
    $("#add").click(function () {
        getDept($("#dept"));

        $("#add_form")[0].reset();
        $("#add_form").find("*").removeClass("has-error has-success");
        $("#add_form").find(".help-block").text("");

        $("#add_modal").modal({
            keyboard: false
        });
    });

    // 直接获取class进行绑定会导致事件在按钮创建之前绑定，导致后续得到的按钮无法绑定事件，需要使用on方法
    $(document).on("click", ".edt-btn", function () {
        getDept($("#dept_Update"));
        getEmp($(this).attr("edt-id"));
        $("#update").attr("edt-id", $(this).attr("edt-id"));

        $("#update_modal").modal({
            keyboard: false
        });
    });

    $(document).on("click", ".del-btn", function () {
        var name = $(this).parents("tr").find("td:eq(2)").text();

        if (confirm("Are You Sure To DELETE The Employee " + name + " ?")) {
            $.ajax({
                    url: "/emp/" + $(".del-btn").attr("del-id"),
                    type: "DELETE",
                    success: function (result) {
                        alert(result.msg);
                        toPage(pageNum);
                    }
                }
            )
        }
    });

    // 根据按钮上绑定的员工id属性进行模态框的赋值
    function getEmp(id) {
        $.ajax({
            url: "/emp/" + id,
            type: "GET",
            success: function (result) {
                var emp = result.contents.employee;
                $("#empNameUmd").empty();
                $("#empNameUmd").append(emp.empName);
                $("#empEmailUpdate").val(emp.email);
                $("#update_modal input[name=gender]").val([emp.gender]);
                $("#update_modal select").val([emp.dId]);
            }
        });
    }

    // 前端输入验证
    function verify() {
        var empName = $("#empName").val();
        var regNameEng = /^[a-zA-Z-]{6,16}$/;
        var regNameChn = /^[\u2E80-\u9FFF]{2,6}$/;

        if (!regNameChn.test(empName) && !regNameEng.test(empName)) {
            // alert("Illegal Name!")
            $("#empName").parent().removeClass("has-error has-success");
            $("#empName").parent().addClass("has-error");
            $("#empName").next("span").text("Illegal Name!");
            return false;
        } else {
            $("#empName").parent().removeClass("has-error has-success");
            $("#empName").parent().addClass("has-success");
            $("#empName").next("span").text("");
            return true;
        }
    }

    // 发出ajax请求填充模态框部门名称
    function getDept(ele) {
        $.ajax({
            url: "/depts",
            type: "GET",
            success: function (result) {
                var select = ele;
                select.empty();

                $.each(result.contents.depts, function (index, item) {
                    var option = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                    select.append(option);
                })
            }
        })
    }

    function toPage(pn) {
        $.ajax({
            url: "/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        $("#emps_table tbody").empty();

        var emps = result.contents.pageInfo.list;

        $.each(emps, function (index, item) {
            var checkTd = $("<td><input type='checkbox' class='checkItem'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? 'Male' : 'Female');
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>")
                .addClass("btn btn-primary btn-sm edt-btn")
                .append($("<span></span>")
                    .addClass("glyphicon glyphicon-pencil"))
                .append(" Edit");

            editBtn.attr("edt-id", item.empId);

            var delBtn = $("<button></button>")
                .addClass("btn btn-danger btn-sm del-btn")
                .append($("<span></span>")
                    .addClass("glyphicon glyphicon-trash"))
                .append(" Delete");

            delBtn.attr("del-id", item.empId);

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            $("<tr></tr>").append(checkTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }

    function build_page_info(result) {
        $("#page_info").empty();

        $("#page_info").append("当前页码：" + result.contents.pageInfo.pageNum +
            "，总页数：" + result.contents.pageInfo.pages +
            "，总记录条数：" + result.contents.pageInfo.total);

        total = result.contents.pageInfo.total;
        pageNum = result.contents.pageInfo.pageNum;
    }

    function build_page_nav(result) {
        $("#page_nav").empty();

        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));


        if (result.contents.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }
        else {
            firstPageLi.click(function () {
                toPage(1);
            });
            prePageLi.click(function () {
                toPage(result.contents.pageInfo.pageNum - 1);
            });
        }

        if (result.contents.pageInfo.hasNextPage == false) {
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }
        else {
            nextPageLi.click(function () {
                toPage(result.contents.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                toPage(result.contents.pageInfo.pages);
            });
        }

        ul.append(firstPageLi).append(prePageLi);

        $.each(result.contents.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));

            if (result.contents.pageInfo.pageNum == item)
                numLi.addClass("active");

            numLi.click(function () {
                toPage(item);
            });

            ul.append(numLi);
        })

        ul.append(nextPageLi).append(lastPageLi);

        var nav = $("<nav></nav>").append(ul);

        nav.appendTo("#page_nav");
    }
</script>
</body>
</html>