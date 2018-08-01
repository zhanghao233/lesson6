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

                        <tr>
                            <td>
                                <a href="manage/student/studentAdd.do" style="float: right" class="btn btn-sm btn-primary"><i
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
                                        <th class="center">
                                            <label class="pos-rel">
                                                <input type="checkbox" class="ace"/>
                                                <span class="lbl"></span>
                                            </label>
                                        </th>
                                        <th></th>
                                        <th class="hidden-480">序号</th>
                                        <th class="hidden-480">班级名</th>
                                        <th class="hidden-480">人数</th>
                                        <th class="hidden-480">平均分</th>
                                        <th class="hidden-480">修改、删除</th>

                                    </tr>
                                    </thead>
                                    <tbody>
                                        <%--列表信息---->tbody--%>
                                    <c:forEach items="${gradeList}" var="gradeList">
                                        <tr>
                                            <td class="center">
                                                <label class="pos-rel">
                                                    <input type="checkbox" class="ace"/>
                                                    <span class="lbl"></span>
                                                </label>
                                            </td>
                                            <td class="center">
                                                <div class="action-buttons">
                                                    <a href="#" class="green bigger-140 show-details-btn"
                                                       title="Show Details">
                                                        <i class="ace-icon fa fa-angle-double-down"></i>
                                                        <span class="sr-only"></span>
                                                    </a>
                                                </div>
                                            </td>
                                            <td>${gradeList.id}</td>
                                            <td>${gradeList.name}</td>
                                            <td></td>
                                            <td></td>
                                            <td>
                                                <div>
                                                    <button class="btn btn-xs btn-info">
                                                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                                                    </button>
                                                <button class="btn btn-xs btn-danger" name="stuDel"
                                                        onclick="dele(this)">
                                                    <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                                </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="dataTables_info" id="dynamic-table_info" role="status"
                                             aria-live="polite">第 ${Number+1} 页 ，共${TotalElements}条
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="dataTables_paginate paging_simple_numbers"
                                             id="dynamic-table_paginate">
                                            <ul class="pagination">
                                                <li class="paginate_button previous disabled"
                                                    aria-controls="dynamic-table" tabindex="0"
                                                    id="dynamic-table_previous"><a href="student/studentMessagePage.do?Number=${Number-1}">上一页</a></li>
                                                <li class="paginate_button" aria-controls="dynamic-table"
                                                    tabindex="0"><a href="student/studentMessagePage.do?Number=${Number-1}">${Number-1}</a></li>
                                                <li class="paginate_button active " aria-controls="dynamic-table" tabindex="0">
                                                    <a href="#">${Number}</a></li>
                                                <li class="paginate_button " aria-controls="dynamic-table" tabindex="0">
                                                    <a href="student/studentMessagePage.do?Number=${Number+1}">${Number+1}</a></li>
                                                <li class="paginate_button next" aria-controls="dynamic-table"
                                                    tabindex="0" id="dynamic-table_next"><a href="student/studentMessagePage.do?Number=${Number+1}">下一页</a></li>
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
