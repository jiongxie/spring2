<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>bUpdate.jsp</title>
  <script src="${contextPath}/resources/ckeditor/ckeditor.js"></script>
  <script>
    function fCheck() {
    	var name = myform.name.value;
    	var title = myform.title.value;
    /* 
    	var email = myform.email.value;
    	var homepage = myform.homepage.value;
     */	
    	var pwd = myform.pwd.value;
    	
    	if(name == "") {
    		alert("이름을 입력하세요.");
    		myform.name.focus();
    	}
    	else if(title == "") {
    		alert("게시글 제목을 입력하세요.");
    		myform.title.focus();
    	}
    	else if(pwd == "") {
    		alert("비밀번호를 입력하세요.");
    		myform.pwd.focus();
    	}
    	else {
    		myform.oriContent.value = document.getElementById("oriContent").innerHTML;
    		myform.submit();
    	}
    }
  </script>
  <style>
    table, h2 {
      width: 80%;
      margin: 0 auto;
    }
    th, td {
      padding : 10px;
      border : 1px solid #ccc;
    }
    th {
      background-color : gray;
    }
    .tblH {
      text-align: center;
    }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="${contextPath}/board/boardUpd">
    <div style="text-align:center;">
      <tr>
        <td class="tblH" style="border:none;"><h2>Board</h2></td>
      </tr>
    </div>
    <table>
      <tr>
        <th class="tblH" style="background-color:black;"><a style="color:white;">글쓴이</a></th>
        <td><input type="text" name="name" value="${vo.name}"/></td>
      </tr>
      <tr>
        <th class="tblH" style="background-color:black;"><a style="color:white;">글제목</a></th>
        <td><input type="text" name="title" value="${vo.title}"/></td>
      </tr>
      <%-- 
      <tr>
        <th class="tblH">이메일</th>
        <td><input type="text" name="email" value="${vo.email}"/></td></td>
      </tr>
      <tr>
        <th class="tblH">홈페이지</th>
        <td><input type="text" name="homepage" value="${vo.homepage}"/></td></td>
      </tr>
       --%>
      <tr>
        <th class="tblH" style="background-color:black;"><a style="color:white;">글내용</a></th>
        <td><textarea rows="5" name="content" id="CKEDITOR" required>${vo.content}</textarea></td>
        <script>
			    CKEDITOR.replace("content",{
			    	uploadUrl:"${contextPath}/imageUpload",     /* 그림파일 드래그&드롭 처리 */
			    	filebrowserUploadUrl: "${contextPath}/imageUpload",  /* 이미지 업로드 */
			    	height:400
			    });
			  </script>
      </tr>
      <tr>
        <th style="background-color:black;"><a style="color:white;">비밀번호</a></th>
        <td><input type="password" name="pwd" value="${vo.pwd}"/></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="button" class="btn btn-dark" value="Update" onclick="fCheck()"/>
          <input type="reset" class="btn btn-dark" value="Reset"/>
          <input type="button" class="btn btn-dark" value="Board" onclick="location.href='${contextPath}/board/bList?pag=${pageVo.pag}&pageSize=${pageVo.pageSize}';"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="hostip" value="<%=request.getRemoteAddr()%>"/>
    <input type="hidden" name="mid" value="${smid}"/>
    <input type="hidden" name="idx" value="${vo.idx}"/>
    <input type="hidden" name="oriContent"/>
    <input type="hidden" name="pag" value="${pag}"/>
    <input type="hidden" name="pageSize" value="${pageSize}"/>
    <div id="oriContent" style="display:none;">${vo.content}</div>
  </form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>