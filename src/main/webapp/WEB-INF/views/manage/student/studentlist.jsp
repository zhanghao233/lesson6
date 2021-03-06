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
                                <div class="col-sm-3">
                                    <div class="input-group" style="width: 80%">
                                        <input type="text" autocomplete="off"
                                               name="userCode" id="userCode"
                                               maxlength="20" value="${code}"
                                               class="required form-control"/>
                                        <span class="input-group-btn" style="margin-left: auto">
                                             <button class="btn btn-sm btn-primary " onclick="searchId();"
                                                     type="button">
                                                 <i class="ace-icon fa fa-check-circle-o"></i>
                                                 <spring:message code="学号"/>
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
                                             <button class="btn btn-sm btn-primary " onclick="searchName();"
                                                     type="button">
                                                 <i class="ace-icon fa fa-check-circle-o"></i>
                                                 <spring:message code="姓名"/>
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
                                                    <input type="text" class="input-sm form-control"
                                                           data-date-format="yyyy-mm-dd" style="width: 100px;"
                                                           name="lastBirthday" id="lastBirthday" placeholder="开始时间"
                                                           value="${lastBirthday}"/>
                                                    <span class="input-group-addon">
																		<i class="fa fa-exchange"></i>
																	</span>
                                                    <input type="text" class="input-sm form-control"
                                                           data-date-format="yyyy-mm-dd" style="width: 100px;"
                                                           name="nextBirthday" id="nextBirthday" placeholder="结束时间"
                                                           value="${nextBirthday}"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <a href="manage/student/studentAdd.do" style="float: right"
                                   class="btn btn-sm btn-primary"><i
                                        class="ace-icon glyphicon glyphicon-plus"></i>新增</a>
                            </td>
                            <td>

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
                                                <input type="checkbox" class="ace"/>
                                                <span class="lbl"></span>
                                            </label>
                                        </th>
                                        <th></th>
                                        <th class="hidden-480">序号</th>
                                        <th class="hidden-480">学号</th>
                                        <th class="hidden-480">姓名</th>
                                        <th class="hidden-480">性别</th>
                                        <th class="hidden-480">出生日期</th>
                                        <th class="hidden-480">所在班级</th>
                                        <th class="hidden-480">选修科目数</th>
                                        <th class="hidden-480">平均分</th>
                                        <th class="hidden-480">分数录入</th>
                                        <th class="hidden-480">选课</th>
                                        <th class="hidden-480">修改、删除</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <%--列表信息---->tbody--%>
                                    <c:forEach items="${studentList}" var="students">
                                        <tr>
                                            <td class="center">
                                                <label class="pos-rel">
                                                    <input type="checkbox" class="ace"/>
                                                    <span class="lbl"></span>
                                                </label>
                                            </td>
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
                                            <td>${students.id}</td>
                                            <td>${students.code}</td>
                                            <td class="hidden-480">${students.name}</td>
                                            <td>${students.sex}</td>
                                            <td class="hidden-480">
                                                <fmt:formatDate value="${students.birthday}" type="date"
                                                                pattern="yyyy-MM-dd"/>
                                                    <%--<span class="label label-sm label-warning">Expiring</span>--%>
                                            </td>
                                            <td>${students.grade.gradeName}</td>
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
                                                    <a href="manage/student/studentDel.do?id=${students.id}">
                                                    <button class="btn btn-xs btn-danger" name="stuDel"
                                                            onclick="return confirm('您确定要删除【${students.name}】吗？')">
                                                        <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                                    </button></a>
                                                </div>
                                            </td>

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
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="dataTables_info" id="dynamic-table_info" role="status"
                                             aria-live="polite">第 ${Number+1} 页，有${NumberOfElements}条
                                            ，总共${TotalElements}条
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="dataTables_paginate paging_simple_numbers"
                                             id="dynamic-table_paginate">
                                            <ul class="pagination">
                                                <c:choose>
                                                    <c:when test="${Number<1}">
                                                        <li class="paginate_button previous disabled"
                                                            aria-controls="dynamic-table" tabindex="0"
                                                            id="dynamic-table_previous"><a
                                                                href="manage/student/studentlistPage.do?Number=${Number-1}">上一页</a>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="paginate_button previous"
                                                            aria-controls="dynamic-table" tabindex="0"
                                                            id="dynamic-table_previous"><a
                                                                href="manage/student/studentlistPage.do?Number=${Number-1}">上一页</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${Number<1}">
                                                        <li class="paginate_button active" aria-controls="dynamic-table" tabindex="0">
                                                            <a href="manage/student/studentlistPage.do?Number=${Number}">${Number+1}</a></li>
                                                        <li class="paginate_button" aria-controls="dynamic-table" tabindex="0">
                                                            <a href="manage/student/studentlistPage.do?Number=${Number+1}">${Number+2}</a></li>
                                                        <li class="paginate_button" aria-controls="dynamic-table" tabindex="0">
                                                            <a href="manage/student/studentlistPage.do?Number=${Number+2}">${Number+3}</a></li>
                                                    </c:when>
                                                    <c:when test="${Number+2>TotalPages}">
                                                        <li class="paginate_button" aria-controls="dynamic-table" tabindex="0">
                                                            <a href="manage/student/studentlistPage.do?Number=${Number-2}">${Number-1}</a></li>
                                                        <li class="paginate_button" aria-controls="dynamic-table" tabindex="0">
                                                            <a href="manage/student/studentlistPage.do?Number=${Number-1}">${Number}</a></li>
                                                        <li class="paginate_button active " aria-controls="dynamic-table" tabindex="0">
                                                            <a href="manage/student/studentlistPage.do?Number=${Number}">${Number+1}</a></li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="paginate_button" aria-controls="dynamic-table" tabindex="0">
                                                            <a href="manage/student/studentlistPage.do?Number=${Number-1}">${Number}</a></li>
                                                        <li class="paginate_button active " aria-controls="dynamic-table" tabindex="0">
                                                            <a href="manage/student/studentlistPage.do?Number=${Number}">${Number+1}</a></li>
                                                        <li class="paginate_button " aria-controls="dynamic-table" tabindex="0">
                                                            <a href="manage/student/studentlistPage.do?Number=${Number+1}">${Number+2}</a></li>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${Number+2>TotalPages}">
                                                        <li class="paginate_button next disabled" aria-controls="dynamic-table"
                                                            tabindex="0" id="dynamic-table_next"><a
                                                                href="manage/student/studentlistPage.do?Number=${Number+1}">下一页</a>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="paginate_button next" aria-controls="dynamic-table"
                                                            tabindex="0" id="dynamic-table_next"><a
                                                                href="manage/student/studentlistPage.do?Number=${Number+1}">下一页</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>

                                            </ul>
                                        </div>
                                    </div>
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
