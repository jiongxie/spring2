<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Pure alpha community</title>
	<script>
	  function popupCheck() {
		  <c:forEach var="popup" items="${popupVos}"> /* main컨트롤러에서 popupSw가 'Y'인 자료만 보내준다. */
		  	var url = "${contextPath}/notify/popup?idx=${popup.idx}";
		  	openPopup(url,${popup.idx});
		  </c:forEach>
	  }
	  
	  var xPos = 0;
	  function openPopup(url,idx) {
		  xPos += 100;
		  var cookieCheck = getCookie("popupYN"+idx);
		  if(cookieCheck != "N") {
		  	window.open(url,"","width=400,height=600,left="+xPos+",top=5");
		  }
	  }
	  
	  function getCookie(name) {
		  var cookie = document.cookie;  // 클라이언트에 저장된 쿠키의 정보를 읽어(가져)온다.
		  if(cookie != "") {
			  var cookieArray = cookie.split("; ");
			  for(var index in cookieArray) {
				  var cookieName = cookieArray[index].split("=");
				  if(cookieName[0] == name) {
					  return cookieName[1];
				  }
			  }
		  }
		  return;
	  }
	</script>
	<style>
		body {font-family: "Lato", sans-serif}
		.mySlides {display: none}
	</style>
<body onload="javascript:popupCheck()">


<!-- Navbar -->


<!-- Page content -->
<div class="w3-content" style="max-width:2000px;">

  <!-- Automatic Slideshow Images -->
  <%@ include file="/WEB-INF/views/include/slide3.jsp" %>

  

  <!-- The Tour Section -->
  <div class="w3-black" id="tour">
    <div class="w3-container w3-content w3-padding-64" style="max-width:800px">
      <h2 class="w3-wide w3-center">Pure alpha community</h2>
      <p class="w3-opacity w3-center"><i>Powered by Brian, w3school</i></p><br>
      <div class="w3-row-padding w3-padding-32" style="margin:0 -16px">
        
        <div class="w3-third w3-margin-bottom">
          <a href="http://218.236.203.78:9090/cj200805/" ><img src="${contextPath}/main/images/image-02.jpg" alt="New York" style="width:100%" class="w3-hover-opacity"></a>
          <div class="w3-container w3-white">
            <p><b>All weather investment</b></p>
            <p class="w3-opacity"></p>
            <p></p>
          </div>
        </div>
        <div class="w3-third w3-margin-bottom">
          <a href='${contextPath }/community/cmList'><img src="${contextPath}/main/images/p2.jpg" alt="Paris" style="width:100%" class="w3-hover-opacity"></a>
          <div class="w3-container w3-white">
            <p><b>종목토론방</b></p>
            <p class="w3-opacity"></p>
            <p></p>
          </div>
        </div>
        <div class="w3-third w3-margin-bottom">
          <a href="${contextPath }/h" ><img src="${contextPath}/main/images/image-04.jpg" alt="San Francisco" style="width:100%" class="w3-hover-opacity"></a>
          <div class="w3-container w3-white">
            <p><b>Robostock.com</b></p>
            <p class="w3-opacity"></p>
            <p></p>
          </div>
        </div>
        
      </div>
    </div>
  </div>




<%-- 

  <!-- The Band Section -->
  <div class="w3-container w3-content w3-center w3-padding-64" style="max-width:800px" id="band">
    <h2 class="w3-wide">관련사이트</h2>
      <div class="w3-third">
        <p>All weather investment</p>
        <a href="http://218.236.203.78:9090/cj200805/" ><img src="${contextPath}/main/images/image-02.jpg" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%"></a>
      </div>
      <div class="w3-third">
        <p>Pure alpha community</p>
        <a href="" ><img src="${contextPath}/main/images/image-03.jpg" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%"></a>
      </div>
      <div class="w3-third">
        <p>Robostock.com</p>
        <a href="${contextPath }/" ><img src="${contextPath}/main/images/image-04.jpg" class="w3-round" alt="Random Name" style="width:60%"></a>
      </div>
    </div>
  </div>

 --%>
<%--  
 
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

 --%>
</body>
</html>