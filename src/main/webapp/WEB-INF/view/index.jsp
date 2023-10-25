<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri = "http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<style>
	.parent{
		display: flex;}

	.child{
		flex: 1;
	}

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
		width : 130px;
		margin: 1px;
		border-radius: 20px;
		text-align: center;
	}

	#side_left {float:left;width: 20%; height: 600px;}
	#contents {float: left; width : 60%; height: 600px;}
	#side_right {float:left; width:20%; height: 600px;}
	#footer {clear:both;width:auto; height :0px; }
</style>
<head>
	<script src="assets/js/color-modes.js"></script>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="generator" content="Hugo 0.115.4">
	<title>ALLIT</title>
	<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/blog/">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

	<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
	<link href="assets/dist/css/blog.css" rel="stylesheet">

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
</div>
<main class="container">
	<div id="side_left" >
		<c:if test="${empty authUser}">
			<!--<p>환영합니다.</p>-->

			<form:form modelAttribute="loginCommand">

				<label><strong><spring:message code = "id"/></strong><br>
					<form:input path="id" style="border: groove white;
border-radius: 20px; text-align: center; width: 230px; height: 40px;"/><br>
					<form:errors path = "id" cssClass="error-message"/>
				</label>
				<p style="margin-top: 30px;">
				<label><strong><spring:message code = "password"/></strong><br>
					<form:password path="password" style="border: groove white;
border-radius: 20px; text-align: center; width: 230px; height: 40px;"/>
					<form:errors path = "password" cssClass="error-message"/>
				</label>


				<label><form:checkbox path="rememberId"/>
					<spring:message code = "rememberId"/>
				</label>

				<input type = "submit" style="margin: 20px; width: 170px; height: 40px;
border: groove white; border-radius: 20px; background-color: #ff914d" value = "<spring:message code = "login.btn"/>">
			</form:form>
			<a href="/register/step1" style="text-decoration: none; color: black;">[회원 가입]</a>
			<a href="/findInfo" style="text-decoration: none; color: black;">[아이디/비밀번호 찾기]</a>
			
		</c:if>

		<div class = "container" style="text-align: center; padding-top: 40px; ">
		<c:if test="${!empty authUser}">
			<h4><strong>${authUser.userName}<strong>님,</h4>
			<h5>환영합니다.</h5>
			<p>
				<c:if test = "${authUser.userId eq 'admin'}">
					<a href="/notice/write"><button class="send" style="margin: 5px; width: 170px; height: 40px;
border: groove white; border-radius: 20px; background-color: white; border: groove #ff914d;">공지사항 쓰기</button></a>
					<a href="<c:url value="/qna/list" />"><button class="send" style="margin: 5px; width: 170px; height: 40px;
border: groove white; border-radius: 20px; background-color: white; border: groove #ff914d;">회원 문의 관리</button></a>
					<a href="<c:url value="/editExams/insert" />"><button class="send" style="margin: 5px; width: 170px; height: 40px;
border: groove white; border-radius: 20px; background-color: white; border: groove #ff914d;">시험 일정 추가</button></a>
					<!-- 시험 일정 추가하는 매핑 어떤 것인지 몰라서 수정 예정!!! -->
				</c:if>
				<br>
				<a href="/edit/myPage" style="text-decoration: none; color: black;">[마이페이지]</a>
				<a href="/main/logout" style="text-decoration: none; color: black;">[로그아웃]</a>
			</p>
		</c:if>
		</div>
		<img src = "${pageContext.request.contextPath}/img/ad1.png" style="margin-top: 70px; margin-right:100px; width: 300px; height: auto;">
	</div>
	<div id="contents">

		<jsp:useBean id="today" class="java.util.Date" />
		<fmt:formatDate value='${today}' pattern='yyyy-MM-dd' var="nowDate"/>

		<div style="margin: 30px 100px 30px 100px;">
		<h2 style="text-align: center; padding-top: 30px"><strong>이번달 시험일정</strong></h2><br>
		<table width="30%" class="table table-striped table-bordered table-hover" border="1">
			<tr class="top">
				<th>시험명</th>
				<th>시험 날짜</th>
				<th>장소</th>
				<th>접수 기간</th>
				<th style="display: none;" id="thisMonth">${fn:substring(nowDate,5,7)}</th>
			</tr>

			<c:forEach var="list" items="${list}" varStatus="i">
				<tr class="invisable">
					<td><a href="schedule/examDetail?infoNum=${list.infoNum }" style="text-decoration:none; color: black;">${list.exName }</a></td>
					<td>${fn:substring(list.infoDate,0,10)}</td>
					<td>${list.infoLoc}</td>
					<td>${fn:substring(list.infoStart,0,10)} ~ ${fn:substring(list.infoEnd,0,10)}</td>
					<td style="display: none;" id="month">${fn:substring(list.infoDate,5,7) }</td>
				</tr>
			</c:forEach>

		</table>
			<img src = "${pageContext.request.contextPath}/img/ad2.png" style="width: 300px; height: auto; margin-top: 10px; margin-left: 100px;">
		</div>
	</div>
	<div id="side_right">
		<table border = 1 class="table table-striped table-bordered table-hover" >
			<tr><td colspan = "2" >공지사항</td></tr>
			<tr><th>제목</th><th>날짜</th></tr>
			<c:forEach var = "notice" items="${noticeList}">
				<tr><td><a href="/notice/read?noNum=${notice.noNum}" style="text-decoration:none; color: black;">${notice.noTitle}</a></td>
					<td><fmt:parseDate value="${notice.noDate}" pattern="yyyy-MM-dd" var="nodate" type="date"/>
						<fmt:formatDate pattern="yyyy/MM/dd" value="${nodate}"/></td></tr>
			</c:forEach>
		</table>

	</div>
</main>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function () {
		var thisMonth = $('#thisMonth').text();
		$('.invisable').each(function () {
			var month = $(this).find('#month').text();
			if (month !== thisMonth) {
				$(this).hide();
			}
		});
		$('.top').show();
	});

</script>
</body>
</html>