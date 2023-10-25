<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	  
      input{
      width: 150px; 
      height: 40px; 
      border: groove white; 
      border-radius: 20px; 
      text-align: center;
      border: groove #ff914d;
      }
           
      button{
      width: 150px; 
      height: 40px; 
      border: groove white; 
      text-align: center;
      border: groove #ff914d;
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
 	<title>비밀번호 변경</title>
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
<div class = "container" style="text-align: center; margin-top: 150px;">
	<form action = "/findIdSuccess" method = "post">
	<p><label><strong>이름</strong><br/>
	<input name = "name" id = "name" style="border: groove white; width: 250px;"/></label></p>
	<p style="margin-top: 50px;"><label><strong>핸드폰 번호</strong><br/>
	<input name = "phone" id = "phone" 
		placeholder="'-' 없이 작성" style="border: groove white; width: 250px;"/></label></p>
	<input type="submit" value = "조회" id = "change" style="margin-top: 30px;">
	</form>
	</div>
	<script type="text/javascript">
      document.addEventListener("DOMContentLoaded", function() {
         document.getElementById("change").addEventListener("click", function(event) {
        	let phonePattern = /^010\d{8}$/;
            let name = document.getElementById("name").value;
            let phone = document.getElementById("phone").value; 
            if ( name === "" || phone === "") {
            event.preventDefault();
            alert("모든 칸에 입력해주세요.");
         } else if (!phonePattern.test(phone)){
        	 event.preventDefault();
        	 alert("입력하신 핸드폰 번호가 양식에 맞지 않습니다.");
         }
      });
         
         document.getElementById("phone").addEventListener("click", function(event) {
         	document.getElementById("phone").value = '';  	
       });  
   });
   </script>
</body>
</html>