
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
                                        <th class="hidden-480">序号</th>
                                        <th class="hidden-480">班级名</th>
                                        <th class="hidden-480">人数</th>
                                        <th></th>
                                        <th class="hidden-480">平均分</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <%--列表信息---->tbody--%>
                                    <%--@elvariable id="gradenameList" type="java.util.List"--%>
                                        <c:set var="index" value="0" />
                                        <c:forEach items="${gradenameList}" var="gradename" varStatus="list">
                                        <tr>
                                            <c:set var="index" value="${index+1}" />
                                            <td>${index}</td>
                                            <td>${gradenameList[list.count-1]}</td>
                                            <td>${(integerList[list.count-1])+1}</td>
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
