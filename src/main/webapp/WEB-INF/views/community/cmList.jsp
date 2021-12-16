<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>cmList</title>
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	  <script>
	  	function cmDelte(idx) {
	  		var ans = confirm("해당 글을 삭제 할까요?");
	  		if(!ans) {
	  			return false;
	  		}
	  		var query = {idx : idx}
	  		$.ajax({
		  		url : "${contextPath}/community/cmDelete",
		  		type : "get",
		  		data : query,
		  		success: function(data) {
		  			if(data == 1 ){
		  				location.reload();
		  			}
		  		}
		  	});
	  	}
	  	
	  	
	  
	  		
	  </script>
	<style>
		.a {
			text-align:center;
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav2.jsp" %>
<%@ include file="/WEB-INF/views/include/slide3.jsp" %>
<div class="container">
<p><br/></br></p>

    <div style="text-align:center">
        <h2>종목토론방</h2><br/>
		    <button class="btn btn-primary">
				  <span class="spinner-border spinner-border-sm"></span><a href="${contextPath }/community/cmInput">Input</a>
				</button>
						    <!-- Center-aligned -->
				<ul class="pagination justify-content-center" style="margin:20px 0">
				  <li class="page-item"><a class="page-link" href="#">Previous</a></li>
				  <li class="page-item"><a class="page-link" href="#">1</a></li>
				  <li class="page-item"><a class="page-link" href="#">2</a></li>
				  <li class="page-item"><a class="page-link" href="#">3</a></li>
				  <li class="page-item"><a class="page-link" href="#">Next</a></li>
				</ul>

    </div>
<table class="table table-borderless">
    <tr style="text-align:center;">
      <th>Number</th>
      <th>Title</th>
      <th>Name</th>
      <th>Admin</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
	    <tr>
	      <td class="a">${vo.idx}</td>
	      <td class="a">
	        <a href="${contextPath}/community/cmContent?idx=${vo.idx}">${vo.title}</a>
	      </td>
	      <td class="a">${vo.name}</td>
	      <c:if test="${cmid == 'admin' }">
	      	<td class="a"><a href="javascript:cmDelte(${vo.idx })">X</a></td>
	      </c:if>
	    </tr>
    </c:forEach>
</table>

		<!-- Button to Open the Modal -->
<c:if test="${cmid != 'admin' }"> 
  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
		AdminLogin
  </button>
</c:if> 
<c:if test="${cmid == 'admin' }">
  <a href="${contextPath }/cmember/cmLogOut"><button type="button" class="btn btn-primary" data-toggle="modal" >AdminLogOut</button></a>
</c:if> 

  <!-- The Modal -->
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Admin Login</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
			<form method="post" action="${contextPath }/cmember/cmLogin">  
        <div class="modal-body">
        	<table>
						<tr>
							<th>Login</th>
							<td><input type="text" name="mid" required placeholder="아이디입력"/></td>
						</tr>
						<tr>
							<th>Password</th>
							<td><input type="password" name="pwd" required placeholder="비밀번호입력"/></td>
						</tr>
					</table>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger" >Login</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
		</form>
        
      </div>
    </div>
  </div>

</div>
</body>
</html>