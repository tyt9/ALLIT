<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
      
      button{
      width: 100px; 
      height: 60px; 
      padding: 10px;
      border-radius: 20px;
      border: groove #ff914d;
      margin-top: 40px;
	  }
	  
	  #change {
	  width: 150px; 
      height: 50px; 
      border-radius:20px;
      border: groove #ff914d;
      margin: 20px;
	  }
	  
	  #check{
	  width: 150px; 
      height: 50px; 
      border-radius:20px;
      border: groove #ff914d;
      margin: 20px;
	  }
	  
	  .btn{
	  margin: 10px;
	  border-radius: 20px;
	  }
      
      input{
      width: 300px; 
      height: 40px; 
      border: groove white; 
      border-radius: 20px; 
      text-align: center;"
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
 	<title>회원 정보 수정</title>
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
<div class = "container" style="text-align: center; margin-top: 80px;">
	<form:form action = "/edit/changeInfo" modelAttribute="updateCommand">
	<p>
	
	<label><strong>아이디</strong> <br/>
	 <input type = "text" value ="${member.memberId}" id = "memberId" disabled/>
	</label>
	</p>
	
	<p>
	<label><strong>휴대전화</strong><br/>
	<input value = "${member.memberPhone}" id = "phone"
		placeholder="'-' 없이 작성" disabled/><br/>
		<button id = "confirm" style = "width: 100px; height: 60px; padding: 10px; border-radius: 20px; border: groove white; margin: 20px;">번호 변경</button>
		<button id="send" style = "width: 100px; height: 60px; padding: 10px; border-radius: 20px; margin: 0 auto; 
		display: none; border: groove white; margin-top: 10px;">전송</button>
	</label>
	</p>
	<div id = "signNumInput" style="display: none;">
	<input type = "text" name = "signNum" id = "signNum">
	<button id = "check">인증</button></div>
	<p>
	<label><strong>새 비밀번호</strong><br/>
	<form:password path = "password" value = "${member.memberPassword}" id ="password"/>
	<form:errors path = "password"/>
	</label>
	</p>
	<p>
	<label><strong>비밀번호 확인</strong><br/>
	<form:password path = "confirmPassword" value = "${member.memberPassword}" id ="confirmPassword"/>
	<form:errors path = "confirmPassword"/>
	</label>
	</p>
	<div id = "nextBtn" style="display: block;">
	<form:input type = "hidden" value = "${member.memberPhone}" id = "hidPhone" path = "phone" />
	<input type = "submit" value="수정하기" id = "change"></div>
	</form:form>
	<a href = "${pageContext.request.contextPath}/main"><button style = " width: 150px; height: 50px; border-radius:20px; 
		border: groove #ff914d;">수정 취소</button></a>
	</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script type="text/javascript">
      document.addEventListener("DOMContentLoaded", function() {
    	  var signNum = '';
    		`${ctxPath = pageContext.request.contextPath ; ''}`
    	  
        document.getElementById("phone").addEventListener("click", function(event) {
        	document.getElementById("phone").value = '';  	
      }); 
        document.getElementById("password").addEventListener("click", function(event) {
        	document.getElementById("password").value = '';  	
      }); 
        document.getElementById("confirmPassword").addEventListener("click", function(event) {
        	document.getElementById("confirmPassword").value = '';  	
      }); 
        
        document.getElementById("confirm").addEventListener("click", function(event) {
        	event.preventDefault();
        	let result = confirm("휴대전화 번호를 변경하기 위해서는 인증하셔야 합니다.\n계속하시겠습니까?");
        	if(result == true){
        	document.getElementById("phone").disabled = false;
        	document.querySelector('#nextBtn').style.display = "none";
        	document.querySelector('#send').style.display = "block";
        	} else {
        		document.getElementById("phone").value = `${member.memberPhone}`;
        		document.getElementById("phone").disabled = true;
        		document.querySelector('#nextBtn').style.display = "block";
        		document.querySelector('#send').style.display = "none";
        	}
      }); 
        
        document.getElementById("send").addEventListener("click", function(event) {
        	event.preventDefault();
        	let phonePattern = /^010\d{8}$/;
            let phoneValue = document.getElementById("phone").value;
            let oldPhone = `${member.memberPhone}`;
            if (phoneValue === '') {
            	event.preventDefault();
                alert("휴대폰 번호를 입력해주세요.");
                return;
            }
             else if (!phonePattern.test(phoneValue)){
           	 event.preventDefault();
        	 alert("입력하신 핸드폰 번호가 양식에 맞지 않습니다.");
        	 return;
         	}
            else if(phoneValue === oldPhone){
         	 event.preventDefault();
           	 alert("변경하실 핸드폰 번호를 입력해주세요.");
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
        	event.preventDefault();
        	let signNumInput =  document.getElementById("signNum").value;
            let phone = document.getElementById("phone").value;
            let memberId = document.getElementById("memberId").value;
            if (signNumInput === '') {
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
                        document.querySelector('#send').style.display = "none";
                        document.querySelector('#nextBtn').style.display = "block";
                        document.querySelector('#signNumInput').style.display = "none";
                        event.preventDefault();
                        alert("인증에 성공하였습니다.");
                        document.getElementById("phone").disabled = true;
                        document.getElementById("hidPhone").value = phone;
                        document.getElementById("hidId").value = memberId;
                    }
                }
            });
        });
        
        document.getElementById("change").addEventListener("click", function(event) {
        	let pw = document.getElementById("password").value;
        	let pwc = document.getElementById("confirmPassword").value;
        	let passPattern = /^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\W)(?=\S+$).{8,16}$/;
        	if ( pw === "" || pwc === "") {
        		 event.preventDefault();
                 alert("비밀번호를 입력해주세요.");
        	} else if (!passPattern.test(pw)){
        		event.preventDefault();
                alert("비밀번호를 양식에 맞게 입력해주세요.\n(영문, 숫자, 특수문자 포함 8~16자)");
        	} else if(pw !== pwc){
        		event.preventDefault();
                alert("두 비밀번호가 일치하지 않습니다.");
        	}
        });
        
   });
	</script>
</html>