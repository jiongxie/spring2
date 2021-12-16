<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>goods.jsp</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script>
    $(function() {
    	// 대분류 선택시 수행
    	$("#product1").change(function() {
    		var product1 = $(this).val();
    		var query = {product1 : product1};
    		$.ajax({
    			url  : "${contextPath}/study/goods1",
    			type : "post",
    			data : query,
    			success : function(data) {
    				var str = "";
    				str += "<option value=''>중분류</option>";
    				for(var i=0; i<data.length; i++) {
    					str += "<option>"+data[i].product2+"</option>";
    				}
    				$("#product2").html(str);
    			}
    		});
    	});
    });
    
    $(function() {
    	// 중분류 선택시 수행
    	$("#product2").change(function() {
    		var product1 = $("#product1").val();
    		var product2 = $(this).val();
    		var query = {
    				product1 : product1,
    				product2 : product2
    		};
    		$.ajax({
    			url  : "${contextPath}/study/goods2",
    			type : "post",
    			data : query,
    			success : function(data) {
    				var str = "";
    				str += "<option value=''>소분류</option>";
    				for(var i=0; i<data.length; i++) {
    					str += "<option>"+data[i].product3+"</option>";
    				}
    				$("#product3").html(str);
    			}
    		});
    	});
    });
    
    function fCheck() {
    	var product1 = $("#product1").val();
    	var product2 = $("#product2").val();
    	var product3 = $("#product3").val();
    	if(product1=="" || product2=="" || product3=="") {
    		alert("대/중/소 분류를 선택하세요.");
    	}
    	else {
    		alert("선택하신 대/중/소 는? " + product1 + "/" + product2 + "/" + product3);
    	}
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<div class="container">
  <h2>상품관리</h2>
  <form method="post">
    <select id="product1">
      <option value="">대분류</option>
      <c:forEach var="vo" items="${vos}">
        <option>${vo.product1}</option>
      </c:forEach>
    </select> - 
    <select id="product2">
      <option value="">중분류</option>
    </select> -
    <select id="product3">
      <option value="">소분류</option>
    </select> &nbsp;
    <input type="button" value="선택" onclick="fCheck()"/>
  </form>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>