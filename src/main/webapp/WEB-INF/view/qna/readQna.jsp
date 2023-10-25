<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	${ctxPath = pageContext.request.contextPath ; ''}
	<style>
		.parent{
			display: flex;}

		.child{
			flex: 1;
		}

		.pagination {
			justify-content: center;
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
			border: groove;
			text-align: center;
		}
		.find-btn {
			text-align: center;
		}

		#side_left {float:left;width: 20%; height: 600px;}
		#contents {float: left; width : 60%; height: 600px;}
		#side_right {float:left; width:20%; height: 600px;}
		#footer {clear:both;width:auto; height :0px; }
	</style>
	<script src="${ctxPath }/assets/js/color-modes.js"></script>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="generator" content="Hugo 0.115.4">
	<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/blog/">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

	<link href="${ctxPath }/assets/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
	<link href="${ctxPath }/assets/dist/css/blog.css" rel="stylesheet">
<title>게시글 읽기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
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

	<div style="margin: 30px 100px 30px 100px;">
		<h3 style="margin-top: 50px; text-align: center;">문의 게시판</h3>
		<hr>
		<table class="table table-striped table-bordered table-hover">
			<tr>
				<td>작성자</td>
				<td>${readRequest.memberName}</td>
			</tr>
			<tr>
				<td>제목</td>
				<td><c:out value='${readRequest.QTitle}' /></td>
			</tr>
			<tr>
				<td> 작성일자</td>
				<td>${readRequest.QDate }</td>
			</tr>
			<tr>
				<td>내용</td>
				<td><u:pre value='${readRequest.QContent}'/></td>
			</tr>
		</table>
		<p></p>
		<div class="find-btn">
			<c:set var="pageNo" value="${empty param.pageNo ? '1' : param.pageNo}" />
			<button class="send" style="
				background-color: #ff914d;" onclick="location.href='list?pageNo=${pageNo}'">목록</button>
			<!-- 		세션!!!! -->
			<c:if test="${authUser.memberNum == readRequest.memberNum}">
				<button class="send" style="
				background-color: #ff914d;" onclick="location.href='modify?no=${readRequest.QNum}'">게시글수정</button>
				<button class="send" style="
				background-color: #ff914d;" onclick="location.href='delete?no=${readRequest.QNum}'">게시글삭제</button>
			</c:if>
		</div>
	</div>
	<hr />
	<div class="card mb-2">
		<div class="card-header bg-light">
			<i class="fa fa-comment fa"></i> REPLY
		</div>
	<c:if test="${authUser.memberGrade == 1}">
		<div class="card-body">
			<ul class="list-group list-group-flush">
				<li class="list-group-item">
						<form action="read" method="post">
			작성자명 : <input class="form-control ml-2" type="text" name="replyName" value="${authUser.userName }" readonly="readonly"/>
			<input type="hidden" name="qNum" value="${readRequest.QNum }"/>
				<%-- 	<input type="hidden" value="${ }"/> --> 세션 아이디 받아야함 ,,, --%>
							<br>
							<p>
				댓글 작성 <br>
				<textarea class="form-control" textarea="<c:if test="${errors.content}">댓글을 입력하세요.</c:if>" name="content" rows="5" cols="50">${param.content }</textarea>
			</p>
			<p>
				<button class="send" style="
				background-color: #ff914d;" type="submit" class="btn btn-dark mt-3">새 글 등록</button>

			</p>

		</form>
		<hr>
	</c:if>


	<table width="100%">
		<c:forEach var="listReply" items="${ListReply}">
			<tr>
				<td>
						${listReply.replyName } &nbsp;&nbsp;&nbsp;
					<fmt:timeZone value="GMT">
						<fmt:formatDate value="${listReply.reDate }" pattern="yyyy-MM-dd HH:mm:ss" />
					</fmt:timeZone>
					&nbsp;
					<c:if test="${authUser.memberGrade == 1 }">
						<button class="send" style="
				background-color: #ff914d;" onclick="location.href='deleteReply?no=${listReply.reNum}&qnum=${listReply.qnum}'" value="${listReply.reNum}">삭제</button>
					</c:if>
					<br>
						${listReply.reContent}
					<input type="hidden" value="${listReply.reNum }">
					<hr>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
</div>





</body>
</html>