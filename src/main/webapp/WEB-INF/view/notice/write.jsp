<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<style>

.submit{
			padding: 10px;
			width : 150px;
			margin: 10px;
			border-radius: 20px;
			border: groove;
			text-align: center;
		}

.container{
width:400;
  margin: auto;
  text-align: center;


}
.a { text-decoration: none; }
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

      #side_left {float:left;width: 20%; height: 600px;}
      #contents {float: left; width : 60%; height: 600px;}
      #side_right {float:left; width:20%; height: 600px;}
      #footer {clear:both;width:auto; height :0px; }
</style>
<head>
<meta charset="UTF-8">
<title>공지글 작성</title>
<script src="${pageContext.request.contextPath}/assets/js/color-modes.js"></script>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="generator" content="Hugo 0.115.4">
    <title>ALLIT</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/blog/">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

    <link href="${pageContext.request.contextPath}/assets/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/dist/css/blog.css" rel="stylesheet">
 
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

<form action="write" method="post">

<table class="container">






<tr><td>

<p>
	제목:<br/><input type="text" name="title" value="${param.title}">
	</br><c:if test="${errors.title}">제목을 입력하세요.</c:if>
	
	 중요 <input type="checkbox" value="1" id="check" name="impor" />
</p></td></tr>
<tr><td>
<p>
	내용:<br/>
	<textarea name="content" rows="10" cols="50" style="resize: none">${param.content}</textarea>
</p></td></tr>
<tr><td>
<input class="submit" type="submit" value="새 글 등록" style="
				background-color: #ff914d;">
</td></tr>


</table>

</form>
</div>
</body>
</html>