<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<style  >

<style>
.pagination {
			justify-content: center;
		}

.send{
			padding: 10px;
			width : 150px;
			margin: 10px;
			border-radius: 20px;
			border: groove;
			text-align: center;
			border-color: #ff914d;
		}

.a {text-decoration: none;}

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
      tr, td{
      	text-align: center;
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
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
 
<meta charset="UTF-8">
<title>관리자 게시판</title>

</head>
<body>
<div class="container">
  <header class="border-bottom lh-1 py-3">
    <div class="row flex-nowrap justify-content-between align-items-center">
      <div class="col-4 pt-1">
       
      </div>
     <div class="col-4 text-center">
        <a class="blog-header-logo text-body-emphasis text-decoration-none" href="/main"  >
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
 <div style="margin: 30px 50px 30px 70px">
<h3 style="text-align: center; padding-top: 30px"><strong>공지 게시판</strong></h3><br>
		<hr>


	<table border="1" class="table table-striped table-bordered table-hover" >
<c:if test="${authUser.userId eq 'admin'}">
		<tr>
			<td colspan="3"><button class="send"  style="
				background-color: #ff914d;"onclick="location.href='write'">
			게시글 쓰기</button></td></br>
		</tr>
		</c:if>
		<tr>
			
			<th>제목</th>

			<th>작성시간</th>
			<th>조회수</th>
		</tr>

		<c:if test="${noticePage.hasNoNotices()}">
			<tr>
				<td colspan="4">게시글이 없습니다.</td>
			</tr>
		</c:if>

		<c:forEach var="notice" items="${noticePage.content}">
			<tr>
				
				<td>

					<c:if test="${notice.noImpor !=0 }">
						<b>[필독]</b>
					</c:if>
					<a href="read?noNum=${notice.noNum}&pageNo=${noticePage.currentPage}" style= "color: black">
						<c:out value="${notice.noTitle}" />
					</a>


				</td>
			<td>
            <fmt:parseDate value="${notice.noDate}" pattern="yyyy-MM-dd" var="nodate" type="date"/>
               <fmt:formatDate pattern="yyyy년 MM월 dd일" value="${nodate}"/>
</td>
		

				<td>${notice.noHits}</td>
			</tr>
		</c:forEach>






		<c:if test="${noticePage.hasNotices()}">
	
			<tr>
				<td colspan="4"><c:if test="${noticePage.startPage > 5}">
						<a href="list.do?pageNo=${noticePage.startPage - 5}"></a>
					</c:if> 
					
					<c:forEach var="pNo" begin="${noticePage.startPage}"
 						end="${noticePage.endPage}">
 						
					<a href="list?pageNo=${pNo}">[${pNo}]</a> 
						
				</c:forEach>
				
				 <c:if test="${noticePage.endPage < noticePage.totalPages}"> 
					</c:if> 
			</td></tr>
	
			
	</c:if> 
		</table>
</div>
	<script>
src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
		crossorigin="anonymous"></script>





</div>


</body>
</html>