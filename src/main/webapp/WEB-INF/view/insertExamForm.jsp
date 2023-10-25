<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    ${ctxPath = pageContext.request.contextPath ; ''}
    <script src="${ctxPath }/assets/js/color-modes.js"></script>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="generator" content="Hugo 0.115.4">
    <title>시험 일정 조회</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/blog/">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

    <link href="${ctxPath }/assets/dist/css/bootstrap.min.css" rel="stylesheet">

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

        .send{
            padding: 1px;
            width : 100px;
            margin: 1px;
            border-radius: 20px;
            border: groove;
            text-align: center;
        }
        #side_left {float:left;width: 20%; line-height: 600px; height: 600px; background-color: #039be5;}
        #contents {float: left; width : 60%; line-height:600px;height: 600px; background-color: #03a9f4;}
        #side_right {float:left; width:20%; line-height: 600px; height: 600px; background-color: #29b6f6;}
        #footer {clear:both;width:auto; height :0px; }
    </style>


    <!-- Custom styles for this template -->
    <link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
    <!-- Custom styles for this template -->
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
</div>
<div style="margin: 30px 50px 30px 300px;">
    <h1>시험회차 정보 입력</h1><br>
    <form action="insertSuccess" method="post">
        <label for="exname">시험 이름:</label>
        <select id="exNum" name="exNum">
        <c:forEach var="list" items="${examsList}" varStatus="num">
        	<option value="${list.exNum }">${list.exName }</option>
		</c:forEach>
        </select><br><br>
        
        <label for="infoDate">시험 날짜:</label>
        <input type="date" id="infoDate" name="infoDate" required><br><br>
        
        <label for="info">시험 상세:</label>
        <textarea id="info" name="info" rows="4" cols="50" required></textarea><br><br>

        <label for="infoStart">접수 시작일:</label>
        <input type="date" id="infoStart" name="infoStart" required><br><br>
        
        <label for="infoEnd">접수 종료일:</label>
        <input type="date" id="infoEnd" name="infoEnd" required><br><br>
        
        <label for="infoLoc">시험 장소:</label>
        <input type="text" id="infoLoc" name="infoLoc" required><br><br>
        
        <label for="infoSeq">회차:</label>
        <input type="number" id="infoSeq" name="infoSeq" readonly="true" required><br><br>
        
        <label for="infoPrice">검정료:</label>
        <input type="number" id="infoPrice" name="infoPrice" required><br><br>
        
        <input type="submit" class="send" style="background-color: #ff914d;" id="examInsertBtn" value="등록">
    </form>
</div>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

$('#backToSchedule').click(function(){
	location.href = "/schedule";
});

$('#examInsertBtn').click(function(){
	var infoDate = $('#infoDate').val();
	var infoStart = $('#infoStart').val();
	var infoEnd = $('#infoEnd').val();
	
	if(infoStart > infoEnd){
		alert('접수 기간 확인');
        return false;
	}else if(infoDate < infoEnd){
		alert('시험 날짜 확인');
        return false;
	}
	
	console.log($('#exNum').val());
	console.log($('#infoDate').val());
});

$('#exNum').change(function (){
    var thisExNum = $(this).val();
    $.ajax({
        data: JSON.stringify({ exNum: parseInt(thisExNum) }), // 정수로 변환
        url: "/applyCheck/nextSeq",
        type: "POST",
        contentType: "application/json",
        success: function (data) {
           console.log("data > "+data);
           $('#infoSeq').val(data);
        },
        error: function() {
            alert("Error occurred");
        }
    });
})

$(document).ready(function (){
    $('#exNum').trigger('change');
})

</script>
</body>
</html>
