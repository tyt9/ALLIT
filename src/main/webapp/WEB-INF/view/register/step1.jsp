<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
		
		.auth {
		 padding: 10px;
		 width : 200px;
		 height : 50px;
		 margin: 10px;
		 border-radius: 20px;
		 border: groove;
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
<div style="text-align: center; padding-top: 100px;">
	<h2>휴대폰 인증</h2>
		<p>
		<label><p><strong>휴대폰 인증</strong>을 진행해주세요.</p>
		<input type="text" id = "phone" placeholder="휴대전화 '-' 없이 작성" class="auth"/>
				<button id="send" class = "auth" style="width: 90px; height: 40px; padding: 5px;
				background-color: #ff914d;">전송</button>
		<br /> <input type="text" id="signNum" placeholder="인증번호 6자리" class="auth"/> </label>
				<button id="check" class = "auth" style="width: 90px; height: 40px; padding: 5px;
				background-color: #ff914d;">인증</button>
		</p>
		<div id = "nextBtn" style="display: none">
		<form action ="/register/success" method="post">
		<input type = "hidden" value = "" id = "hidPhone" name = "phone">
		<input type = "submit" value = "다음 단계" class="auth" style="width: 180px; height: 60px; padding: 5px;"/>
		</form>
		</div>
</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    var signNum = ''; 
	`${ctxPath = pageContext.request.contextPath ; ''}`
    document.getElementById("send").addEventListener("click", function(event) {
    	let phonePattern = /^010\d{8}$/;
        let phoneValue = document.getElementById("phone").value;
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

        $.ajax({
            method: 'POST',
            url: `${ctxPath}/register/send`,
            data: {"phone": phoneValue},
            dataType: "json",
            success: function(res) {
                if (res.success) {
                    signNum = res.signNum;
                    alert("인증번호가 전송되었습니다.");
                } else {
                    alert("전송이 실패했습니다. 다시 시도하세요.");
                }
            }
        });
    });

    document.getElementById("check").addEventListener("click", function(event) {
        let signNumInput =  document.getElementById("signNum").value;
        let phone = document.getElementById("phone").value;
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
                    event.preventDefault();
                    alert("인증에 성공하였습니다.");
                    document.getElementById("hidPhone").value = phone;
                    document.querySelector('#nextBtn').style.display = "block";
                }
            }
        });
    });
});
</script>

</body>
</html>
