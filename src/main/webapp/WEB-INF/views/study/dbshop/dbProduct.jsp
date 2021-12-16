<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbProduct.jsp(상품등록)</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="${contextPath}/resources/ckeditor/ckeditor.js"></script>
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
    	var product1 = myform.product1.value;
    	var product2 = myform.product2.value;
    	var product3 = myform.product3.value;
    	var product = myform.product.value;
			var mainprice = myform.mainprice.value;
			var detail = myform.detail.value;
			/* var content = myform.content.value; */
			var file = myform.file.value;												// 파일명
			var ext = file.substring(file.lastIndexOf(".")+1);  // 확장자 구하기
			var uExt = ext.toUpperCase();
			var regExpPrice = /^[0-9|_]*$/;   // 가격은 숫자로만 입력받음
			
			if(product3 == "") {
				alert("상품 소분류(세분류)를 입력하세요!");
				return false;
			}
			else if(product == "") {
				alert("상품명(모델명)을 입력하세요!");
				return false;
			}
			else if(file == "") {
				alert("상품 이미지를 등록하세요");
				return false;
			}
			else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
				alert("업로드 가능한 파일이 아닙니다.");
				return false;
			}
			else if(mainprice == "" || !regExpPrice.test(mainprice)) {
				alert("상품금액은 숫자로 입력하세요.");
				return false;
			}
			else if(detail == "") {
				alert("상품의 초기 설명을 입력하세요");
				return false;
			}
			else if(document.getElementById("file").value != "") {
				var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
				var fileSize = document.getElementById("file").files[0].size;
				if(fileSize > maxSize) {
					alert("첨부파일의 크기는 10MB 이내로 등록하세요");
					return false;
				}
				else {
					myform.submit();
				}
			}
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
	<div style="text-align:center;">
  	<h3 style="color:blue;"><a href="${contextPath }/study/dbshop/dbJumunProcess">◀</a><a href="${contextPath }/study/dbshop/dbShopAd">Product</a><a href="${contextPath }/study/dbshop/dbOption">▶</a></h3>
  </div>
<div class="container">
  <div id="product">
    <form name="myform" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="product1">대분류</label>
        <select id="product1" name="product1" class="form-control">
		      <option value="">대분류</option>
		      <c:forEach var="vo" items="${vos}">
		        <option>${vo.product1}</option>
		      </c:forEach>
		    </select>
      </div>
      <div class="form-group">
        <label for="">중분류</label>
        <select id="product2" name="product2" class="form-control">
		      <option value="">중분류</option>
		    </select>
      </div>
      <div class="form-group">
        <label for="">소분류</label>
        <select id="product3" name="product3" class="form-control">
		      <option value="">소분류</option>
		    </select>
      </div>
      <div class="form-group">
        <label for="product">상품(모델)명</label>
        <input type="text" name="product" id="product" class="form-control" placeholder="상품 모델명을 입력하세요" required/>
      </div>
      <div class="form-group">
        <label for="file">메인이미지</label>
        <input type="file" name="file" id="file" class="form-control-file border" accept=".jpg,.gif,.png,.jpeg" required/>
        (업로드 가능파일:jpg, jpeg, gif, png)
      </div>
      <div class="form-group">
      	<label for="mainprice">상품기본가격</label>
      	<input type="text" name="mainprice" id="mainprice" class="form-control" required/>
      </div>
      <div class="form-group">
      	<label for="detail">상품기본설명</label>
      	<input type="text" name="detail" id="detail" class="form-control" required/>
      </div>
      <div class="form-group">
      	<label for="content">상품상세설명</label>
      	<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
      </div>
      <script>
		    CKEDITOR.replace("content",{
		    	uploadUrl:"${contextPath}/study/imageUpload",     /* 그림파일 드래그&드롭 처리 */
		    	filebrowserUploadUrl: "${contextPath}/study/imageUpload",  /* 이미지 업로드 */
		    	height:400
		    });
		  </script>
		  <input type="button" value="상품등록" onclick="fCheck()" class="btn btn-dark"/> &nbsp;
		  <input type="button" value="돌아가기" onclick="location.href='${contextPath}/study/dbshop/dbShopAd';" class="btn btn-dark"/>
    </form>
  </div>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>