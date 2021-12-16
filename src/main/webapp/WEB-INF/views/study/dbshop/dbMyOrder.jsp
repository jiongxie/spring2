<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbMyOrder.jsp(회원 주문확인)</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script>
    function nWin(orderIdx) {
    	var url = "${contextPath}/study/dbshop/dbOrderBaesong?orderIdx="+orderIdx;
    	window.open(url,"dbOrderBaesong","width=350px,height=400px");
    }
    /* 
    $(document).ready(function() {
    	$("#orderStatus").change(function() {
	    	var orderStatus = $(this).val();
    		var query = {orderStatus : orderStatus};
    		$.ajax({
    			url   : "${contextPath}/study/dbshop/orderStatus",
    			type  : "get",
    			data  : query,
    			success : function(data) {
    				location.reload();
    			}
    		});
    	});
    });
     */
    $(document).ready(function() {
    	$("#orderStatus").change(function() {
	    	var orderStatus = $(this).val();
	    	location.href="${contextPath}/study/dbshop/orderStatus?orderStatus="+orderStatus;
    	});
    });
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<c:set var="orderStatus" value="${orderStatus}"/>
<%-- <c:if test="${orderStatus eq ''}"><c:set var="orderStatus" value="전체"/></c:if> --%>
<div style="text-align:center;">
  <h3 style="color:blue;"><a href="${contextPath }/study/dbshop/dbCartList">◀</a><a href="${contextPath }/study/dbshop/dbShop">MyOrder</a><a href="${contextPath }/study/dbshop/dbShopList">▶</a></h3>
</div>  
<div class="container">
  <table class="table table-borderless">
    <tr>
      <td style="float:right;">주문상태조회 : 
        <select name="orderStatus" id="orderStatus">
          <option value="전체" ${orderStatus == '전체' ? 'selected' : ''}>전체</option>
          <option value="결제완료" ${orderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
          <option value="배송중"  ${orderStatus == '배송중' ? 'selected' : ''}>배송중</option>
          <option value="배송완료"  ${orderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
          <option value="구매완료"  ${orderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
          <option value="반품처리"  ${orderStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
        </select>
      </td>
    </tr>
  </table>
  <table class="table table-hover">
    <tr style="text-align:center;background-color:#ccc;">
      <th>주문정보</th>
      <th>상품</th>
      <th>주문내역</th>
      <th>주문일시</th>
    </tr>
    <c:forEach var="vo" items="${myOrderVos}">
      <tr>
        <td style="text-align:center;">
          <p>주문번호 : ${vo.orderIdx}</p>
          <%-- <p>총 주문액 : <fmt:formatNumber value="vo.totalPrice"/>원</p> --%>
          <p>총 주문액 : <fmt:formatNumber value="${vo.totalPrice}"/>원</p>
          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
        </td>
        <td style="text-align:center;"><br/><img src="${contextPath}/resources/study/${vo.thumbImg}" class="thumb" width="100px"/></td>
        <td align="left">
	        <p><br/>모델명 : <span style="color:orange;font-weight:bold;">${vo.product}</span><br/> &nbsp; &nbsp; <fmt:formatNumber value="${vo.mainPrice}"/>원</p><br/>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p>
	          - 주문 내역
	          <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	            &nbsp; &nbsp; ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
	          </c:forEach>
	        </p>
	      </td>
        <td style="text-align:center;"><br/>
          주문일자 : ${fn:substring(vo.orderDate,0,10)}<br/><br/>
          <font color="brown">${vo.orderStatus}</font><br/>
          <c:if test="${vo.orderStatus eq '결제완료'}">(배송준비중)</c:if>
        </td>
      </tr>
    </c:forEach>
  </table>
  <hr/>
  <p><a href="${contextPath}/study/dbshop/dbShopList" class="btn btn-secondary btn-lg">계속쇼핑하기</a></p>
  <hr/>
<p><br/></p>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>