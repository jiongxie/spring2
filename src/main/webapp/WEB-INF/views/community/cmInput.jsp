<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>cmInput.jsp</title>
	<script>
	function fCheck() {
			var title = myform.title.value;
			var name = myform.name.value;
			var pwd = myform.pwd.value;
			
			if(title == "") {
				alert("제목을 입력해 주세요");
				myform.title.focus();
			}
			else if(name == "") {
				alert("이름을 입력해 주세요");
				myform.name.focus();
			}
			else if(pwd == "") {
				alert("비밀번호를 입력해 주세요");
				myform.pwd.focus();
			}
			else {
				myform.submit();
			}
	 }	
	</script>
	<style>
		.btn btn-dark {
			text-align:center;
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav2.jsp" %>
<%@ include file="/WEB-INF/views/include/slide3.jsp" %>
<div class="container">
	<p></br></p><p></br></p><p></br></p>	
	<div>
		<h2 style="text-align:center;">Input</h2>
	</div>
	<form name='myform' method="post">
		<table class='table table-borderless'>
			<tr>
				<th>title</th>
				<td><input type="text" name="title"/></td>
			</tr>
			<tr>
				<th>Name</th>
				<td><input type="text" name="name"/></td>
			</tr>
			<tr>
				<th>Password</th>
				<td><input type="password" name="pwd"/></td>
			</tr>
		</table>
			<div ">
				<input type="button" class="btn btn-dark" value="Input" onclick="fCheck()"/>
				<input type="reset" class="btn btn-dark" value="Reset"/>
				<input type="button" class="btn btn-dark" value="Community" onclick="location.href='${contextPath}/community/cmList';"/>
			</div>
	</form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>