<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	${ctxPath = pageContext.request.contextPath ; ''}
	<script src="${ctxPath }/assets/js/color-modes.js"></script>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="generator" content="Hugo 0.115.4">
	<title>시험 일정 조회</title>
	<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/blog/">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

	<link href="${ctxPath }/assets/dist/css/bootstrap.min.css" rel="stylesheet">

	<style>
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
			width : 100px;
			margin: 1px;
			border-radius: 20px;
			border: groove;
			text-align: center;
		}

		a {text-decoration: none;}

		#side_left {float:left;width: 20%; line-height: 600px; height: 600px; background-color: #039be5;}
		#contents {float: left; width : 60%; line-height:600px;height: 600px; background-color: #03a9f4;}
		#side_right {float:left; width:20%; line-height: 600px; height: 600px; background-color: #29b6f6;}
		#footer {clear:both;width:auto; height :0px; }
	</style>


	<!-- Custom styles for this template -->
	<link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="${ctxPath }/assets/dist/css/blog.css" rel="stylesheet">
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
					<img src="${ctxPath}/img/ALLIT_IMG.png" alt="Logo" width="400.35" height="130.8" viewBox="0 0 118 94" class="d-block my-1">
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
	<h2 style="padding-top: 30px;">시험 상세 정보</h2><br>

	<h3>시험명: ${examDetail.infoSeq}회차 ${examDetail.exName }</h3><br>
	<p>시험 접수 기간: ${fn:substring(examDetail.infoStart,0,10) } ~
		${fn:substring(examDetail.infoEnd,0,10) }</p>
	<p>시험 날짜: ${fn:substring(examDetail.infoDate,0,10) }</p>
	<p>장소: ${examDetail.infoLoc }</p>
	<p>검정료: ${examDetail.infoPrice }원</p>
	<p>설명: ${examDetail.info }</p>
	<p>접수 상황: ${30 - selectCount }명 접수 가능 (${selectCount }/30)</p>

	<jsp:useBean id="today" class="java.util.Date" />
	<fmt:formatDate value='${today}' pattern='yyyy-MM-dd' var="nowDate"/>

	<input type="hidden" id="applySession" value="${applySession}">

	<button id="applyBtn" class="send" style="background-color: #ff914d;" value="${examDetail.infoNum }"
			<c:if test="${fn:substring(examDetail.infoStart,0,10) > nowDate || fn:substring(examDetail.infoEnd,0,10) < nowDate
    || selectCount >= 30}">
				disabled</c:if>>접수하기</button>

	<button id="backToSchedule" class="send" style="background-color: #ff914d;">시험 일정</button>
	<br><br>

	<div>
		<table class="table table-striped table-bordered table-hover" border="1" style="width: 500px">
		<c:choose>
			<c:when test="${examDetail.prevNum != 0}">
				<td>이전 회차 <a href="examDetail?infoNum=${examDetail.prevNum }">
						${examDetail.infoSeq - 1}회차 ${examDetail.exName }</a></td>
			</c:when>
			<c:otherwise>
				<td>이전 회차가 없습니다.</td>
			</c:otherwise>
		</c:choose>
		</table>
	</div>
	<div>
		<table class="table table-striped table-bordered table-hover" border="1" style="width: 500px">
		<c:choose>
			<c:when test="${examDetail.nextNum != 0}">
				<td>다음 회차 <a href="examDetail?infoNum=${examDetail.nextNum}">
						${examDetail.infoSeq + 1}회차 ${examDetail.exName }</a></td>
			</c:when>
			<c:otherwise>
				<td>다음 회차가 없습니다.</td>
			</c:otherwise>
		</c:choose>
		</table>
	</div>
</div>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

$('#backToSchedule').click(function(){
	location.href = "/schedule";
});

$('#applyBtn').click(function(){
	if($('#applySession').val() == 'F'){
		alert("로그인 하세요");
		location.href = "/login";
		return false;
	}
	
	orderArray();
});

function orderArray() {
	var applyInfoNum = $('#applyBtn').val();
	console.log("applyInfoNum"+applyInfoNum);
// 	var applyBtnVal = $(this).val();
    $.ajax({
//         data: {"infoNum":applyInfoNum},
//         data: JSON.stringify(applyInfoNum),
		data: JSON.stringify({ infoNum: applyInfoNum }),
        url: "/applyCheck",
        type: "POST",
        contentType: "application/json",
        success: function (data) {
        	if(data == 0){
        		
        		location.href = "/apply?infoNum="+applyInfoNum;
        	}else if(data > 0){
        		alert("이미 접수한 시험입니다");
        	}
//             location.href = "/applyCheck"
			console.log(data);
        },
        error: function() {
//             alert("error… ");
        }
    });
}

</script>
</body>
</html>