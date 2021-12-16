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
  <title>pmList.jsp</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script>
    function partCheck() {
    	var part = partForm.part.value;
    	location.href="${contextPath}/pdsm/pmList?pag=${pageVo.pag}&part="+part;
    }
    
    // 다운로드 횟수 증가(ajax처리)
    function downCheck(idx) {
    	var query = {idx : idx}
    	$.ajax({
    		url   : "${contextPath}/pdsm/downCheck",
    		type  : "get",
    		data  : query,
    		success : function(data) {
    			if(data == 1) {
    				//location.reload();
    				$("#container").load("${contextPath}/pdsm/pmList #container");
    			}
    		}
    	});
    }
    
    function pmDelete(idx) {
    	var ans = confirm("자료를 삭제할까요?");
    	if(!ans) {
    		return false;
    	}
    	var query = {idx : idx};
    	$.ajax({
    		url : "${contextPath}/pdsm/pmDelete",
    		type : "get",
    		data : query,
    		success : function(data) {
    			if(data == 1) {
    				//location.reload();
    				$("#container").load("${contextPath}/pdsm/pmList #container");
    			}
    		}
    	});
    }
    
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<p><br/></p>
<div class="container" id="container">
  <table class="table">
    <tr>
      <td colspan="2" style="text-align:center;border:none;"><h2>Data</h2></td>
    </tr>
    <tr>
  		<td style="text-align:left;border:none;width:15%;">
  		  <form name="partForm">
  		    <select name="part" onchange="partCheck()" class="form-control">
  		      <option value="전체" ${part=='전체' ? 'selected' : ''}>전체</option>
  		      <option value="퀀트투자" ${part=='퀀트투자' ? 'selected' : ''}>퀀트투자</option>
  		      <option value="단기트레이딩" ${part=='단기트레이딩' ? 'selected' : ''}>단기트레이딩</option>
  		      <option value="자동매매" ${part=='자동매매' ? 'selected' : ''}>자동매매</option>
  		      <option value="기타" ${part=='기타' ? 'selected' : ''}>기타</option>
  		    </select>
  		  </form>
  		</td>
  		<c:if test="${smid == 'admin'}">
	  		<td style="text-align:right;border:none;">
	  		  <button type="button" class="btn btn-dark" onclick="location.href='${contextPath}/pdsm/pmInput';" class="btn btn-secondary">Input</button>
	  		</td>
	  	</c:if>
    </tr>
  </table>
  <table class="table table-borderless">
    <tr style="text-align:center;background-color:black;">
      <th style="color:white;">번호</th>
      <th style="color:white;">자료제목</th>
      <th style="color:white;">올린이</th>
      <th style="color:white;">올린날자</th>
      <th style="color:white;">파일명(용량)</th>
      <th style="color:white;">분류</th>
      <th style="color:white;">다운횟수</th>
      <th style="color:white;">다운로드</th>
      <th style="color:white;">관리자</th>
    </tr>
    <c:set var="curScrNo" value="${pageVo.curScrNo}"/>
    <c:forEach var="vo" items="${vos}">
	    <tr>
	      <td>${curScrNo}</td>
	      <td>
	      	<%-- <a href="javascript:nWin('${vo.idx}')" style="color:black;"> --%>${vo.title}<!-- </a> -->
	      </td>
	      <td>${vo.nickname}</td>
	      <td>${vo.fdate}</td>
	      <td>
		      	<c:set var="fnames" value="${fn:split(vo.fname,'/')}"/>
		      	<c:set var="rfnames" value="${fn:split(vo.rfname,'/')}"/>
	          <c:forEach var="fname" items="${fnames}" varStatus="st">
	          	<a href="${contextPath }/resources/pdsm/${rfnames[st.index]}" download>${fname}</a>
	          </c:forEach>
			      (<fmt:formatNumber value="${vo.fsize / 1024}" pattern="#,###.#"/>KB)
	      </td>
	      <td>${vo.part}</td>
	      <td>${vo.downnum}</td>
	      <td>
	        <a href="${contextPath}/pdsm/pmDown?idx=${vo.idx}&fname=${vo.fname}&rfname=${vo.rfname}&title=${vo.title}" download onclick="downCheck(${vo.idx})">
	        	<input type="button" value="다운"/>
	        </a>
	    
	      </td>
	      <td>
	      	  <c:if test="${smid == vo.mid || slevel == 0}">
			      	<a href="javascript:pmDelete(${vo.idx })">X</a> 
			      </c:if>
	      </td>
	    </tr>
	    <c:set var="curScrNo" value="${curScrNo-1}"/>
    </c:forEach>
  </table>
</div>
<!-- 블록 페이징처리 시작 -->
<div class="container" style="text-align:center">
  <ul class="pagination justify-content-center">
	  <c:set var="startPageNum" value="${pageVo.pag - (pageVo.pag-1)%pageVo.blockSize}"/>
	  <c:if test="${pageVo.pag != 1}">
	    <li class="page-item"><a href="${contextPath}/pdsm/pmList?pag=1&pageSize=${pageVo.pageSize}" class="page-link" style="color:#666">◁◁</a></li>
	    <li class="page-item"><a href="${contextPath}/pdsm/pmList?pag=${pageVo.pag-1}&pageSize=${pageVo.pageSize}" class="page-link" style="color:#666">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="0" end="2">
	    <c:if test="${(startPageNum+i) <= pageVo.totPage}">
	      <c:if test="${pageVo.pag == (startPageNum+i)}">
	        <li class="page-item active"><a href="${contextPath}/pdsm/pmList?pag=${startPageNum+i}&pageSize=${pageVo.pageSize}" class="page-link btn btn-secondary active" style="color:#666"><font color="#fff"><b>${startPageNum+i}</b></font></a></li>
	      </c:if>
	      <c:if test="${pageVo.pag != (startPageNum+i)}">
	        <li class="page-item"><a href="${contextPath}/pdsm/pmList?pag=${startPageNum+i}&pageSize=${pageVo.pageSize}" class="page-link" style="color:#666">${startPageNum+i}</a></li>
	      </c:if>
	    </c:if>
	  </c:forEach>
	  <c:if test="${pageVo.pag != pageVo.totPage}">
	    <li class="page-item"><a href="${contextPath}/pdsm/pmList?pag=${pageVo.pag+1}&pageSize=${pageVo.pageSize}" class="page-link" style="color:#666">▶</a></li>
	    <li class="page-item"><a href="${contextPath}/pdsm/pmList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}" class="page-link" style="color:#666">▷▷</a></li>
	  </c:if>
	</ul>
</div>
<!-- 블록 페이징처리 끝 -->
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>