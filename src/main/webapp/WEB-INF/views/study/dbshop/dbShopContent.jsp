<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbShopContent.jsp(상품정보 상세보기)</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <link rel="stylesheet" href="${contextPath}/resources/css/product.css?after">
  <script>
    var idxArray = new Array();
  
    $(function(){
    	$("#selectOption").change(function(){
    		var selectOption = $(this).val();
    		var idx = selectOption.substring(0,selectOption.indexOf(":")); // 옵션의 고유번호
    		var optionName = selectOption.substring(selectOption.indexOf(":")+1,selectOption.indexOf("_")); // 옵션명
    		var optionPrice = selectOption.substring(selectOption.indexOf("_")+1); // 옵션가격
    		var commaPrice = numberWithCommas(optionPrice);
    		
    		if($("#layer"+idx).length == 0 && selectOption != "") {
    		  idxArray[idx] = idx;
    		  
	    		var str = "";
	    		
	    		str += "<div class='layer' id='layer"+idx+"'>"+optionName+"&nbsp;&nbsp;";
	    		str += "<input type='number' class='numBox' id='numBox"+idx+"' name='optionNum' onchange='numChange("+idx+")' min='1' max='2' value='1'/>.0(Version) &nbsp;";
	    		str += "<input type='text' id='imsiPrice"+idx+"' class='price' value='"+commaPrice+"' readonly/>";
	    		str += "<input type='hidden' id='price"+idx+"' class='price' value='"+optionPrice+"'/>";
	    		str += "<div class='removebtn'><input type='button' class='btn btn-dark btn-sm removebtn' onclick='remove("+idx+")' value='삭제'/></div><br/><br/>";
	    		str += "<input type='hidden' name='statePrice' id='statePrice"+idx+"' value='"+optionPrice+"'/>";
	    		str += "<input type='hidden' name='optionIdx' value='"+idx+"'/>";
	    		str += "<input type='hidden' name='optionName' value='"+optionName+"'/>";
	    		str += "<input type='hidden' name='optionPrice' value='"+optionPrice+"'/>";
	    		str += "</div>";
	    		$("#product1").append(str);
	    		onTotal();
    	  }
    	  else if(selectOption == "") {
    		  alert("옵션을 선택해주세요.");
    	  }
    	  else {
    		  alert("이미 선택한 옵션입니다.");
    	  }
    	});
    });
    
    // 등록(추가)시킨 옵션 상품 삭제하기
    function remove(idx) {
  	  $("div").remove("#layer"+idx);
  	  onTotal();
    }
    
    // 상품의 총 금액 (재)계산하기
    function onTotal() {
  	  var total = 0;
  	  for(var i=0; i<idxArray.length; i++) {
  		  if($("#layer"+idxArray[i]).length != 0) {
  		  	total +=  parseInt(document.getElementById("price"+idxArray[i]).value);
  		  	document.getElementById("totalPriceResult").value = total;
  		  }
  	  }
  	  document.getElementById("totalPrice").value = numberWithCommas(total);
    }
    
    // 수량 변경시 처리하는 함수
    function numChange(idx) {
    	var price = document.getElementById("statePrice"+idx).value * document.getElementById("numBox"+idx).value;
    	document.getElementById("imsiPrice"+idx).value = numberWithCommas(price);
    	document.getElementById("price"+idx).value = price;
    	onTotal();
    }
    
    // 장바구니 호출시 수행함수
    function cart(mid) {
    	if(mid == "") {
    		alert("로그인 후 이용 가능합니다.");
    		location.href = "${contextPath}/member/mLogin";
    	}
    	else if(document.getElementById("totalPrice").value=="" || document.getElementById("totalPrice").value==0) {
    		alert("옵션을 선택해주세요");
    		return false;
    	}
    	else {
    		var ans = confirm("장바구니로 이동하시겠습니까?");
    		if(ans) {
    			document.myform.sw.value = "cart";
    		}
    		else {
    			return false;
    		}
    		document.myform.submit();
    	}
    }
    
    // 직접 주문하기
    function order(mid) {
    	if(mid == "") {
    		alert("로그인 후 이용 가능합니다.");
    		location.href = "${contextPath}/member/mLogin";
    	}
    	else if(document.getElementById("totalPrice").value=="" || document.getElementById("totalPrice").value==0) {
    		alert("옵션을 선택해주세요");
    		return false;
    	}
    	else {
  			/* document.myform.sw.value = "order"; */
  			document.myform.action = "${contextPath}/study/dbshop/dbShopOrder"
    		document.myform.submit();
    	}
    }
    
    
    // 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<p><br/></p>
<div class="container">
  <!-- 상품이미지 -->
  <div id="Thumbnail">
    <img src="${contextPath}/resources/study/${productVo.rfname}" width="100%"/>
  </div>
  <!-- 상품 기본정보 -->
  <div id="iteminfor">
    <h3>${productVo.product}</h3>
    <h3><fmt:formatNumber value="${productVo.mainprice}"/>원</h3>
    <p>${productVo.detail}</p>
  </div>
  <!-- 상품주문을 위한 옵션정보 출력 -->
  <div class="form-group select_box">
    <form>  <!-- 옵션의 정보를 보여주기위한 form -->
      <select size="1" class="form-control" id="selectOption">
        <option value=""  selected>상품옵션선택</option>
        <option value="0:기본품목_${productVo.mainprice}">기본품목</option>
        <c:forEach var="vo" items="${optionVos}">
          <option value="${vo.idx}:${vo.optionName}_${vo.optionPrice}">${vo.optionName}</option>
        </c:forEach>
      </select>
    </form>
  </div>
  <form name="myform" method="post">  <!-- 실제 상품의 정보를 넘겨주기 위한 form -->
    <input type="hidden" name="mid" value="${smid}"/>
    <input type="hidden" name="productIdx" value="${productVo.idx}"/>
    <input type="hidden" name="product" value="${productVo.product}"/>
    <input type="hidden" name="mainPrice" value="${productVo.mainprice}"/>
    <input type="hidden" name="thumbImg" value="${productVo.rfname}"/>
    <input type="hidden" name="totalPrice" id="totalPriceResult"/>
    <input type="hidden" name="sw"/>
    <div id="product1"></div>
  </form>
  <!-- 상품의 총가격(옵션포함가격) 출력처리 -->
  <div class="product2">
    <hr color="black" size="3px"/>
    <font size="4" color="black">총상품금액</font>
    <p align="right">
      <font size="6" color="orange">
        <b><input type="text" class="totalPrice" id="totalPrice" value="<fmt:formatNumber value='0'/>" readonly/></b>
      </font>
    </p>
  </div>
  <!-- 장바구니보기/주문하기/계속쇼핑하기 처리 -->
  <div class="buttongroup">
    <button class="btn btn-dark" onclick="cart('${smid}')">장바구니</button> &nbsp;
    <button class="btn btn-dark" onclick="order()">주문하기</button> &nbsp;
    <button class="btn btn-dark" onclick="location.href='${contextPath}/study/dbshop/dbShopList';">계속쇼핑하기</button>
  </div>
  <br/><br/>
  <!-- 상품 상세설명 보여주기 -->
  <div id="content" class="container tab-pane active"><br/>
    <div class="next">
      ${productVo.content}
    </div>
  </div>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>