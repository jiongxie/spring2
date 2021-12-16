<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pmInput.jsp</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script>
	  function fCheck() {
	  	var file = myform.file.value;
	  	var ext = file.substring(file.lastIndexOf(".")+1);  // 화일의 확장자만 구하기
	  	var uExt = ext.toUpperCase();  // 확장자를 대문자로 치환
	  	var maxSize = 1024 * 1024 * 10;   // 최대 10MByte 까지 허용
	  	
	  	var title = myform.title.value;
	  	/* var pwd = myform.pwd.value; */
	  	
	  	if(file == "") {
	  		alert("업로드할 파일을 선택하세요!");
	  		return false;
	  	}
	  	else if(title == "") {
	  		alert("업로드할 파일의 제목을 입력하세요!");
	  		myform.title.focus();
	  		return false;
	  	}
	  	/* 
	  	else if(pwd == "") {
	  		alert("비밀번호를 입력하세요!");
	  		myform.pwd.focus();
	  		return false;
	  	}
	  	 */
	  	var fileSize = document.getElementById("file").files[0].size;  // 업로드할 파일의 사이즈를 구한다.
	  	myform.fsize.value = fileSize;
	  	
	  	if(uExt != "ZIP" && uExt != "GIF" && uExt != "JPG" && uExt != "PNG" && uExt != "HWP" && uExt != "PPT" && uExt != "PPTX") {
	  		alert("업로드 가능파일은 'zip/gif/jpg/png/hwp'파일만 가능합니다.");
	  		return false;
	  	}
	  	else if(fileSize > maxSize) {
	  		alert("업로들할 파일의 최대용량은 10MByte이내입니다.");
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
<p><br/></p>
<div class="container">
  <h2 style="text-align:center;">Data</h2>
  <form name="myform" method="post" enctype="multipart/form-data">
    <div class="form-group">
      <input multiple="multiple" type="file" name="file" id="file" class="form-control-file border" accept=".zip,.jpg,.gif,.png,.hwp,.ppt,.pptx"/>
    </div>
    <div class="form-group">올린이 : ${snickname}</div>
    <div class="form-group">
      <label for="title">자료제목 : </label>
      <input type="text" name="title" id="title" placeholder="자료 제목을 입력하세요." class="form-control" required/>
    </div>
    <!-- 
    <div class="form-group">
      <label for="content">자료내용 : </label>
      <textarea rows="4" name="content" id="content" class="form-control" required></textarea>
    </div>
     -->
    <div class="form-group">
      <label for="part">자료분류 : </label>
      <select name="part" size="1" class="form-control">
        <option value="퀀트투자" selected>퀀트투자</option>
        <option value="단기트레이딩">단기트레이딩</option>
        <option value="자동매매">자동매매</option>
        <option value="기타">기타</option>
      </select>
    </div>
    <!-- 
    <div class="form-group">
      <div class="form-check-inline">공개여부 : &nbsp; &nbsp;
	      <label class="form-check-label">
	        <input type="radio" name="opensw" class="form-check-input" value="공개" checked/>공개 &nbsp; &nbsp;
	      </label>
	      <label class="form-check-label">
	        <input type="radio" name="opensw" class="form-check-input" value="비공개"/>비공개 &nbsp; &nbsp;
	      </label>
      </div>
    </div>
     -->
<!--     
    <div class="form-group">
      <label for="pwd">비밀번호 : </label>
      <input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." class="form-control"/>
    </div>
 -->    
    <div class="form-group">
      <button type="button" class="btn btn-dark" onclick="fCheck()" class="btn btn-secondary">Input</button>
      <button type="reset" class="btn btn-dark" class="btn btn-secondary">Reset</button>
      <button type="button" class="btn btn-dark" onclick="location.href='${contextPath}/pdsm/pmList';" class="btn btn-secondary">Data</button>
    </div>
    <input type="hidden" name="mid" value="${smid}"/>
    <input type="hidden" name="nickname" value="${snickname}"/>
    <input type="hidden" name="fsize"/>
  </form>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>