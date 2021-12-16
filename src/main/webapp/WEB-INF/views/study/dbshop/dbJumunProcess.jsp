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
    $(document).ready(function() {
	    document.getElementById("startJumun").value = new Date().toISOString().substring(0,10);
	    document.getElementById("endJumun").value = new Date().toISOString().substring(0,10);
    });
  
    function nWin(orderIdx) {
    	var url = "${contextPath}/study/dbshop/dbOrderBaesong?orderIdx="+orderIdx;
    	window.open(url,"dbOrderBaesong","width=350px,height=400px");
    }
    
    $(document).ready(function() {
    	$("#orderStatus").change(function() {
	  /*   	var startJumun = document.getElementById("startJumun").value;
	    	var endJumun = document.getElementById("endJumun").value; */
	    	var orderStatus = $(this).val();
	    	location.href="${contextPath}/study/dbshop/adminOrderStatus?orderStatus="+orderStatus;
    	});
    });
    
    function changeMsg() {
    	alert("변경처리 버튼을 클릭하세요.");
    }
    
    function orderProcess(orderIdx) {
    	var goodsStatus = document.getElementById("goodsStatus"+orderIdx).value;
  		var query = {
  				goodsStatus : goodsStatus,
  				orderIdx : orderIdx
  		};
  		$.ajax({
  			url   : "${contextPath}/study/dbshop/goodsStatus",
  			type  : "get",
  			data  : query,
  			success : function(data) {
  				location.reload();
  			}
    	});
    }
    
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<%@ include file="/WEB-INF/views/include/bs.jsp" %>
<c:set var="orderStatus" value="${orderStatus}"/>
<%-- <c:if test="${orderStatus eq ''}"><c:set var="orderStatus" value="전체"/></c:if> --%>
<div style="text-align:center;">
 	<h3 style="color:blue;"><a href="${contextPath }/study/dbshop/dbOption">◀</a><a href="${contextPath }/study/dbshop/dbShopAd">Order Administration</a><a href="${contextPath }/study/dbshop/dbProduct">▶</a></h3>
 </div>
<div class="container">
  <hr/>
  <table class="table table-borderless">
    <tr>
      <td align="right">주문상태조회 :
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
    <tr style="text-align:center;background-color:black;">
      <th style="color:white;">주문정보</th>
      <th style="color:white;">상품</th>
      <th style="color:white;">주문내역</th>
      <th style="color:white;">주문일시</th>
    </tr>
    <c:forEach var="vo" items="${myOrderVos}">
      <tr>
        <td style="text-align:center;">
          <p>주문번호 : ${vo.orderIdx}</p>
          <p>총 주문액 : <fmt:formatNumber value="${vo.totalPrice}"/>원</p>
          <p><input type="button" value="배송지정보" class="btn btn-dark" onclick="nWin('${vo.orderIdx}')"></p>
        </td>
        <td style="text-align:center;"><br/><img src="${contextPath}/resources/study/${vo.thumbImg}" class="thumb" width="100px"/></td>
        <td align="left">
	        <p>모델명 : <span style="color:orange;font-weight:bold;">${vo.product}</span><br/> &nbsp; &nbsp; <fmt:formatNumber value="${vo.mainPrice}"/>원</p>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p>
	          - 주문 내역
	          <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	            &nbsp; &nbsp; ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}.0(Version)<br/>
	          </c:forEach>
	        </p>
	      </td>
        <td style="text-align:center;"><br/>
          <form name="myform">
	          주문일자 : ${fn:substring(vo.orderDate,0,10)}<br/><br/>
	          <select name="goodsStatus" id="goodsStatus${vo.orderIdx}" onchange="changeMsg()">
		          <option value="결제완료" ${vo.orderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
		          <option value="배송중"  ${vo.orderStatus == '배송중' ? 'selected' : ''}>배송중</option>
		          <option value="배송완료"  ${vo.orderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
		          <option value="구매완료"  ${vo.orderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
		          <option value="반품처리"  ${vo.orderStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
	          </select><br/>
	          <input type="button" class="btn btn-dark" value="변경처리" onclick="orderProcess('${vo.orderIdx}')"/>
	        </form>
        </td>
      </tr>
    </c:forEach>
  </table>
  <hr/>
<p><br/></p>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>