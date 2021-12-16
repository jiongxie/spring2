<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>nList.jsp</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <%@ include file="/WEB-INF/views/include/bs.jsp" %>
  <script>
    $(document).ready(function() {
    	$(".popupSw").click(function() {
    		var popupCheck = $(this).is(":checked");
    		//if(popupCheck) popupSw = "Y";
    		//else popup = "N";
    		var popupSw = popupCheck ? "Y" : "N";
    		var idx = $(this).next().val();
    		var query = {
    				idx : idx,
    				popupSw : popupSw
    		};
    		
    		$.ajax({
    			url : "${contextPath}/notify/popupCheck",
    			type : "get",
    		  data : query,
    			success : function(data) {
    				if(popupSw == "Y") {
    					alert(data.idx+"("+data.sw+")번 공지사항이 초기화면에 팝업창으로 열립니다.");
    				}
    				else {
    					alert(data.idx+"("+data.sw+")번 공지사항은 초기화면에 팝업창에서 닫힙니다.");
    				}
    				//location.reload();
    				$("").load("${contextPath}/notify/nList");
    			},
    			error : function(data) {
    				alert("수행 실패!!!");
    			}
    		});  // ajax종료
    	});
    });
  
    function nDelCheck(idx) {
    	var ans = confirm("공지사항을 삭제하시겠습니까?");
    	if(!ans) return false;
    	var query = {idx : idx};
    	$.ajax({
    		url : "${contextPath}/notify/nDelete",
    		type : "get",
    		data : query,
    		success : function(data) {
    			if(data == 1) {
	    			alert("삭제 완료!");
	    			//location.reload();
	    			$("#notifyContent").load("${contextPath}/notify/nList #notifyContent");
    			}
    			else {
    				alert("삭제 실패~");
    			}
    		},
    		error : function(data) {
    			alert("서버 오류(삭제 실패)~");
    		}
    	});
    }
  </script>
  <style>
    
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<p><br/></p>
<div class="container">
  <table class="table table-borderless">
    <tr>
      <td align="center" colspan=2><font size=5><b>Notice</b></font></td>
    </tr>
    <tr>
      <td style="width:90%;border:0px;" class="tblr">
        <button type="button" class="btn btn-dark" onClick="location.href='${contextPath}/notify/nInput'">Input</button>
      </td>
    </tr>
  </table>
  <div id="notifyContent">
	  <form name="myform" method="get">
	    <ul>
	      <c:set var="num" value="${curScrNo}"/>
	      <c:forEach var="vo" items="${vos}">
	        <li><hr>
	          <span>
	            <div class="container mt-3">
	              <div class="d-flex justify-content-between mb-3">
	                <div class="p-2">
	                  <h5><b>[${vo.idx}.공지${num}] ${vo.title}</b></h5>&nbsp; &nbsp;
	                </div>
	                <div class="p-2">
	                  &nbsp; &nbsp;
	                  <button type="button" class="btn btn-dark" onclick="location.href='${contextPath}/notify/nUpdate?idx=${vo.idx}';">Update</button>
	                  <button type="button" class="btn btn-dark" onclick="nDelCheck('${vo.idx}')">Delete</button>
	                  <br/><br/>♬ 초기화면 표시 유뮤 :
	                  <input type="checkbox" name="popupSw" id="popupSw${num}" class="popupSw" <c:if test="${vo.popupSw eq 'Y'}"> checked </c:if> />
	                  <input type="hidden" name="idx" id="idx" value="${vo.idx}" />
	                </div>
	              </div>
	            </div>
	          </span>
	          <ul style="background-color:black;">
	            <a style="color:white;"><c:set var="content" value="${fn:replace(vo.content,newLine,'<br/>')}"/></a>
	            <li style="color:white;">${content}</li><br/>
	            <li style="color:white;">게시일 : ${fn:substring(vo.startDate,0,10)} ~ ${fn:substring(vo.endDate,0,10)}</li>
	          </ul>
	        </li>
	        <c:set var="num" value="${num-1}"/>
	      </c:forEach>
	    </ul>
	  </form>
  </div>
</div>
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>