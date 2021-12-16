<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbOption.jsp(상품의 옵션 등록)</title>
  <script>
    var cnt = 1;
    
    // 옵션항목 추가
    function addOption() {
    	var strOption = "";
    	var test = "t" + cnt; 
    	
    	strOption += '<div id="'+test+'"><hr size="5px"/>';
    	strOption += '<font size="5"><b>상품옵션등록</b></font>&nbsp;&nbsp;';
    	strOption += '<div class="form-group">';
    	strOption += '<input type="button" value="옵션삭제" id="btn'+test+'" class="btn btn-outline-dark btn-sm" onclick="removeOption('+test+')"/><br/>'
    	strOption += '<label for="optionName">상품옵션이름</label>&nbsp : &nbsp';
    	strOption += '<input type="text" name="optionName" id="optionName'+cnt+'" class="form-control"/>';
    	strOption += '</div>';
    	strOption += '<div class="form-group">';
    	strOption += '<label for="optionPrice">상품옵션가격</label>&nbsp : &nbsp';
    	strOption += '<input type="text" name="optionPrice" id="optionPrice'+cnt+'" class="form-control"/>';
    	strOption += '</div>';
    	strOption += '</div>';
    	$("#optionType").append(strOption);
    	cnt++;
    }
    
    // 옵션항목 삭제
    function removeOption(test) {
    	$("#"+test.id).remove();
    }
    
    // 옵션체크후 등록전송
    function fCheck() {
    	for(var i=1; i<=cnt; i++) {
    		if($("#t"+i).length != 0 && document.getElementById("optionName"+i).value=="") {
    			alert("빈칸 없이 상품 옵션명을 모두 등록하셔야 합니다");
    			return false;
    		}
    		else if($("#t"+i).length != 0 && document.getElementById("optionPrice"+i).value=="") {
    			alert("빈칸 없이 상품 옵션가격을 모두 등록하셔야 합니다");
    			return false;
    		}
    	}
    	if(document.getElementById("optionName").value=="") {
    		alert("상품 옵션이름을 등록하세요");
    		return false;
    	}
    	else if(document.getElementById("optionPrice").value=="") {
    		alert("상품 옵션가격을 등록하세요");
    		return false;
    	}
    	else {
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
	<div style="text-align:center;">
  	<h3 style="color:blue;"><a href="${contextPath }/study/dbshop/dbProduct">◀</a><a href="${contextPath }/study/dbshop/dbShopAd">Option</a><a href="${contextPath }/study/dbshop/dbJumunProcess">▶</a></h3>
  </div>
<div class="container">
  <form name="myform" method="post">
    <div class="form-group">
      <label for="product">상품명</label>
      <select name="product" class="form-control">
        <c:forEach var="product" items="${productName}">
          <option value="${product}">${product}</option>
        </c:forEach>
      </select>
    </div>
    <font size="5"><b>상품옵션등록</b></font>&nbsp;&nbsp;
    <input type="button" value="옵션추가" onclick="addOption()" class="btn btn-secondary btn-sm"/><br/>
    <div class="form-group">
      <label for="optionName">상품옵션이름</label>
      <input type="text" name="optionName" id="optionName" class="form-control"/>
    </div>
    <div class="form-group">
      <label for="optionPrice">상품옵션가격</label>
      <input type="text" name="optionPrice" id="optionPrice" class="form-control"/>
    </div>
    <div id="optionType"></div>
    <input type="button" value="옵션등록" onclick="fCheck()" class="btn btn-dark"/>
    <input type="button" value="돌아가기" onclick="location.href='${contextPath}/study/dbshop/dbShopAd';" class="btn btn-dark"/>
  </form>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>