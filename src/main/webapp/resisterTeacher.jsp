<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙제마당 회원가입</title>
<link rel="icon" href="img/logo/favicon.ico">
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body{
	background: rgb(246, 249, 252);
}

#container {
	width: 800px;
	margin: 80px auto;
	text-align: center;
}

.inputBox:focus {
	outline: none;
}

.inputBox {
	width: 400px;
	height: 50px;
	font-size: 1.02em;
	margin: 10px;
	padding-left: 10px;
}

input {
	cursor: pointer;
}

#resisterBtn {
	width: 226px;
	height: 50px;
	border: 0px;
	background: rgb(69, 56, 40);
	color: #ddd;
	font-weight: bold;
	font-size: 1.3em;
	border-radius: 5px;
	margin: 30px 0 10px;
}

#resisterBox {
	margin: 0 auto 10px;
	padding: 25px 30px;
	width: fit-content;
	border-radius: 3px;
}

#warning {
	text-align: left;
	color: red;
	font-weight: bold;
	margin-top: 5px
}

.label {
	font-weight: bold;
	margin: 20px 0 0 10px;
}

.warning {
	color: red;
	margin-left: 10px;
}
.classInp{
	width: 50px;
}
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
	-webkit-appearance: none;
}
</style>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
<c:if test="${empty classList }">
	<jsp:forward page="classList.do">
		<jsp:param value="resisterStudent" name="url"/>
	</jsp:forward>
</c:if>
<c:forEach items="${classList }" var="clas" varStatus="ds">
	<c:if test="${clas.grade eq 1}"><c:set var="max_1" value="${clas.clas }"/></c:if>
	<c:if test="${clas.grade eq 2}"><c:set var="max_2" value="${clas.clas }"/></c:if>
	<c:if test="${clas.grade eq 3}"><c:set var="max_3" value="${clas.clas }"/></c:if>
	<c:if test="${clas.grade eq 4}"><c:set var="max_4" value="${clas.clas }"/></c:if>
	<c:if test="${clas.grade eq 5}"><c:set var="max_5" value="${clas.clas }"/></c:if>
	<c:if test="${clas.grade eq 6}"><c:set var="max_6" value="${clas.clas }"/></c:if>
</c:forEach>
	<div id="container">
		<form action="ResisterPro" method="post" name="resisterForm">
			<a href="index.jsp"><img id="logo" width="400px;" alt="LOGO" src="img/logo.png"></a>
			<div id="resisterBox">
				<div style="text-align: left;">
					<p class="label">아이디</p>
					<input class="inputBox" type="text" name="id" id="id">
					<p class="label">비밀번호</p>
					<input class="inputBox" type="password" name="pw" id="pw">
					<p class="label">비밀번호 확인</p>
					<input class="inputBox" type="password" id="pwRe">
					<p class="label">이름</p>
					<input class="inputBox" type="text" name="name" id="name">
					<p class="label">전화번호</p>
					<input class="inputBox" type="text" name="tel" id="tel">
					<p class="label">학급정보</p>
					
					<input class="inputBox classInp" type="number" name="grade" min="1" max="6" id="grade" value="1" onchange="setMax()">학년
					<input class="inputBox classInp" type="number" name="clas" min="1" max="1" id="clas" value="1">반
					<input class="inputBox classInp" type="number" name="num" min="1" max="50" id="num" value="1">번
					
					
					<p class="warning" id="gradeMessage"></p>
					<input type="checkbox" id="agree"
						style="margin-left: 10px; margin-top: 20px; width: 19px; height: 19px; vertical-align:bottom;">
					<span style="font-weight: bold;">약관동의(필수)</span>
					<p
						style="width: 400px; height: 100px; overflow: auto; margin: 10px; border: 1px solid black">
						숙제마당 서비스의 원활한 제공을 위하여 회원이 동의한 목적과 범위 내에서만 개인정보를 수집∙이용하며, 개인정보보호법에
						따라 휴먼웹툰 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 동의 거부권 및 동의
						거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다. 회원 가입 시에 ‘아이디,
						비밀번호, 이름, 전화번호, 학급정보’를 필수항목으로 수집합니다.</p>
					<p id="agreeMessage" style="color: red; margin-left: 10px"></p>
				</div>
				<input id="resisterBtn" type="button" value="회원가입">
			</div>
		</form>
	</div>
	<script type="text/javascript">
	//학년에 따른 반 설정 최대치 설정
	function setMax() {
		if($("#grade").val() == 1) $("#clas").attr("max", ${max_1});
		else if($("#grade").val() == 2) $("#clas").attr("max", ${max_2});
		else if($("#grade").val() == 3) $("#clas").attr("max", ${max_3});
		else if($("#grade").val() == 4) $("#clas").attr("max", ${max_4});
		else if($("#grade").val() == 5) $("#clas").attr("max", ${max_5});
		else if($("#grade").val() == 6) $("#clas").attr("max", ${max_6});
	}
	//최대치를 넘은 숫자를 기입할경우 최대치로 설정
	$(".classInp").change(function() {
		if($(this).val()-0 > $(this).attr("max")) $(this).val($(this).attr("max"))
		else if($(this).val()-0 < $(this).attr("min")) $(this).val($(this).attr("min"))
	});
	
</script>
</body>
</html>