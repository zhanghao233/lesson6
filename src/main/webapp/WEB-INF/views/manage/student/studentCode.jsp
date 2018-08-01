<%--
  Created by IntelliJ IDEA.
  User: 23577
  Date: 2018/7/28
  Time: 11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="lesson" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<lesson:page title="">
    <jsp:attribute name="script">
        <script type="application/javascript">
            function searchId() {
                    window.location.href="student/SearchCode.do?code="+$('#userCode').val();
                }
            function searchName() {
                window.location.href="student/SearchName.do?code="+$('#userName').val();
            }
            function searchBirthday() {
                alert("查询范围："+$('#lastBirthday').val()+"——"+$('#nextBirthday').val());
                window.location.href="student/SearchBirthday.do?lastBirthday="+$('#lastBirthday').val()+"&nextBirthday="+$('#nextBirthday').val();
            }
            function last() {
                window.location.href="student/SearchCodePage.do?currentPage=${currentPage-1}&code="+$('#userCode').val();
            }
            function next() {
                window.location.href="student/SearchCodePage.do?currentPage=${currentPage+1}&code="+$('#userCode').val();
            }
            $(function() {
                $( "#lastBirthday" ).datepicker({
                    changeMonth: true,
                    changeYear: true
                });
                $( "#nextBirthday" ).datepicker({
                    changeMonth: true,
                    changeYear: true
                });

            });

            function dele(stuDel){
                var tds = stuDel.parentElement.parentElement.children;
                var id = (tds[2]).innerHTML;
                if(confirm("确认删除吗")){
                    //alert("yes");
                    alert("确定删除id为: "+id+"的用户？");
                    window.location.href="student/studentDel.do?id="+id;
                }
                else{
                    //alert("no")
                    return;
                }
            }

            jQuery(function($) {
                //datepicker plugin
                //link
                $('.date-picker').datepicker({
                    autoclose: true,
                    todayHighlight: true
                })
                //show datepicker when clicking on the icon
                    .next().on(ace.click_event, function(){
                    $(this).prev().focus();
                });

                //or change it into a date range picker
                $('.input-daterange').datepicker({autoclose:true});


                //to translate the daterange picker, please copy the "examples/daterange-fr.js" contents here before initialization
                $('input[name=date-range-picker]').daterangepicker({
                    'applyClass' : 'btn-sm btn-success',
                    'cancelClass' : 'btn-sm btn-default',
                    locale: {
                        applyLabel: 'Apply',
                        cancelLabel: 'Cancel',
                    }
                })
                    .prev().on(ace.click_event, function(){
                    $(this).next().focus();
                });


                $('#timepicker1').timepicker({
                    minuteStep: 1,
                    showSeconds: false,
                    showMeridian: true,
                    disableFocus: true,
                    icons: {
                        up: 'fa fa-chevron-up',
                        down: 'fa fa-chevron-down'
                    }
                }).on('focus', function() {
                    $('#timepicker1').timepicker('showWidget');
                }).next().on(ace.click_event, function(){
                    $(this).prev().focus();
                });
            })

        </script>
    </jsp:attribute>
    <jsp:body>
        <div>
            <div class="breadcrumbs ace-save-state" id="breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="welcome.do"><spring:message code="common.homepage"/></a>
                    </li>

                    <li class="active">学生管理系统<%--<spring:message code="role.title.list"/>--%></li>
                </ul>
            </div>
            <div class="page-content">
                <div class="page-header">
                    <h1>
                        学生管理
                        <small>
                            <i class="ace-icon fa fa-angle-double-right"></i>
                                <%--Static &amp; --%>学生信息
                        </small>
                    </h1>
                    <br>
                    <h1>
                            <%--根据条件查询--%>
                        <tr>
                            <td>
                                <div class="col-sm-3">
                                    <div class="input-group" style="width: 80%">
                                        <input type="text" autocomplete="off"
                                               name="userCode" id="userCode"
                                               maxlength="20" value="${code}"
                                               class="required form-control"/>
                                        <span class="input-group-btn" style="margin-left: auto">
                                             <button class="btn btn-sm btn-primary " onclick="searchId();" type="button">
                                                 <i class="ace-icon fa fa-check-circle-o"></i>
                                                 <spring:message code="学号查询"/>
                                             </button>
                                        </span>
                                    </div>
                                </div>
                            </td>
                            <td style="width: 10%">
                                <div class="col-sm-3">
                                    <div class="input-group" style="width: 80%">
                                        <input type="text" autocomplete="off"
                                               name="userName" id="userName"
                                               maxlength="20" value="${name}"
                                               class="required form-control"/>
                                        <span class="input-group-btn">
                                             <button class="btn btn-sm btn-primary " onclick="searchName();" type="button">
                                                 <i class="ace-icon fa fa-check-circle-o"></i>
                                                 <spring:message code="姓名查询"/>
                                             </button>
                                        </span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="col-sm-3">
                                    <div class="input-group">
                                        <div class="row">
                                            <div class="col-xs-8 col-sm-11">
                                                <div class="input-daterange input-group">
                                                    <input type="text" class="input-sm form-control" data-date-format="yyyy-mm-dd" style="width: 100px;" name="lastBirthday" id="lastBirthday" placeholder="开始时间" value="${lastBirthday}"/>
                                                    <span class="input-group-addon">
																		<i class="fa fa-exchange"></i>
																	</span>

                                                    <input type="text" class="input-sm form-control" data-date-format="yyyy-mm-dd" style="width: 100px;" name="nextBirthday" id="nextBirthday" placeholder="结束时间" value="${nextBirthday}"/>
                                                </div>
                                            </div>
                                        </div>
                                            <%--<span class="input-group-btn">
                                            <input type="text" value="起始" style="width: 50px" disabled="disabled" class="required form-control">
                                            <input  type="text" autocomplete="off" data-date-format="yyyy-mm-dd"
                                                   name="lastBirthday" id="lastBirthday" placeholder="开始时间"
                                                   style="margin-left: 0px;width: 100px"
                                                    class="ace-icon fa fa-check-circle-o"/>
                                            <input type="text" value="至" style="width: 30px;" disabled="disabled"  >
                                            <input   type="text" autocomplete="off" data-date-format="yyyy-mm-dd"
                                                    name="nextBirthday" id="nextBirthday" placeholder="结束时间"
                                                    style="width: 100px;"
                                                     class="ace-icon fa fa-check-circle-o"/>
                                            </span>--%>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <a href="student/studentAdd.do" style="float: right" class="btn btn-sm btn-primary"><i class="ace-icon glyphicon glyphicon-plus"></i>新增</a>
                            </td>
                            <td><div >
                                <button style="margin-right: 100px;float: right" class="btn btn-sm btn-primary " onclick="searchBirthday();" type="button">
                                    <i class="ace-icon fa fa-check-circle-o"></i>
                                    <spring:message code="生日查询"/>
                                </button>
                            </div>
                            </td>
                        </tr>
                    </h1>
                    <br>

                </div><!-- /.page-header -->

                <div class="row">
                    <div class="col-xs-12">
                        <!-- PAGE CONTENT BEGINS -->
                        <div class="row">
                            <div class="col-xs-12">
                                <table id="simple-table" class="table  table-bordered table-hover">
                                    <thead>
                                        <%--列表信息---->thead--%>
                                    <tr>
                                        <th class="center">
                                            <label class="pos-rel">
                                                <input type="checkbox" class="ace" />
                                                <span class="lbl"></span>
                                            </label>
                                        </th>
                                        <th></th>
                                        <th class="hidden-480">序号</th>
                                        <th class="detail-col">学号</th>
                                        <th>姓名</th>
                                        <th>性别</th>
                                        <th class="hidden-480">出生日期</th>

                                        <th>
                                                <%--<i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>--%>
                                            所在班级
                                        </th>
                                        <th class="hidden-480">选修科目数</th>
                                        <th class="hidden-480">平均分</th>
                                        <th class="hidden-480">分数录入</th>
                                        <th class="hidden-480">选课</th>
                                        <th class="hidden-480">修改</th>
                                        <th class="hidden-480">删除</th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                        <%--列表信息---->tbody--%>
                                    <c:forEach items="${studentList}" var="students">
                                        <tr>
                                            <td class="center">
                                                <label class="pos-rel">
                                                    <input type="checkbox" class="ace" />
                                                    <span class="lbl"></span>
                                                </label>
                                            </td>
                                                <%--下拉列表信息--%>
                                            <td class="center">
                                                <div class="action-buttons">
                                                    <a href="#" class="green bigger-140 show-details-btn" title="Show Details">
                                                        <i class="ace-icon fa fa-angle-double-down"></i>
                                                        <span class="sr-only"></span>
                                                    </a>
                                                </div>
                                            </td>
                                            <td>${students.id}</td>
                                            <td>${students.code}</td>
                                            <td class="hidden-480">${students.name}</td>
                                            <td>${students.sex}</td>

                                            <td class="hidden-480">
                                                <fmt:formatDate value="${students.birthday}" type="date" pattern="yyyy-MM-dd"/>
                                                    <%--<span class="label label-sm label-warning">Expiring</span>--%>
                                            </td>
                                            <td>
                                                    ${students.grade.gradeName}
                                            </td>
                                            <td>
                                                <div class="hidden-sm hidden-xs btn-group">

                                                </div>
                                            </td>
                                            <td></td>
                                            <td>
                                                <div>
                                                    <button class="btn btn-xs btn-info">
                                                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                                                    </button>
                                                </div>
                                            </td>
                                            <td>
                                                <div>
                                                    <button class="btn btn-xs btn-info">
                                                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                                                    </button>
                                                </div>
                                            </td>
                                            <td>
                                                <div>
                                                    <button class="btn btn-xs btn-info">
                                                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                                                    </button>
                                                </div>
                                            </td>
                                            <td>
                                                <button class="btn btn-xs btn-danger" name="stuDel" onclick="dele(this)">
                                                    <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <%--下拉列表--%>
                                        <tr class="detail-row">
                                            <td colspan="8">
                                                <div class="table-detail">
                                                    <div class="row">
                                                        <div class="col-xs-12 col-sm-2">
                                                            <div class="text-center">
                                                                <img height="150" class="thumbnail inline no-margin-bottom" alt="Domain Owner's Avatar" src="assets/images/avatars/profile-pic.jpg" />
                                                                <br />
                                                                <div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
                                                                    <div class="inline position-relative">
                                                                        <a class="user-title-label" href="#">
                                                                            <i class="ace-icon fa fa-circle light-green"></i>
                                                                            &nbsp;
                                                                            <span class="white">Alex M. Doe</span>
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-xs-12 col-sm-7">
                                                            <div class="space visible-xs"></div>

                                                            <div class="profile-user-info profile-user-info-striped">
                                                                <div class="profile-info-row">
                                                                    <div class="profile-info-name"> Username </div>

                                                                    <div class="profile-info-value">
                                                                        <span>alexdoe</span>
                                                                    </div>
                                                                </div>

                                                                <div class="profile-info-row">
                                                                    <div class="profile-info-name"> Location </div>

                                                                    <div class="profile-info-value">
                                                                        <i class="fa fa-map-marker light-orange bigger-110"></i>
                                                                        <span>Netherlands, Amsterdam</span>
                                                                    </div>
                                                                </div>

                                                                <div class="profile-info-row">
                                                                    <div class="profile-info-name"> Age </div>

                                                                    <div class="profile-info-value">
                                                                        <span>38</span>
                                                                    </div>
                                                                </div>

                                                                <div class="profile-info-row">
                                                                    <div class="profile-info-name"> Joined </div>

                                                                    <div class="profile-info-value">
                                                                        <span>2010/06/20</span>
                                                                    </div>
                                                                </div>

                                                                <div class="profile-info-row">
                                                                    <div class="profile-info-name"> Last Online </div>

                                                                    <div class="profile-info-value">
                                                                        <span>3 hours ago</span>
                                                                    </div>
                                                                </div>

                                                                <div class="profile-info-row">
                                                                    <div class="profile-info-name"> About Me </div>

                                                                    <div class="profile-info-value">
                                                                        <span>Bio</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-xs-12 col-sm-3">
                                                            <div class="space visible-xs"></div>
                                                            <h4 class="header blue lighter less-margin">Send a message to Alex</h4>

                                                            <div class="space-6"></div>

                                                            <form>
                                                                <fieldset>
                                                                    <textarea class="width-100" resize="none" placeholder="Type something…"></textarea>
                                                                </fieldset>

                                                                <div class="hr hr-dotted"></div>

                                                                <div class="clearfix">
                                                                    <label class="pull-left">
                                                                        <input type="checkbox" class="ace" />
                                                                        <span class="lbl"> Email me a copy</span>
                                                                    </label>

                                                                    <button class="pull-right btn btn-sm btn-primary btn-white btn-round" type="button">
                                                                        Submit
                                                                        <i class="ace-icon fa fa-arrow-right icon-on-right bigger-110"></i>
                                                                    </button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <div style="float: right">
                                    <tr style="font-size: 30px;">
                                        <td style="margin-right: 50px">
                                            <input type="button" value="上一页" onclick="last()" style="font-size: 20px">
                                            <span style="font-size: 18px">
                                            总共${TotalPages}页，${TotalElements}条数据，当前第${currentPage+1}页，当前页面${NumberOfElements}条数据
                                            </span>
                                        </td>
                                        <input type="button" value="下一页" onclick="next()" style="font-size: 20px">
                                            <%--<span style="font-size: 18px">
                                            &nbsp;&nbsp;&nbsp;&nbsp;第&nbsp;
                                            </span>
                                            <input type="text" id="number" name="number" style="width: 35px">
                                            <span style="font-size: 18px">
                                            &nbsp;页
                                            </span>
                                            <a href="student/SearchCodePage.do?number=${number}" style="font-size: 18px">查找</a>--%>
                                    </tr>
                                </div>
                            </div><!-- /.span -->
                        </div><!-- /.row -->
                        <!-- PAGE CONTENT ENDS -->
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.page-content -->
        </div>
    </jsp:body>
</lesson:page>
</body>
</html>
