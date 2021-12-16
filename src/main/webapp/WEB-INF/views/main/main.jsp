<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Robostock.com</title>
	<script>
	  function popupCheck() {
		  <c:forEach var="popup" items="${popupVos}"> /* main컨트롤러에서 popupSw가 'Y'인 자료만 보내준다. */
		  	var url = "${contextPath}/notify/popup?idx=${popup.idx}";
		  	openPopup(url,${popup.idx});
		  </c:forEach>
	  }
	  
	  var xPos = 0;
	  function openPopup(url,idx) {
		  xPos += 100;
		  var cookieCheck = getCookie("popupYN"+idx);
		  if(cookieCheck != "N") {
		  	window.open(url,"","width=400,height=600,left="+xPos+",top=5");
		  }
	  }
	  
	  function getCookie(name) {
		  var cookie = document.cookie;  // 클라이언트에 저장된 쿠키의 정보를 읽어(가져)온다.
		  if(cookie != "") {
			  var cookieArray = cookie.split("; ");
			  for(var index in cookieArray) {
				  var cookieName = cookieArray[index].split("=");
				  if(cookieName[0] == name) {
					  return cookieName[1];
				  }
			  }
		  }
		  return;
	  }
	</script>
	<style>
		body {font-family: "Lato", sans-serif}
		.mySlides {display: none}
	</style>
<body onload="javascript:popupCheck()">

<!-- Navbar -->
<%@ include file="/WEB-INF/views/include/nav.jsp" %>

<!-- Page content -->
<div class="w3-content" style="max-width:2000px;margin-top:46px">

  <!-- Automatic Slideshow Images -->
  <%@ include file="/WEB-INF/views/include/slide2.jsp" %>

  <!-- The Band Section -->
  <div class="w3-container w3-content w3-center w3-padding-64" style="max-width:800px" id="band">
    <h2 class="w3-wide">We are</h2>
    <p class="w3-opacity"><i>퀀트투자란?</i></p>
    <p class="w3-justify">주식 전문 투자자들 대부분은 처음에 손익계산서, 재무상태표 등을 통해 재무분석을 하고, 애널리스트의 리서치 보고서를 읽습니다.  하지만 이와 반대로
    수치화된 정보를 가지고 수학이나 통계등을 사용해서 분석하여 자산의 가치를 평가하는 작업을 우리는 Quantitative Analytics 줄여서 Quant 라고 부릅니다.
    저희 Robostock.com은 다소 주관적일수 있는 펀드매니저의 직관에 의한 투자가 아닌, 반대인 방식으로 숫자화 될수 있는 객관적인 정보만을 활용하여 투자하는 방식을 지향합니다.
     지금 현재도 주식매매에 있어서 대부분의 거래가 자동으로 이루어져있고, 월가에서는 598명이 트레이더가 인공지능 컴퓨터에 의해 대체되는 일까지 벌어졌습니다. 저희 회사는 시시각각 변화하는  
     시장에서 고객님에게 최대한의 이율을 가져다드릴수 있도록 최선을 다하겠습니다.  
    </p>
  </div>

  <!-- The Tour Section -->
  <div class="w3-black" id="tour">
    <div class="w3-container w3-content w3-padding-64" style="max-width:800px">
      <h2 class="w3-wide w3-center">자동매매</h2>
      <p class="w3-opacity w3-center"><i>투자알고리즘</i></p><br>

      <ul class="w3-ul w3-border w3-white w3-text-grey">
        <li class="w3-padding"><a href="${contextPath }/board/bContent?idx=8&pag=1&pageSize=5">변동성돌파전략</a> <span class="w3-tag w3-red w3-margin-left">Main</span><span class="w3-badge w3-right w3-margin-right">1</span></li>
        <li class="w3-padding"><a href="${contextPath }/board/bContent?idx=9&pag=1&pageSize=5">금등주포착 알고리즘</a> <span class="w3-tag w3-red w3-margin-left">Main</span><span class="w3-badge w3-right w3-margin-right">1</span></li>
        <li class="w3-padding"><a href="${contextPath }/board/bContent?idx=10&pag=1&pageSize=5">이동평균선/저평가주 매매</a> <span class="w3-tag w3-red w3-margin-left">Sub</span><span class="w3-badge w3-right w3-margin-right">2</span></li>
        <li class="w3-padding"><a href="${contextPath }/board/bContent?idx=11&pag=1&pageSize=5">딥러닝 자동매매 가이드</a> <span class="w3-tag w3-red w3-margin-left">comming soon</span><span class="w3-badge w3-right w3-margin-right">1</span></li>
      </ul>

    
        
        
      </div>
    </div>
  </div>



  <!-- Ticket Modal -->
  <div id="ticketModal" class="w3-modal">
    <div class="w3-modal-content w3-animate-top w3-card-4">
      <header class="w3-container w3-teal w3-center w3-padding-32"> 
        <span onclick="document.getElementById('ticketModal').style.display='none'" 
       class="w3-button w3-teal w3-xlarge w3-display-topright">×</span>
        <h2 class="w3-wide"><i class="fa fa-suitcase w3-margin-right"></i>Tickets</h2>
      </header>
      <div class="w3-container">
        <p><label><i class="fa fa-shopping-cart"></i> Tickets, $15 per person</label></p>
        <input class="w3-input w3-border" type="text" placeholder="How many?">
        <p><label><i class="fa fa-user"></i> Send To</label></p>
        <input class="w3-input w3-border" type="text" placeholder="Enter email">
        <button class="w3-button w3-block w3-teal w3-padding-16 w3-section w3-right">PAY <i class="fa fa-check"></i></button>
        <button class="w3-button w3-red w3-section" onclick="document.getElementById('ticketModal').style.display='none'">Close <i class="fa fa-remove"></i></button>
        <p class="w3-right">Need <a href="#" class="w3-text-blue">help?</a></p>
      </div>
    </div>
  </div>
</div>

  <!-- The Band Section -->
  <div class="w3-container w3-content w3-center w3-padding-64" style="max-width:800px" id="band">
    <h2 class="w3-wide">관련사이트</h2>
      <div class="w3-third">
        <p>All weather investment</p>
        <a href="http://218.236.203.78:9090/cj200805/" ><img src="${contextPath}/main/images/image-02.jpg" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%"></a>
      </div>
      <div class="w3-third">
        <p>Pure alpha community</p>
        <a href="${contextPath }/main2" ><img src="${contextPath}/main/images/image-03.jpg" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%"></a>
      </div>
      <div class="w3-third">
        <p>Robostock.com</p>
        <a href="" ><img src="${contextPath}/main/images/image-04.jpg" class="w3-round" alt="Random Name" style="width:60%"></a>
      </div>
    </div>
  </div>

<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>