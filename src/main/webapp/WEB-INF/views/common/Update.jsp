<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" 
	uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改页面</title>
</head>
<body>
<form action="Update" method="post" style="border: 1px;margin-left: 200px;margin-top: 100px">
学号:<input type="text" value="${user.id}" id="id" name="id"><br>
姓名:<input type="text" value="${user.name}" id="name" name="name"><br>
日期:<input type="text" value="<fmt:formatDate value="${user.date}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>" name="date"/><br>
描述:<input type="text" value="${user.description}" id="description" name="description"><br>
均分:<input type="text" value="${user.avgscore}" id="avgscore" name="avgscore"><br>
<input type="submit" value="提交">
</form>
</body>
</html>