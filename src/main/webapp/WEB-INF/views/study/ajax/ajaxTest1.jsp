<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajaxTest1.jsp</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script>
    /* $(document).ready(function() {}); */
    $(function() {
    	$("#do").change(function() {
    		//var dodo = myform.do.value;
    		var dodo = $(this).val();
    		var query = {
    				dodo : dodo,
    		};
    		$.ajax({
    			//url  : "${contextPath}/study/ajaxTest1",
    			type : "post",
    			data : query,
    			//contentType:"application/json; charset=UTF-8",
    			success:function(data) {
    				// 수행후 넘어온 값을 처리하는 루틴
    				var str = "";
    				str += "<option value=''>도시선택</option>";
    				for(var i=0;i<data.city.length; i++) {
    				  str += "<option>"+data.city[i]+"</option>";
    				}
    				$("#city").html(str);
    			},
    			error : function(data) {
    				alert("전송오류!!");
    			}
    		});
    	});
    });
    
    function fCheck() {
    	var dodo = $("#do").val();
    	var city = $("#city").val();
    	if(dodo == "" || city == "") {
    		alert("지역과 도시를 선택하세요");
    	}
    	else {
    		alert("선택하신 지역/도시는? " + dodo + " / " + city);
    	}
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<div class="container">
  <h2>select box를 이용한 값의 전송1</h2>
  <hr/>
  <h2>도시를 선택하세요(HashMap을 이용한 비동기식 전달)</h2>
  <form name="myform" method="post">
    <!-- <select id="do" name="do" onchange="fCheck()"> -->
    <select id="do" name="do">
      <option value="">지역선택</option>
      <option value="서울">서울</option>
      <option value="경기">경기</option>
      <option value="충북">충북</option>
      <option value="충남">충남</option>
    </select>
    <select id="city">
      <option value="">도시선택</option>
    </select>
    <input type="button" value="선택" onclick="fCheck()"/>
  </form>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>