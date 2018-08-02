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
<lesson:page title="">
    <jsp:attribute name="script">
        <script type="application/javascript">
            function searchId() {
                window.location.href = "student/SearchCode.do?code=" + $('#userCode').val();
            }

            function searchName() {
                window.location.href = "student/SearchName.do?name=" + $('#userName').val();
            }

            function searchBirthday() {
                alert("查询范围：" + $('#lastBirthday').val() + "——" + $('#nextBirthday').val());
                window.location.href = "student/SearchBirthday.do?lastBirthday=" + $('#lastBirthday').val() + "&nextBirthday=" + $('#nextBirthday').val();
            }

            $(function () {
                $("#lastBirthday").datepicker({
                    changeMonth: true,
                    changeYear: true
                });
                $("#nextBirthday").datepicker({
                    changeMonth: true,
                    changeYear: true
                });

            });

            function dele(stuDel) {
                var tds = stuDel.parentElement.parentElement.children;
                var id = (tds[2]).innerHTML;
                if (confirm("确认删除吗")) {
                    //alert("yes");
                    alert("确定删除id为: " + id + "的用户？");
                    window.location.href = "student/studentDel.do?id=" + id;
                }
                else {
                    //alert("no")
                    return;
                }
            }

            jQuery(function ($) {
                //datepicker plugin
                //link
                $('.date-picker').datepicker({
                    autoclose: true,
                    todayHighlight: true
                })
                //show datepicker when clicking on the icon
                    .next().on(ace.click_event, function () {
                    $(this).prev().focus();
                });

                //or change it into a date range picker
                $('.input-daterange').datepicker({autoclose: true});


                //to translate the daterange picker, please copy the "examples/daterange-fr.js" contents here before initialization
                $('input[name=date-range-picker]').daterangepicker({
                    'applyClass': 'btn-sm btn-success',
                    'cancelClass': 'btn-sm btn-default',
                    locale: {
                        applyLabel: 'Apply',
                        cancelLabel: 'Cancel',
                    }
                })
                    .prev().on(ace.click_event, function () {
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
                }).on('focus', function () {
                    $('#timepicker1').timepicker('showWidget');
                }).next().on(ace.click_event, function () {
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

                    <li class="active"><spring:message code="student.title.list"/></li>
                </ul>
            </div>
            <div class="page-content">
                <div class="page-header">

                    <h1>
                            <%--根据条件查询--%>
                        <tr>
                            <td>
                                <a href="manage/student/studentAdd.do" style="float: right"
                                   class="btn btn-sm btn-primary"><i
                                        class="ace-icon glyphicon glyphicon-plus"></i>新增</a>
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

                                        <th class="hidden-480">序号</th>
                                        <th class="hidden-480">学科名称</th>
                                        <th class="hidden-480">选修人数</th>
                                        <th></th>
                                        <th class="hidden-480">平均分</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <%--列表信息---->tbody--%>
                                    <c:set var="index" value="0"/>
                                    <c:forEach items="${sublist}" var="sub" varStatus="num">
                                        <c:set var="index" value="${index+1}"/>
                                        <td>${index}</td>
                                        <td>${sublist[num.count-1]}</td>
                                        <td>${numlist[num.count-1]}</td>
                                        <%--下拉列表信息--%>
                                        <td class="center">
                                            <div class="action-buttons">
                                                <a href="#" class="green bigger-140 show-details-btn"
                                                   title="Show Details">
                                                    <i class="ace-icon fa fa-angle-double-down"></i>
                                                    <span class="sr-only"></span>
                                                </a>
                                            </div>
                                        </td>
                                        <td>平均分</td>
                                        </tr>
                                        <%--下拉列表--%>
                                        <tr class="detail-row">
                                            <td colspan="8">
                                                <div class="table-detail">
                                                    <div class="row">
                                                        <div class="col-xs-12 col-sm-2">
                                                            <div class="text-center">
                                                                <img height="150"
                                                                     class="thumbnail inline no-margin-bottom"
                                                                     alt="Domain Owner's Avatar"
                                                                     src="static-resource/ace/assets/images/avatars/profile-pic.jpg"/>
                                                                <br/>
                                                                <div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
                                                                    <div class="inline position-relative">
                                                                        <a class="user-title-label" href="#">
                                                                            <i class="ace-icon fa fa-circle light-green"></i>
                                                                            &nbsp;
                                                                            <span class="white">${students.name}</span>
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-xs-12 col-sm-7">
                                                            <div class="space visible-xs"></div>

                                                            <div class="profile-user-info profile-user-info-striped">
                                                                <div class="profile-info-row">
                                                                    <div class="profile-info-name">姓名</div>

                                                                    <div class="profile-info-value">
                                                                        <span>${students.name}</span>
                                                                    </div>
                                                                </div>

                                                                <div class="profile-info-row">
                                                                    <div class="profile-info-name">居住地</div>

                                                                    <div class="profile-info-value">
                                                                        <i class="fa fa-map-marker light-orange bigger-110"></i>
                                                                        <span>成都</span>
                                                                    </div>
                                                                </div>

                                                                <div class="profile-info-row">
                                                                    <div class="profile-info-name">出生日期</div>

                                                                    <div class="profile-info-value">
                                                                        <span>${students.birthday}</span>
                                                                    </div>
                                                                </div>

                                                                <div class="profile-info-row">
                                                                    <div class="profile-info-name">性别</div>

                                                                    <div class="profile-info-value">
                                                                        <span>${students.sex}</span>
                                                                    </div>
                                                                </div>

                                                                <div class="profile-info-row">
                                                                    <div class="profile-info-name"> 班级</div>

                                                                    <div class="profile-info-value">
                                                                        <span>${students.grade.gradeName}</span>
                                                                    </div>
                                                                </div>

                                                                <div class="profile-info-row">
                                                                    <div class="profile-info-name"> 爱好</div>

                                                                    <div class="profile-info-value">
                                                                        <span>打篮球</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div><!-- /.span -->
                        </div><!-- /.row -->
                        <!-- PAGE CONTENT ENDS -->
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.page-content -->
        </div>
    </jsp:body>
</lesson:page>
