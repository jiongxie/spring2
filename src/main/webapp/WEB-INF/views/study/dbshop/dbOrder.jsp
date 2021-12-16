<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="EUC-KR">
  <title>dbOrder.jsp</title>
  <script type="text/javascript" src="//code.jquery.com/jquery-3.1.1.js"></script> 
  <link rel="stylesheet" href="${contextPath}/resources/css/cart.css?after">
  <script>
	  $(document).ready(function(){
		  $(".nav-tabs a").click(function(){
		    $(this).tab('show');
		  });
		  $('.nav-tabs a').on('shown.bs.tab', function(event){
		    var x = $(event.target).text();         // active tab
		    var y = $(event.relatedTarget).text();  // previous tab
		  });
		});
  
    function order() {
    	var ans = confirm("결재하시겠습니까?");
    	if(ans) {
	    	myform.action = "${contextPath}/study/dbshop/orderInput";
	    	myform.submit();
    	}
    }
  </script>
  <style>
  	.tablehead {
  		background-color:black;
  	}
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<p><br/></p>
<div class="container">
	<div class="head"><h2>주문 / 결제</h2></div>
	<p><br/></p> 
	
	<table class="list table-bordered">
	 <thead>
	  <tr class="tablehead">
	    <td colspan="2" style="color:white;">상품</td>
	    <td style="color:white;">총상품금액</td>
	  </tr>
	  </thead>
	    
	  <!-- 주문서 목록출력 -->
	  <c:set var="orderTotalPrice" value="0"/>
	  <c:forEach var="vo" items="${orderVos}">
	    <tbody>
	    <tr align="center">
	      <td><img src="${contextPath}/resources/study/${vo.thumbImg}" class="thumb"/></td>
	      <td align="left">
	        <p><br/>주문번호 : ${orderIdx}</p>
	        <p><br/>모델명 : <span style="color:orange;font-weight:bold;">${vo.product}</span><br/> &nbsp; &nbsp; <fmt:formatNumber value="${vo.mainPrice}"/>원</p><br/>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p>
	          - 주문 옵션 내역 : 총 ${fn:length(optionNames)}개<br/>
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	            &nbsp; &nbsp; ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}.0(Version)<br/>
	          </c:forEach> 
	        </p>
	      </td>
	      <td>
	        <b>총 : <fmt:formatNumber value="${vo.totalPrice}" pattern='#,###원'/></b><br/><br/>
	      </td>
	    </tr>
	    </tbody>
		  <%-- <input type="hidden" name="cartIdx" value="${idx}"/> --%>
	    <c:set var="orderTotalPrice" value="${orderTotalPrice + vo.totalPrice}"/>
	  </c:forEach>
	</table>
	<div>
	  <div style="width:100%; background-color:#eee;text-align:center;">
	    <span class="ft">총 주문(결재) 금액 : </span> 
	    <span class="inputFont"><fmt:formatNumber value="${orderTotalPrice}" pattern='#,###원'/></span>
	  </div>
	</div>
	<p><br/></p>
	<form name="myform" method="post" action="${contextPath}/study/dbshop/dbOrderInput">
		<div class="head"><h2>배송지 정보 / 결재수단</h2></div>
		<p>이름 : <input type="text" name="name" value="${memberVo.name}"/></p>
		<p>주소 : <input type="text" name="address" value="${memberVo.address}"/></p>
		<p>연락처 : <input type="text" name="tel" value="${memberVo.tel}"/></p>
		<p>배송시 요청사항 : <input type="text" name="message"/></p>
		<hr/>
		
	  <!-- Nav tabs -->
		<ul class="nav nav-tabs" role="tablist">
      <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#card">카드결재</a></li>
	    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#bank">은행결재</a></li>
	    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#telCheck">상담사연결</a></li>
	  </ul>
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div id="card" class="container tab-pane active"><br>
	      <h3>카드결재</h3>
	      <p>
	        <select name="payment">
	          <option value="국민">국민</option>
	          <option value="현대">현대</option>
	          <option value="신한">신한</option>
	          <option value="농협">농협</option>
	          <option value="BC">BC</option>
	          <option value="롯데">롯데</option>
	          <option value="삼성">삼성</option>
	          <option value="LG">LG</option>
	        </select>
	      </p>
				<p>카드번호 : <input type="text" name="payMethod"/></p>
	    </div>
	    <div id="bank" class="container tab-pane fade"><br>
	      <h3>은행결재</h3>
	      <p>
	        <select name="payMethod">
	          <option value="국민">국민(111-111-111)</option>
	          <option value="신한">신한(222-222-222)</option>
	          <option value="우리">우리(333-333-333)</option>
	          <option value="농협">농협(444-444-444)</option>
	          <option value="신협">신협(555-555-555)</option>
	        </select>
	      </p>
				<p>입금자명 : <input type="text" name="payMethod"/></p>
	    </div>
	    <div id="telCheck" class="container tab-pane fade"><br>
	      <h3>전화상담</h3>
	      <p>콜센터(☎) : 02-234-1234</p>
	    </div>
	  </div>
		<hr/>
		<div align="center">
		  <button type="button" class="btn btn-dark btn-lg" onClick="order()">결제하기</button>
		  <%-- <button class="btn btn-secondary btn-lg" onClick="location.href='${contextPath}/study/dbshop/dbShopList';">계속 쇼핑하기</button> --%>
		  <a href="${contextPath}/study/dbshop/dbShopList" class="btn btn-dark btn-lg">계속쇼핑하기</a>
		</div>
		<input type="hidden" name="orderVos" value="${orderVos}"/>
	  <input type="hidden" name="orderIdx" value="${orderIdx}"/>
	  <input type="hidden" name="orderTotalPrice" value="${orderTotalPrice}"/>
	  <input type="hidden" name="mid" value="${smid}"/>
	</form>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>