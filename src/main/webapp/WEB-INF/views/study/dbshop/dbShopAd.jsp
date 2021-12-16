<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbShopAd.jsp</title>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<div class="container">
<c:if test="${slevel == 0 }">
  <%-- <p>[<a href="${contextPath }/study/goods">분류등록(대/중/소)</a>] - 작업중 -</p> --%>
    <!-- The Band Section -->
  <div class="w3-container w3-content w3-center w3-padding-64" style="max-width:800px" id="band">
    <h3 class="w3-wide" style="color:blue;">Order Administration</h3>
      <div class="w3-third">
        <p>
        	<a href="${contextPath }/study/dbshop/dbShop">◀</a>상품등록
        </p>
        <a href="${contextPath}/study/dbshop/dbProduct"><img src="${contextPath}/main/images/상품등록.png" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%"></a>
      </div>
      <div class="w3-third">
        <p>옵션등록</p>
        <a href="${contextPath}/study/dbshop/dbOption" ><img src="${contextPath}/main/images/옵션등록.png" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%"></a>
      </div>
      <div class="w3-third">
        <p>주문접수확인<a href="${contextPath }/study/dbshop/dbShop">▶</a></p>
        <a href="${contextPath}/study/dbshop/dbJumunProcess" target="content"><img src="${contextPath}/main/images/주문접수확인.png" class="w3-round" alt="Random Name" style="width:60%"></a>
      </div>
    </div>
  </div>
</c:if>  
  
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>