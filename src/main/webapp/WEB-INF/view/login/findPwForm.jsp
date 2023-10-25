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
      width: 250px; 
      height: 40px; 
      border: groove white; 
      border-radius: 20px; 
      text-align: center;
      border: groove white;
      }
           
      button{
      width: 150px; 
      height: 40px; 
      border: groove white; 
      text-align: center;
      border: groove #ff914d;
      }
      
      #send, #check{
      border-radius: 20px;
      width: 150px; 
      height: 40px; 
      border: groove white; 
      text-align: center;
      margin-top: 30px;
	  background-color: #ff914d;
      }
      
      #change{
      margin-top: 50px;
      height: 45px;
      border: groove #ff914d;
      background-color: white;
      
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
<div class = "container" style="text-align: center; margin-top: 130px;"> 
<h3 style="margin-bottom: 30px;">비밀번호 찾기</h3>
	<p><label>아이디<br/><input id = "memberId"/></label></p>
	<p><label>핸드폰 번호<br/><input name = "phone" id = "memberPhone" placeholder="'-' 없이 작성"/></label><br/>
	<button id = "send">전송</button></p>
	<div id = "signNumInput" style="display: none;">
	<input type = "text" name = "signNum" id = "signNum">
	<button id = "check">인증</button></div>
	<form action="/edit/changePassword" method = "get">
	<input type = "hidden" value = "" id = "hidId" name = "id">
	<input type = "hidden" value = "" id = "hidPhone" name = "phone">
	<div id = "nextBtn" style="display: none;">
	<input type="submit" value = "조회" id = "change"></div>
	</form>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script type="text/javascript">
      document.addEventListener("DOMContentLoaded", function() {
    	 var signNum = ''; 
         let phonePattern = /^010\d{8}$/;
    	 `${ctxPath = pageContext.request.contextPath ; ''}`
         
    	 document.getElementById("change").addEventListener("click", function(event) {
            let memberId = document.getElementById("memberId").value;
            let phone = document.getElementById("memberPhone").value; 
            if ( memberId === "" || phone === "") {
            event.preventDefault();
            alert("모든 칸에 입력해주세요.");
         } 
            else if (!phonePattern.test(phone)){
        	 event.preventDefault();
        	 alert("입력하신 핸드폰 번호가 양식에 맞지 않습니다.");
         }
      });
         
         document.getElementById("send").addEventListener("click", function(event) {
        	 let phoneValue = document.getElementById("memberPhone").value; 
        	 if (phoneValue === "") {
                 event.preventDefault();
                 alert("휴대폰 번호를 입력해주세요.");
                 return;
              } 
        	 else if (!phonePattern.test(phoneValue)){
             	 event.preventDefault();
            	 alert("입력하신 핸드폰 번호가 양식에 맞지 않습니다.");
            	 return;
            }
        	 
             $.ajax({
                 method: 'POST',
                 url: `${ctxPath}/register/send`,
                 data: {"phone": phoneValue},
                 dataType: "json",
                 success: function(res) {
                     if (res.success) {
                         signNum = res.signNum;
                         alert("인증번호가 전송되었습니다.");
                         document.querySelector('#signNumInput').style.display = "block";
                     } else {
                         alert("전송이 실패했습니다. 다시 시도하세요.");
                     }
                 }
             });
         });
    	 
         document.getElementById("check").addEventListener("click", function(event) {
        	 let signNumInput =  document.getElementById("signNum").value;
             let phone = document.getElementById("memberPhone").value;
             let memberId = document.getElementById("memberId").value;
             
             if (signNumInput === '') {
            	 event.preventDefault();
                 alert("인증번호를 입력해주세요.");
                 return;
             }
             
             $.ajax({
                 method: 'POST',
                 url: `${ctxPath}/register/result`,
                 data: {"signNumInput": signNumInput, "signNum": signNum},
                 dataType: "json",
                 success: function(res) {
                     if (!res) {
                         event.preventDefault();
                         alert("인증번호가 틀렸습니다.");
                     } else {
                         event.preventDefault();
                         alert("인증에 성공하였습니다.");
                         document.getElementById("hidPhone").value = phone;
                         document.getElementById("hidId").value = memberId;
                         document.querySelector('#nextBtn').style.display = "block";
                     }
                 }
             });
             
         });
    	 
         document.getElementById("memberPhone").addEventListener("click", function(event) {
         	document.getElementById("memberPhone").value = '';  	
       });  
         
         document.getElementById("memberId").addEventListener("click", function(event) {
          	document.getElementById("memberId").value = '';  	
        });  
   });
   </script>
	
</body>
</html>