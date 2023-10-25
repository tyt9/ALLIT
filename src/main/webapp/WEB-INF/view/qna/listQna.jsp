<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		tr, td{
			text-align: center;
		}
		#side_left {float:left;width: 20%; height: 600px;}
		#contents {float: left; width : 60%; height: 600px;}
		#side_right {float:left; width:20%; height: 600px;}
		#footer {clear:both;width:auto; height :0px; }
	</style>
	<title>게시글 목록</title>
	<script src="${ctxPath }/assets/js/color-modes.js"></script>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="generator" content="Hugo 0.115.4">
	<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/blog/">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

	<link href="${ctxPath }/assets/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
	<link href="${ctxPath }/assets/dist/css/blog.css" rel="stylesheet">
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
		<h3 style="text-align: center; padding-top: 30px"><strong>문의 게시판</strong></h3><br>
		<hr>
		<button class="send" style="
				background-color: #ff914d;" onclick="location.href='write'">게시글쓰기</button>
		<p></p>
		<table class="table table-striped table-bordered table-hover">
			<tr>
				<!-- 		<td>번호</td> -->
				<th>제목</th>
				<th>작성자</th>
				<th>작성일자</th>
				<th>조회수</th>
			</tr>
			<c:if test="${qnaPage.hasNoArticles()}">
				<tr>
					<td colspan="4">게시글이 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="qna" items="${qnaPage.content}">
				<tr>
						<%-- 		<td>${qna.QNum}</td> --%>
					<td>
						<a href="<c:url value="read?no=${qna.QNum}&pageNo=${qnaPage.currentPage}"/>" style="text-decoration:none">
							<c:out value="${qna.QTitle}"/>
						</a>
					</td>
						<%-- 작성자 세션 받아야 함		<td>${article.writer.name}</td> --%>
					<td>${qna.memberName}</td>
					<td>${qna.QDate }</td>
					<td>${qna.QHits}</td>
				</tr>
			</c:forEach>
		</table>
		<c:if test="${qnaPage.hasArticles()}">
			<nav aria-label="Page navigation example">
				<ul class="pagination">
					<li class="page-item">
						<c:if test="${qnaPage.startPage > 5}">
							<a href="list?pageNo=${pNo}?pageNo=${qnaPage.startPage - 5}" class="page-link" aria-label="Previous">
								<span aria-hidden="true">이전</span>
								<span class="sr-only"></span>
							</a>
						</c:if>
					</li>
					<c:forEach var="pNo"
							   begin="${qnaPage.startPage}"
							   end="${qnaPage.endPage}">
						<li class="page-item">
							<a href="list?pageNo=${pNo}" class="page-link">${pNo}</a>
						</li>
					</c:forEach>
					<li class="page-item">
						<c:if test="${qnaPage.endPage < qnaPage.totalPages}">
							<a href="list?pageNo=${qnaPage.startPage + 5}" class="page-link" aria-label="Next">
								<span aria-hidden="true">다음</span>
								<span class="sr-only"></span>
							</a>
						</c:if>
					</li>
				</ul>
			</nav>
		</c:if>
	</div>
</div>

</body>
</html>