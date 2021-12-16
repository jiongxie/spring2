<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<html>
<head>
  <title>dbCartList.jsp(장바구니)</title>
  <script type="text/javascript" src="//code.jquery.com/jquery-3.1.1.js"></script> 
  <link rel="stylesheet" href="${contextPath}/resources/css/cart.css?after">
  <script>
    function onTotal(){
      var total = 0;
      var maxIdx = document.getElementById("maxIdx").value;
      for(var i=1;i<=maxIdx;i++){
        if($("#totalPrice"+i).length != 0 && document.getElementById("idx"+i).checked){  
          total = total + parseInt(document.getElementById("totalPrice"+i).value); 
        }
      }
      document.getElementById("total").value=numberWithCommas(total);
      
      if(total>=25000||total==0){
        document.getElementById("baesong").value=0;
      } else {
        document.getElementById("baesong").value=1000;
      }
      var lastPrice=parseInt(document.getElementById("baesong").value)+total;
      document.getElementById("lastPrice").value = numberWithCommas(lastPrice);  // 화면에 보여주는 주문 총금액
      document.getElementById("orderTotalPrice").value = numberWithCommas(lastPrice);  // 값을 넘겨주는 '주문 총 금액 필드'
    }
    
    function onCheck(){
      var maxIdx = document.getElementById("maxIdx").value;

      var cnt=0;
      for(var i=1;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked==false){
          cnt++;
          break;
        }
      }
      if(cnt!=0){
        document.getElementById("allcheck").checked=false;
      } 
      else {
        document.getElementById("allcheck").checked=true;
      }
      onTotal();
    }
    
    function allCheck(){
      var maxIdx = document.getElementById("maxIdx").value;
      if(document.getElementById("allcheck").checked){
        for(var i=1;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=true;
          }
        }
      }
      else {
        for(var i=1;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=false;
          }
        }
      }
      onTotal();
    }
    
    function cartDel(idx){
    	if(!document.getElementById("idx"+idx).checked) {
    		alert("삭제하실 상품을 선택하세요.")
    		return false;
    	}
      var ans = confirm("선택하신 상품을 장바구니에서 삭제하시겠습니까?");
      if(!ans){
        return false;
      }
      
      var data = { "idx" : idx};
      $.ajax({
        url : "${contextPath}/study/dbshop/dbCartDel",
        type : "get",
        data : data,
        success : function(data) {
          location.reload();
        }
      });
    }
    
    function order(){
      //구매하기위해 체크한 장바구니에만 아이디가 check인 필드의 값을 1로 셋팅. 체크하지 않은것은 check아이디필드의 기본값은 0이다.
      var maxIdx = document.getElementById("maxIdx").value;
      for(var i=1;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked){
          document.getElementById("checkItem"+i).value="1";
        }
      }
      //배송비넘기기
      //document.myform.baesong.value=document.getElementById("baesong").value;
      
      if(document.getElementById("lastPrice").value==0){
        alert("장바구니에서 상품을 선택해주세요!");
        return false;
      } 
      else {
	      //document.myform.action="${contextPath}/study/dbshop/dbOrder";
        document.myform.submit();
      }
    }
    
    // 천단위마다 쉼표 표시하는 함수
    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<p><br/></p>
<div class="container">
<div class="head"><h3 style="color:blue;"><a href="${contextPath }/study/dbshop/dbShopList">◀</a><a href="${contextPath }/study/dbshop/dbShop">Cart List</a><a href="${contextPath }/study/dbshop/dbMyOrder">▶</a></h3></div>
<form name="myform" method="post">
<table class="list table-bordered">
 <thead>
  <tr class="tablehead" style="background-color:black;">
    <td><input type="checkbox" id="allcheck" onClick="allCheck()"/><a style="color:white;">전체</a></td>
    <td colspan="2" style="color:white;">상품</td>
    <td colspan="2" style="color:white;">총상품금액</td>
  </tr>
  </thead>
    
  <!-- 장바구니 목록출력 -->
  <c:set var="maxIdx" value="0"/>
  <c:forEach var="listVo" items="${listVos}">
    <tbody>
    <tr align="center">
      <td><input type="checkbox" name="idxChecked" id="idx${listVo.idx}" value="${listVo.idx}" onClick="onCheck()" /></td>
      <td><img src="${contextPath}/resources/study/${listVo.thumbImg}" class="thumb"/></td>
      <td align="left">
        <p><br/>모델명 : <span style="color:orange;font-weight:bold;">${listVo.product}</span><br/> &nbsp; &nbsp; <fmt:formatNumber value="${listVo.mainPrice}"/>원</p><br/>
        <c:set var="optionNames" value="${fn:split(listVo.optionName,',')}"/>
        <c:set var="optionPrices" value="${fn:split(listVo.optionPrice,',')}"/>
        <c:set var="optionNums" value="${fn:split(listVo.optionNum,',')}"/>
        <p>
          <%-- <c:set var="optionNames" value="${fn:length(optionNames)}"/>-${optionNames} --%>
          - 주문 내역
          <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
            &nbsp; &nbsp; ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}.0(Version)<br/>
          </c:forEach> 
        </p>
      </td>
      <td>
        <b>총 : <fmt:formatNumber value="${listVo.totalPrice}" pattern='#,###원'/></b><br/><br/>
        <span style="font-size:10pt;color:#690;">구매일자 : ${fn:substring(listVo.cartDate,0,10)}</span>
        <input type="hidden" id="totalPrice${listVo.idx}" value="${listVo.totalPrice}"/>
      </td>
      <td>
        <input type="button" class="btn btn-dark btn-sm" value="삭제" onClick="cartDel(${listVo.idx})"/>
        <input type="hidden" name="checkItem" value="0" id="checkItem${listVo.idx}"/>
        <input type="hidden" name="idx" value="${listVo.idx }"/>
        <input type="hidden" name="thumbImg" value="${listVo.thumbImg}"/>
        <input type="hidden" name="product" value="${listVo.product}"/>
        <input type="hidden" name="mainPrice" value="${listVo.mainPrice}"/>
        <input type="hidden" name="optionName" value="${optionNames}"/>
        <input type="hidden" name="optionPrice" value="${optionPrices}"/>
        <input type="hidden" name="optionNum" value="${optionNums}"/>
        <input type="hidden" name="totalPrice" value="${listVo.totalPrice}"/>
        <input type="hidden" name="mid" value="${smid}"/>
      </td>
    </tr>
    </tbody>
    <c:set var="maxIdx" value="${listVo.idx}"/>
  </c:forEach>
  <!-- <input type="hidden" name="post" value="0" /> -->
</table>
  <input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
  <input type="hidden" name="orderTotalPrice"/>
</form>
<p><br/></p>
<div align="center">
  <b>실제 주문 총 금액</b>(구매하실 상품에 체크해 주세요. 총 주문금액이 산출됩니다.)
</div>
<div class="last">
  <div class="inline">
    <span class="ft">상품금액</span><br/>
    <span class="inputFont"><input type="text" id="total" class="box" value="0" readonly/></span>
  </div>
  <div class="inline">
    <p style="font-size:25px;font-weight:bold;"> + </p>
  </div>  
  <div class="inline">
    <span class="ft">수수료</span><br/>
    <span class="inputFont"><input type="text" id="baesong" class="box" value="0" readonly/></span>
  </div>
  <div class="inline">
    <p style="font-size:25px;font-weight:bold;"> = </p>
  </div>    
  <div class="inline ll">
    <span class="ft">총주문금액</span><br/>
    <span class="inputFont"><input type="text" id="lastPrice" class="box" value="0" readonly/></span>
  </div>
</div>
<p><br/></p>
<div align="center">
  <button class="btn btn-dark btn-lg" onClick="order()">구매하기</button>
  <button class="btn btn-dark btn-lg" onClick="location.href='${contextPath}/study/dbshop/dbShopList';">계속 쇼핑하기</button>
</div>

</div>
<p><br/><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>