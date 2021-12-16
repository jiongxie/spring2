<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbShop.jsp</title>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<div class="container">
  <div class="w3-container w3-content w3-center w3-padding-64" style="max-width:800px" id="band">
    <h3 class="w3-wide" style="color:blue;"><a href="${contextPath }/study/dbshop/dbShop">Order</a></h3>
      <div class="w3-third">
        <p>
        	<c:if test="${slevel == 0 }">
	       		<a href="${contextPath }/study/dbshop/dbShopAd">◀</a>
        	</c:if>
        		상품구매
     		</p>
        <a href="${contextPath}/study/dbshop/dbShopList"><img src="${contextPath}/main/images/상품구매.png" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%"></a>
      </div>
      <div class="w3-third">
        <p>장바구니</p>
        <a href="${contextPath}/study/dbshop/dbCartList" ><img src="${contextPath}/main/images/장바구니.png" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%"></a>
      </div>
      <div class="w3-third">
        <p>주문확인
        	<c:if test="${slevel == 0 }">
        		<a href="${contextPath }/study/dbshop/dbShopAd">▶</a>
        	</c:if>
        </p>
        <a href="${contextPath}/study/dbshop/dbMyOrder" ><img src="${contextPath}/main/images/주문확인.png" class="w3-round" alt="Random Name" style="width:60%"></a>
      </div>
    </div>
  </div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>