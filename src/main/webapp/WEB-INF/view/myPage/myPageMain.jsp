<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
      
      button{width: 150px; 
      height: 60px; 
      padding: 10px;
      border: groove #ff914d;
      margin: 20px;
	  
	  }
	  
	  .btn{
	  margin: 10px;
	  border-radius: 20px;
	  }
	  
	  table{
	  border-collapse: collapse;
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
 	<title>ALLIT</title>
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
<h3><strong>${member.memberName}</strong>님의 정보입니다.</h3><hr/>
   <c:if test = "${authUser.userId ne 'admin'}">
   <select id = "select" style="margin: 10px; width: 250px; height: 30px; border: groove;">
   <option value = "999">-----빠른 메뉴-----</option>
   <option value = "/myQna">내가 쓴 문의글</option>
   <option value = "/myTest"> 최근 접수한 시험</option>
   </select>
   <button id = "btn" style="width: 60px; border-radius: 50%; border: groove white;">
   <strong>클릭</strong></button>
   <div id ="result"></div>
   <hr/>
   </c:if>
   <div style="margin: 50px; font-size: 20px;">
      <p><strong>아이디 :</strong> ${member.memberId}</p>
      <p><strong>휴대전화 :</strong> ${phone}<br/></p>
      <p><strong>가입일 :</strong>
   <fmt:parseDate value="${member.memberDate}" pattern="yyyy-MM-dd" var="patientDob" type="date"/>
   <fmt:formatDate pattern="yyyy년 MM월 dd일" value="${patientDob}"/></p>
     </div> 
     <div>
      <c:if test="${authUser.userId ne 'admin'}">
      <a href="/edit/deleteMyInfo" class = "btn"><button style="border-radius: 20px;">회원 탈퇴하기</button></a>
      </c:if>
      <a href="/edit/ChangeForm" class = "btn"><button style="border-radius: 20px;">개인정보 수정</button></a>
      <a href="${pageContext.request.contextPath}/main" class = "btn"><button style="border-radius: 20px;">메인화면</button></a>
   </div>

</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#btn").click(function () {
            let destination = '';
            let select = $("#select");
            let option = select.val();
            let result = $("#result");
            let memberNum = `${authUser.memberNum}`

            $.ajax({
                method: 'POST',
                url: `${pageContext.request.contextPath}/edit/quickMenu`,
                data: {"option": option},
                success: function (res) {
                    if (res === 'myPage/myTest') {
                        destination = 'myPage/myTest';
                    } else if (res === 'myPage/myQna') {
                        destination = 'myPage/myQna';
                    } else {
                        destination = 'myPage/myPageMain';
                    }

                    if (destination === 'myPage/myTest') {
                        $.ajax({
                            method: 'POST',
                            url: `${pageContext.request.contextPath}/edit/myTest`,
                            data: {"memberNum": memberNum},
                            dataType : "json",
                            success: function (map1) {
                                if (map1.success) {
                                   console.log(map1.list);
                                    let table = "<table border =1>";
                                    table += "<tr><th>시험 이름</th><th>시험 일자</th><th>접수 취소</th></tr>";
                                    for (let i = 0; i < map1.list.length; i++) {
                                        let item = map1.list[i];
                                        table += "<tr>";
                                        table += "<td><a href=\"/schedule/examDetail?infoNum="+item.infoNum+"\">" + item.exName + "</a></td>";
                                        const formattedDate = new Date(item.infoDate).toISOString().split('T')[0];
                                        table += "<td>" + formattedDate + "</td>";

                                        table += "<td><button class= \"cBtn\" value = "+item.meNum+">취소</button></td>"
                                        table += "</tr>";
                                    }
                                    table += "</table>";
                                    $("#result").html(table);
                                    
                                    $(".cBtn").click(function () {
                                    	let result = confirm("정말 접수를 취소하시겠습니까?");
                                    	console.log(this.value);
                                    	let meNum = this.value;
                                    	if(result == true){
                                            $.ajax({
                                                method: 'POST',
                                                url: `${pageContext.request.contextPath}/edit/deleteExam`,
                                                data: {"meNum": meNum},
                                                dataType : "json",
                                                success: function (res) {
                                                	alert("접수 취소가 완료되었습니다.");
                                                	location.reload();
                                                }
                                            });
                                    	}
                                    });
                                } else {
                                    alert("조회된 데이터가 없습니다.");
                              }
                        }
                    });
                }
                    else if (destination === 'myPage/myQna') {
                        $.ajax({
                            method: 'POST',
                            url: `${pageContext.request.contextPath}/edit/myQna`,
                            data: {"memberNum": memberNum},
                            dataType : "json",
                            success: function (map2) {
                        if (map2.success) {
                        	console.log(map2.list);
                             let table = "<table border =1>";
                             table += "<tr><th>제목</th><th>문의 일자</th><th>조회수</th></tr>";
                             for (let i = 0; i < map2.list.length; i++) {
                               let item = map2.list[i];
                               table += "<tr>";
                               table += "<td><a href=\"/qna/read?no="+item.qnum+"\"/>" + item.qtitle + "</td>";
                               table += "<td>" + item.qdate + "</td>";
                               table += "<td>" + item.qhits + "</td>";
                               table += "</tr>";
                              }
                               table += "</table>";
                                 $("#result").html(table);
                            } else {
                               alert("조회된 데이터가 없습니다.");
                               }
                            }
                        });
                    }
                }
            });
        });
    });
</script>
</body>
</html>