<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 
           	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" 
			uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生信息页</title>

<script type="text/javascript">
function del(oncl){
    var tds = oncl.parentElement.parentElement.children;
    var id = (tds[1]).innerHTML;
    alert("确定删除id值: " + id+"的用户？");
    window.location.href="dele?id="+id;
}
function sub(btn){
    var tds = btn.parentElement.parentElement.children;
    var id = (tds[1]).innerHTML;
    alert("确定修改id值: " + id+"的用户？");
    window.location.href="modify?id="+id;
    /* $.ajax({
		type:"POST",
		data:{
            td:td
        }, 
        data:JSON.stringify({
			td:td,
		}),
		url:'${pageContext.request.contextPath}/modify',
		dataType:'json',
		contentType:'application/json;charset=UTF-8',
		success:function(result){
			 alert("提交成功！");
		}
	}); */
}
</script>
<style type="text/css">
table {
	margin:center;
	margin-left:100px;
	margin-top:20px;
	width: 1000px;
	height: 500px;	
	border-right: 1px solid #804040;
	border-bottom: 1px solid #804040;
	border-collapse:collapse;
}

table td {
text-align:center;
height:15px;
border-left: 1px solid #804040;
border-top: 1px solid #804040;

}
</style>
</head>
<body>
<form action="modify" >
学生信息----<br>
<table border="1px" width="100%">
<tr>
<td colspan="10" align="center">学生列表</td>
<td colspan="2"><input type="button" onclick="window.location.href='add.jsp'" value="新增" style="float: right;width: 100%;height: 100%"></td>
</tr>
<c:forEach items="${ulist}" var="user">
<tr>
<td style="width:5%">学号:</td>
<td style="width:10%;">${user.id}</td>
<td style="width:5%">姓名:</td>
<td style="width:10%">${user.name}</td>
<td style="width:5%">日期:</td>
<td style="width:20%"><fmt:formatDate value="${user.date}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
<td style="width:5%">描述:</td>
<td style="width:15%">${user.description}</td>
<td style="width:5%">均分:</td>
<td style="width:10%">${user.avgscore}</td>
<td><input type="button" name='btn' onclick="sub(this)" value="修改" style="width: 100%;height: 100%"></td>
<td><input type="button" name="oncl" onclick="del(this)" value="删除" style="width: 100%;height: 100%"></td>
</tr>
</c:forEach>
</table>
<a href="${pageContext.request.contextPath}/milu/paging?currentPage=${currentPage-1}">上一页</a>
当前第${currentPage+1}页，共${total}页
<a href="${pageContext.request.contextPath}/milu/paging?currentPage=${currentPage+1}">下一页</a>
</form>
</body>
</html>