<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head><script src="assets/js/color-modes.js"></script>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="generator" content="Hugo 0.115.4">
	<title>시험 일정 조회</title>
	<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/blog/">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

	<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

	<style>

		a {text-decoration: none;}

		.nav-scroller {
			position: relative;
			z-index: 2;
			height: 2.75rem;
			overflow-y: hidden;
		}

		.nav-scroller .nav {
			display: flex;
			flex-wrap: nowrap;
			padding-bottom: 1rem;
			margin-top: -1px;
			overflow-x: auto;
			text-align: center;
			white-space: nowrap;
			-webkit-overflow-scrolling: touch;
		}

		.send{
			padding: 1px;
			width : 150px;
			margin: 1px;
			border-radius: 20px;
			border: groove;
			text-align: center;
		}

		#side_left {float:left;width: 20%; line-height: 600px; height: 600px; background-color: #039be5;}
		#contents {float: left; width : 60%; line-height:600px;height: 600px; background-color: #03a9f4;}
		#side_right {float:left; width:20%; line-height: 600px; height: 600px; background-color: #29b6f6;}
		#footer {clear:both;width:auto; height :0px; }
	</style>


	<!-- Custom styles for this template -->
	<link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="/assets/dist/css/blog.css" rel="stylesheet">
</head>
<body>


<div class="container">
	<header class="border-bottom lh-1 py-3">
		<div class="row flex-nowrap justify-content-between align-items-center">
			<div class="col-4 pt-1">

			</div>
			<div class="col-4 text-center">
				<a class="blog-header-logo text-body-emphasis text-decoration-none" href="/main">
					<img src="${pageContext.request.contextPath}/img/ALLIT_IMG.png" alt="Logo" width="400.35" height="130.8" viewBox="0 0 118 94" class="d-block my-1">
				</a>
			</div>
			<div class="col-4 d-flex justify-content-end align-items-center">
			</div>
		</div>
	</header>
	<div class="nav-scroller py-1 mb-3 border-bottom">
		<nav class="nav nav-underline justify-content-between">
			<a class="nav-item nav-link link-body-emphasis" href="/schedule">시험 일정 및 접수</a>
			<a class="nav-item nav-link link-body-emphasis" href="/notice/list">공지사항</a>
			<a class="nav-item nav-link link-body-emphasis" href="/qna/list">문의 게시판</a>
			<a class="nav-item nav-link link-body-emphasis" href="/edit/myPage">마이 페이지</a>
		</nav>
	</div>
	<h3 style="text-align: center; padding-top: 30px"><strong>시험 일정 조회</strong></h3><br>
	<hr>
	<label style="display: none;" class="hiddenStartDate">${startDate }</label>
	<label style="display: none;" class="hiddenEndDate">${endDate }</label>
	<form method="post">
		<div id="clock" ></div><br>
		<input type="hidden" name="hiddenActBtn" id="hiddenActBtn" value="${hiddenActBtnVal }">
		<label for="startDate">시작 날짜:</label>
		<input type="date" name="startDate" id="startDate" value="${startDate }">
		<label for="endDate">종료 날짜:</label>
		<input type="date" name="endDate" id="endDate" value="${endDate }">
		<input type="submit" class="send" style="background-color: #ff914d;" id="dateSubmit" value="검색">
		<input type="button" class="send" style="background-color: #ff914d;" id="resetBtn" value="초기화">
	</form>
	<hr>
	<div>
		<button class="send" style="
				background-color: #ff914d;" id="displayAllBtn">전체</button>
		<c:forEach var="list" items="${examsList}" varStatus="num">
			<button id="${list.exNum }" class="examBtn send" style="background-color: #ff914d;">${list.exName }</button>
		</c:forEach>
	</div><br>

	<jsp:useBean id="today" class="java.util.Date" />
	<fmt:formatDate value='${today}' pattern='yyyy-MM-dd' var="nowDate"/>

	<table  class="table table-striped table-bordered table-hover" border="1">
		<tr>
			<th>시험명</th>
			<th>시험 날짜</th>
			<th>장소</th>
			<th>접수 기간</th>
			<th>접수</th>
			<c:if test="${userGrade eq '1'}">
				<th>비고</th>
			</c:if>

		</tr>
		<c:forEach var="list" items="${list}" varStatus="num">
			<tr class="trClass">
				<td class="${list.exNum }">
					<a href="schedule/examDetail?infoNum=${list.infoNum }">${list.exName }</a></td>
				<td>${fn:substring(list.infoDate,0,10) }</td>
				<td>${list.infoLoc }</td>
				<c:if test="${fn:substring(list.infoStart,0,10) <= nowDate}">
					<c:if test="${fn:substring(list.infoEnd,0,10) >= nowDate}">
						<td><strong>${fn:substring(list.infoStart,0,10) } ~ ${fn:substring(list.infoEnd,0,10) }</strong></td>
						<td><button class="applyBtn send" style="background-color: #ff914d;" id="${list.infoNum }">접수</button></td>
					</c:if>
				</c:if>
				<c:if test="${fn:substring(list.infoEnd,0,10) < nowDate}">
					<td>${fn:substring(list.infoStart,0,10) } ~ ${fn:substring(list.infoEnd,0,10) }</td>
					<td>접수기간지남</td>
				</c:if>
				<c:if test="${fn:substring(list.infoStart,0,10) > nowDate}">
					<td>${fn:substring(list.infoStart,0,10) } ~ ${fn:substring(list.infoEnd,0,10) }</td>
					<td>접수 예정</td>
				</c:if>
				<c:if test="${userGrade eq '1'}">
					<td><button class="examDelBtn send" style="background-color: #ff914d;" value="${list.infoNum }" id="${list.infoNum }">삭제</button></td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
</div>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		var hiddenActBtn = $('#hiddenActBtn').val();
		if(hiddenActBtn == null || hiddenActBtn == ""){
			hiddenActBtn = 'displayAllBtn';
		}
		document.getElementById(hiddenActBtn).click();
		setDateTime();
		setInterval(setDateTime, 1000);
	});
	
	$('.examBtn').click(function(){
		var examId = $(this).attr('id');
		$("#hiddenActBtn").val(examId);
		$('.trClass').css('display','none');
		$('td').each(function(index,item){
			if($(this).attr('class') == examId){
				$(this).parent().css('display','');
			}
		});
	});
	
	$('#displayAllBtn').click(function(){
		$("#hiddenActBtn").val('');
		$('.trClass').css('display','');
	});
	
	var startDate = $('.hiddenStartDate').text();
	var endDate = $('.hiddenEndDate').text();
	
	$('#resetBtn').click(function(){
		location.href = "schedule";
	});

	$('.applyBtn').click(function(){
		var applyBtnVal = $(this).attr('id');
		var applyCountInfoNum = applyBtnVal;
		$.ajax({
			data: JSON.stringify({ infoNum: parseInt(applyCountInfoNum) }), // 정수로 변환
			url: "/applyCheck/applyCount",
			type: "POST",
			contentType: "application/json",
			success: function (data) {
				if (data >= 30) {
					alert("정원초과");
				} else {
					location.href = "schedule/examDetail?infoNum="+applyBtnVal;
				}
			},
			error: function() {
				alert("Error occurred");
			}
		});
	});
	
	function setDateTime(){
		var now = new Date();
		
		var year=now.getFullYear();
	    var month=now.getMonth()+1;
	    var date=now.getDate();
	    var dayString = ["일","월","화","수","목","금","토"]; 
	    var day=dayString[now.getDay()];
	    
	    var dateString = year+"년 "+month+"월 "+date+"일 "+day+"요일 ";
		
		var hour = now.getHours();
		var minutes = now.getMinutes();
		if(minutes < 10){
			minutes = "0"+minutes;
		}
		var seconds = now.getSeconds();
		if(seconds < 10){
			seconds = "0"+seconds;
		}
// 		var timeString = `${hour}:${minutes}:${seconds}`
		var timeString = hour+":"+minutes+":"+seconds;
		$('#clock').html("<h4>"+dateString+timeString+"</h4>");
	}

	$('.examDelBtn').click(function (){
		var confirmMsg = confirm("삭제하시겠습니까?");
		var delInfoNum = $(this).val();
		if(confirmMsg){
			$.ajax({
				data: JSON.stringify({ infoNum: parseInt(delInfoNum) }), // 정수로 변환
				url: "/applyCheck/delExam",
				type: "POST",
				contentType: "application/json",
				success: function (data) {
					console.log(data);
					location.href = "/schedule";
				},
				error: function() {
					alert("Error occurred");
				}
			});
		}

	})

</script>
</body>
</html>
