<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head><script src="assets/js/color-modes.js"></script>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="generator" content="Hugo 0.115.4">
    <title>시험 일정 조회</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/blog/">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

    <link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

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
            width : 150px;
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
    <link href="/assets/dist/css/blog.css" rel="stylesheet">
</head>
<body>


<div class="container">
    <header class="border-bottom lh-1 py-3">
        <div class="row flex-nowrap justify-content-between align-items-center">
            <div class="col-4 pt-1">

            </div>
            <div class="col-4 text-center">
                <a class="blog-header-logo text-body-emphasis text-decoration-none" href="/main">
                    <img src="img/ALLIT_IMG.png" alt="Logo" width="192.35" height="50.8" viewBox="0 0 118 94" class="d-block my-1">
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
    <h2>원서 접수 페이지</h2><br>
    <form action="apply" method="post">

    	<input type="hidden" value="${examDetail.infoNum }" name="infoNum">
        <h3><label>시험명 : ${examDetail.exName }</label></h3><br>
        <p><label>시험 날짜 : ${fn:substring(examDetail.infoDate,0,10) }</label></p>
        <p><label>시험장 위치 : ${examDetail.infoLoc }</label></p>
        <p><label>회차 정보 : ${examDetail.infoSeq }회차</label></p>
        <p><label>시험 상세 정보 : ${examDetail.info }</label></p>
        <p><label>검정료 : ${examDetail.infoPrice }</label></p>
        <p><label> 이름: <input type="text" name="name" value="${userName}" readonly="readonly"></label></p>
        <p><label> 전화번호: <input type="text" name="phone" value="${userPhone}" readonly="readonly"></label></p>
        
        <input class="applySubmit send" style="background-color: #ff914d;" type="submit">
    </form>

</div>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

    $('.applySubmit').click(function (){
        var confirmBtnVal = true;
        var confirmMsg = confirm("접수하시겠습니까?");
        if(!confirmMsg){
            confirmBtnVal = false;
        }
        return confirmBtnVal;
    })

</script>
</body>
</html>
