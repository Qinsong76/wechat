<%@page import="com.wechat.bean.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分享贴信息管理</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<style type="text/css">
	body{
		overflow: hidden;
	}
	.top{
		background-color: 	#A9A9A9;
	}
	.list{
		background-color: #D3D3D3;
		height: 1200px;
	}
	.acolor{
		background-color:#F0FFFF;
		color:#ffffff;
	}
	.img_manager{
		width: 35px;
		height: 35px;
	}
</style>
</head>
<body>
	<%
		if(session.getAttribute("login")==null||session.getAttribute("login")==""){
			request.getRequestDispatcher("/view/login.jsp").forward(request, response);
		}
		User user=(User)session.getAttribute("login");
	%>
	<div class="container-fluid">
		<div class="row top">
			<div class="col-lg-12">
				<h4 align="right">
					欢迎管理员:
					<a href="${APP_PATH}/view/admin.jsp?<%=user.getUid()%>">
					<img class="img_manager img-circle" src="${APP_PATH}/image/<%=user.getPurl() %>" alt="photo">
					</a>
				</h4>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-2 list">
				<br>
				<div class="list-group" style="width: 100%">
					<a href="#" class="list-group-item disabled">
					 	<span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span>
					  	功能列表
					 </a>
					 <a class="list-group-item" href="${APP_PATH}/index.jsp">
					 	<span class="glyphicon glyphicon-home" aria-hidden="true"></span>
					 	首页
					 </a>
					 <a class="list-group-item" href="${APP_PATH}/view/addGreens.jsp">
					 	<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
					 	添加菜品
					 </a>
					 <a class="list-group-item" href="${APP_PATH}/view/greensManager.jsp">
					 	<span class="glyphicon glyphicon-book" aria-hidden="true"></span>
					 	菜单信息管理
					 </a>
					 <a class="list-group-item" href="${APP_PATH}/view/userManager.jsp">
					 	<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
					 	用户信息管理
					 </a>
					 <a class="list-group-item" href="${APP_PATH}/view/commentManager.jsp">
					 	<span class="glyphicon glyphicon-text-size" aria-hidden="true"></span>
					 	用户评论管理
					 </a>
					 <a class="list-group-item active" href="${APP_PATH}/view/postManager.jsp">
						<span class="glyphicon glyphicon-send" aria-hidden="true"></span>
						 分享贴信息管理
					 </a>
				</div>
			</div>
			<div class="col-md-10">
				<h1 align="center">分享贴信息管理</h1>
				<!--分享贴修改的模态框-->
				<!-- Modal -->
				<div class="modal fade" id="empUpateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								<h4 class="modal-title" >员工修改</h4>
							</div>
							<div class="modal-body">
								<form class="form-horizontal">
									<div class="form-group">
										<label class="col-sm-2 control-label">uname</label>
										<div class="col-sm-10">
											<p class="form-control-static" id="empName_update_static"></p>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">openid</label>
										<div class="col-sm-10">
											<p class="form-control-static" id="empName_update_static2"></p>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">state</label>
										<div class="col-sm-10">
											<label class="radio-inline">
												<input type="radio" name="state" id="gender_update_input" value="yes" checked="checked"> yes
											</label>
											<label class="radio-inline">
												<input type="radio" name="state" id="gender2_update_input" value="no"> no
											</label>
										</div>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
								<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
							</div>
						</div>
					</div>
				</div>

				<div class="container">
					<!--按钮-->
					<div class="row">
						<div class="col-md-2 ">
							<button class="btn btn-warning" id="emp_delete_all_btn">批量删除</button>
						</div>
						<div class="col-md-2 col-md-offset-2">
							<select class="form-control" id="emp_select">
								<option >默认最新</option>
								<option value ="用户编号">用户编号</option>
								<option value ="内容">内容</option>
								<option value="最多点击">最多点击</option>
							</select>
						</div>
						<div class="col-md-2">
							<input type="text" class="form-control" placeholder="输入查询值" id="empselect_input"/>
						</div>
						<div class="col-md-2">
							<button class="btn btn-primary" id="select_btn">查询</button>
						</div>
					</div>
					<!--内容-->
					<div class="row">
						<div class="col-md-12">
							<table class="table table-hover" id="emps_table">
								<thead>
								<tr>
									<th>
										<input type="checkbox" id="check_all"/>
									</th>
									<th>#</th>
									<th>title</th>
									<th>uid</th>
									<th>pcontent</th>
									<th>hits</th>
									<th>pdate</th>
									<th>操作</th>
								</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>
						<!--分页-->
						<div class="row">
							<!--分页文字信息-->
							<div class="col-md-6" id="page_info_area">
								当前页，共页，共条记录
							</div>
							<!--分页条信息-->
							<div class="col-md-6" id="page_nav_area"></div>
						</div>
					</div>
				</div>

				<script type="text/javascript">
                    var totalRecord,currentPage;
                    //页面加载完成以后，直接去发送一个ajax请求，要到分页数据
                    $(function () {
                        //去首页
                        to_page(1);
                    });

                    function to_page(pn) {
                        var select_key=document.getElementById("emp_select").value;
                        var select_value = $('#empselect_input').val();//获取值
                        $.ajax({
                            url:"${APP_PATH }/findallpost",
                            data:"pn="+pn+"&select_key="+select_key+"&select_value="+select_value,
                            type:"GET" ,
                            success:function (result) {
                                //1,解析显示员工数据
                                build_emps_table(result);
                                //2，解析显示分页信息
                                build_page_info(result);
                                //3.显示分页条信息
                                build_page_nav(result);

                            }
                        });
                    }

                    function build_emps_table(result){
                        $("#emps_table tbody").empty();
                        var emps=result.extend.pageInfo.list;
                        $.each(emps,function (index,item) {
                            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
                            var pidTd=$("<td></td>").append(item.pid);
                            var titleTd=$("<td></td>").append(item.title);
                            var uidTd=$("<td></td>").append(item.uid);
                            var pcontentTd=$("<td></td>").append(item.pcontent);
                            var hitsTd=$("<td></td>").append(item.hits);
                            var pdateTd=$("<td></td>").append(item.pdate);


                            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                                .append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
                            //为删除按钮添加一个自定义的属性来表示当前的删除的员id
                            delBtn.attr("del-id",item.pid);
                            var btnTd = $("<td></td>").append(delBtn);
                            //append方法执得完以后还是返回原来的元素
                            $("<tr></tr>").append(checkBoxTd)
                                .append(pidTd)
                                .append(titleTd)
                                .append(uidTd)
                                .append(pcontentTd)
                                .append(hitsTd)
                                .append(pdateTd)
                                .append(btnTd)
                                .appendTo("#emps_table tbody")
                        })
                    }

                    //解析分页信息
                    function build_page_info(result) {
                        $("#page_info_area").empty();
                        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + "页,总"
                            + result.extend.pageInfo.pages + "页,总共"
                            + result.extend.pageInfo.total + "条记录");
                        totalRecord=result.extend.pageInfo.total;
                        currentPage=result.extend.pageInfo.pageNum;

                    }
                    //解析显示分页条
                    function build_page_nav(result){
                        $("#page_nav_area").empty();
                        var ul = $("<ul></ul>").addClass("pagination");
                        var firstPageLi = $("<li></li>").append(
                            $("<a></a>").append("首页").attr("href", "#"));
                        var prePageLi = $("<li></li>").append(
                            $("<a></a>").append("&laquo;"));
                        if (result.extend.pageInfo.hasPreviousPage == false) {
                            firstPageLi.addClass("disabled");
                            prePageLi.addClass("disabled")
                        } else {
                            firstPageLi.click(function() {
                                to_page(1);
                            });
                            prePageLi.click(function() {
                                to_page(result.extend.pageInfo.pageNum - 1);
                            });
                        }
                        var nextPageLi = $("<li></li>").append(
                            $("<a></a>").append("&raquo;"));
                        var lastPageLi = $("<li></li>").append(
                            $("<a></a>").append("末页").attr("href", "#"));
                        if (result.extend.pageInfo.hasNextPage == false) {
                            nextPageLi.addClass("disabled");
                            lastPageLi.addClass("disabled");
                        } else {
                            nextPageLi.click(function() {
                                to_page(result.extend.pageInfo.pageNum + 1);
                            });
                            lastPageLi.click(function() {
                                to_page(result.extend.pageInfo.pages);
                            });
                        }
                        //添加首页和前一页
                        ul.append(firstPageLi).append(prePageLi);
                        //添加1、2、3遍历ul中添加页码
                        $.each(result.extend.pageInfo.navigatepageNums, function(index, item) {
                            var numLi = $("<li></li>").append($("<a></a>").append(item));
                            if (result.extend.pageInfo.pageNum == item) {
                                numLi.addClass("active")
                            }
                            numLi.click(function() {
                                to_page(item);
                            });
                            ul.append(numLi);
                        });
                        //添加末页和下一页
                        ul.append(nextPageLi).append(lastPageLi);
                        var navEl = $("<nav></nav>").append(ul);
                        navEl.appendTo("#page_nav_area");
                    }

                    $(document).on("click",".delete_btn",function () {
                        var uid=$(this).parents("tr").find("td:eq(3)").text();
                        var pid=$(this).attr("del-id");
                        if (confirm("确认删除【" + uid + "】吗？")) {
                            $.ajax({
                                url : "${APP_PATH}/deletpostbypid/" + pid,
                                type : "DELETE",
                                success : function(result) {
                                    //alert(result.msg);
                                    //回到本页
                                    to_page(currentPage);
                                }
                            });
                        }
                    });

                    //完成全选 、全不选功能
                    $("#check_all").click(function () {
                        //attr获取checked是undefined
                        //我们这些dom原生的属性，attr获取自定义的属性的值
                        //prop修各读取dom原生属性的值
                        $(".check_item").prop("checked",$(this).prop("checked"));
                    });
                    //check_item
                    $(document).on("click",".check_item",function () {
                        //判断先中的个数是否是5个
                        var flag = $(".check_item:checked").length == $(".check_item").length;
                        $("#check_all").prop("checked", flag);
                    });

                    //点击全部删除，就批量删除
                    $("#emp_delete_all_btn").click(function () {
                        //提示要删除的员工姓名
                        var empunames="";
                        var del_list="";
                        $.each($(".check_item:checked"),function () {
                            empunames +=$(this).parents("tr").find("td:eq(3)").text()+ ",";
                            del_list+=$(this).parents("tr").find("td:eq(1)").text()+ "-";
                        }) ;
                        //去除多余的逗号
                        empunames = empunames.substring(0, empunames.length - 1);
                        del_list = del_list.substring(0, del_list.length - 1);
                        if(confirm("确认删除【"+empunames+"】吗？")){
                            //发送ajax请求
                            $.ajax({
                                url : "${APP_PATH}/deletpostbypid/" + del_list,
                                type : "DELETE",
                                success : function(result) {
                                    alert(result.msg);
                                    to_page(currentPage);
                                }
                            });
                        }
                    });
                    //按条件查询用户信息
                    $("#select_btn").click(function () {
                        to_page(1);
                    });

				</script>


			</div>
		</div>
	</div>
</body>
</html>