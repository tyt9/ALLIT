<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
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
		
	h3 {
	padding-top: 70px;
	}
		}
		
      #side_left {float:left;width: 20%; height: 600px;}
      #contents {float: left; width : 60%; height: 600px;}
      #side_right {float:left; width:20%; height: 600px;}
      #footer {clear:both;width:auto; height :0px; }
</style>
<head>
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
 	<title><spring:message code="member.register" /></title>
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
        
        <a class="btn btn-sm btn-outline-secondary" href="/login">로그인</a>
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
<div class = "container" style="text-align: center; padding-top: 40px; ">
    <h3><p>
        <spring:message code="register.done">
        	<spring:argument value="${registerRequest.name}" />
        	<spring:argument value="${registerRequest.id}" />
        </spring:message>
    </p></h3>
    <p>
        <a href="<c:url value='/main'/>"><button style="border: groove white; width: 180px; 
        border-radius: 20px;  height: 60px; padding: 5px; margin-top: 20px; background-color: #ff914d">
            <spring:message code="go.main" /></button>
        </a>
    </p>
</div>
</body>
</html>
