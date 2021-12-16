<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>cmContent.jsp</title>
	<script>
		function delComCheck() {
			var pwd = myform.pwd.value;
			
			if(pwd == ""){
				alert("비밀번호를 입력해주세요.");								
			}
			else {
				location.href = "${contextPath}/community/cmNDelete?idx=${vo.idx}&pwd="+pwd;
			}
			
		}
	</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav2.jsp" %>
<%@ include file="/WEB-INF/views/include/slide3.jsp" %>
<p></br></p><p></br></p><p></br></p>
<div class="container">
	<div>
		<h2 style="text-align:cetner;">Content</h2>
	</div>
	<form name="myform" method="post" action="${contextPath }/community/cmUpdate">
		<table class="table table-borderless">
			<tr>
				<td>Title</td>
				<td><input type="text" name="title" value="${vo.title }"/></td>
			</tr>
			<tr>
				<td>Name</td>
				<td><input type="text" name="name" value="${vo.name }"/></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name='pwd'/><td>
			</tr>
		</table>
		<input type="button" class="btn btn-dark" value="Update" onclick="location.href='${contextPath}/community/cmUpdate?idx=${vo.idx }';"/>
		<input type="button" class="btn btn-dark" value="Delete" onclick="delComCheck()"/>
		<input type="button" class="btn btn-dark" value="community" onclick="location.href='${contextPath}/community/cmList';"/>
	</form>
</div>
</body>
</html>