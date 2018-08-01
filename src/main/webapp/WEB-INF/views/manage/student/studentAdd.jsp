<%--
  Created by IntelliJ IDEA.
  User: 23577
  Date: 2018/7/29
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="lesson" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<lesson:page title="">
    <jsp:body>
        <div class="breadcrumbs ace-save-state" id="breadcrumbs">
            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="welcome.do"><spring:message code="common.homepage"/></a>
                </li>

                <li class="active">学生管理系统<%--<spring:message code="role.title.list"/>--%></li>
                <li class="active">学生管理<%--<spring:message code="role.title.list"/>--%></li>
            </ul>
        </div>
        <div class="page-content">

            <div class="row">
                <div class="col-xs-12">
                    <!-- PAGE CONTENT BEGINS -->
                    <div class="row">
                        <div class="col-xs-12">
                            <h3 class="header smaller lighter blue">
                                <spring:message code="增加学生"/>
                                <span class="hidden-sm hidden-xs btn-group pull-right">
                                <a href="javascript:history.go(-1)" class="btn btn-sm btn-primary"><i
                                        class="ace-icon fa fa-angle-left"></i>
                                    <spring:message code="返回"/>
                                </a>
                            </span>
                            </h3>

                            <form action="student/doStudentAdd.do" method="post" class="form-horizontal" role="form"
                                  id="admin-add-form">

                                <%--用户名不能为空--%>
                                <%--<input type="hidden" value="${cmd}" id="cmd"/>
                                <input   type="hidden" id="logo" name="logo" value="${admin.logo}">--%>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" >
                                        <spring:message code="姓名"/>
                                    </label>

                                    <div class="col-sm-3" minlength="100" maxlength="200">
                                            <input  type="text" autocomplete="off" id="name"
                                                    name="name"
                                                    value=""
                                                    maxlength="100" class=" form-control"/>

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" >
                                        <spring:message code="学号"/>
                                    </label>

                                    <div class="col-sm-3">
                                        <input type="text" autocomplete="off" id="code" name="code" maxlength="240" value="" class=" form-control"/>
                                    </div>

                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" >
                                        <spring:message code="生日"/>
                                    </label>

                                    <div class="col-sm-3">
                                        <input type="date" data-date-format="yyyy-mm-dd" autocomplete="off" id="birthday" name="birthday"  maxlength="240" class=" form-control"/>
                                    </div>

                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" >
                                        <spring:message code="班级"/>
                                    </label>

                                    <div class="col-sm-3">
                                        <input type="text" autocomplete="off" id="grade" name="grade" maxlength="400"
                                               value="" class=" form-control"/>
                                    </div>

                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" >
                                        <spring:message code="选课"/>
                                    </label>

                                    <div class="col-sm-3">
                                        <input type="text" autocomplete="off" id="subject" name="subject" maxlength="240" class=" form-control">
                                    </div>

                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" >
                                        <spring:message code="user.gender"/>
                                    </label>
                                    <div class="col-sm-3">
                                        <label class="checkbox-inline">
                                            <input type="radio" name="sex" value="M"
                                                   <c:if test="${admin.gender=='M'}">checked</c:if>/>&nbsp;
                                            &nbsp;<spring:message
                                                code="sex.male"/>
                                        </label>
                                        &nbsp; &nbsp; &nbsp;&nbsp;
                                        <label class="checkbox-inline">
                                            <input type="radio" name="sex" value="F"
                                                   <c:if test="${admin.gender=='F'}">checked</c:if>/>&nbsp;
                                            &nbsp;<spring:message
                                                code="sex.female"/>
                                        </label>
                                    </div>
                                </div>


                                <sec:authorize ifAnyGranted="OPT_USER_ADD,OPT_USER_EDIT">
                                    <div class="clearfix form-actions">
                                        <div class="text-center">
                                            <button id="confirm" class="btn btn-info" type="submit" >
                                                <i class="ace-icon fa fa-check bigger-110"></i>
                                                <spring:message code="button.submit"/>
                                            </button>

                                        </div>
                                    </div>
                                </sec:authorize>

                            </form>
                        </div><!-- /.span -->
                    </div><!-- /.row -->

                    <!-- PAGE CONTENT ENDS -->
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div>
    </jsp:body>
</lesson:page>

