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

.label {
	font-weight: bold;
	margin: 20px 0 0 10px;
}

#warning {
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
.hypen{
	font-size: 35px;
	line-height: 45px;	
}
.telInp{
	width: 25%;
	font-size: 1.02em;
	padding: 20px;
}
#telBox{
	width: 400px;
	height: 50px;
	font-size: 1.02em;
	margin: 10px;
	display: flex;
	justify-content: space-between;
}
.messageP{
	padding-left: 12px;
	color: red;
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
<%-- 각 학년별 최대 반 설정 --%>
<c:forEach items="${classList }" var="clas" varStatus="ds">
	<c:if test="${clas.grade eq 1}"><c:set var="max_1" value="${clas.clas }"/></c:if>
	<c:if test="${clas.grade eq 2}"><c:set var="max_2" value="${clas.clas }"/></c:if>
	<c:if test="${clas.grade eq 3}"><c:set var="max_3" value="${clas.clas }"/></c:if>
	<c:if test="${clas.grade eq 4}"><c:set var="max_4" value="${clas.clas }"/></c:if>
	<c:if test="${clas.grade eq 5}"><c:set var="max_5" value="${clas.clas }"/></c:if>
	<c:if test="${clas.grade eq 6}"><c:set var="max_6" value="${clas.clas }"/></c:if>
</c:forEach>
<div id="container">
	<form action="register.do" method="post" name="resisterForm">
		<a href="index.jsp"><img id="logo" width="400px;" alt="LOGO" src="img/logo.png"></a>
		<div id="resisterBox">
			<div style="text-align: left;">
				<p class="label">아이디*</p>
				<input class="inputBox" type="text" name="id" id="id">
				<p id="idMessage" class="messageP"></p>
				<p class="label">비밀번호*</p>
				<input class="inputBox" type="password" name="pw">
				<p id="pwMessage" class="messageP"></p>
				<p class="label">비밀번호 확인*</p>
				<input class="inputBox" type="password">
				<p id="pwReMessage" class="messageP"></p>
				<p class="label">이름*</p>
				<input class="inputBox" type="text" name="name">
				<p id="nameMessage" class="messageP"></p>
				<p class="label">보호자(부모님) 전화번호*</p>
				<div id="telBox">
					<input class="telInp" type="number" name="parent1"> <span class="hypen">-</span>
					<input class="telInp" type="number" name="parent2"> <span class="hypen">-</span>
					<input class="telInp" type="number" name="parent3">
				</div>
				<p id="telMessage" class="messageP"></p>
				<p class="label">학급정보*</p>
				
				<input class="inputBox classInp" type="number" name="grade" id="grade" min="1" max="6" value="1" onchange="setMax()">학년
				<input class="inputBox classInp" type="number" name="clas" id="clas" min="1" max="1" value="1">반
				<input class="inputBox classInp" type="number" name="num" id="num" min="1" max="50" value="1">번
				<p id="clasMessage" class="messageP"></p>
			</div>
			<input id="resisterBtn" type="button" value="회원가입">
			<p id="warning"></p>
		</div>
	</form>
</div>
<script type="text/javascript">
//학년에 따라 설정한 최대값으로 최대치 설정
function setMax() {
	if($("#grade").val() == 1) $("#clas").attr("max", ${max_1});
	else if($("#grade").val() == 2) $("#clas").attr("max", ${max_2});
	else if($("#grade").val() == 3) $("#clas").attr("max", ${max_3});
	else if($("#grade").val() == 4) $("#clas").attr("max", ${max_4});
	else if($("#grade").val() == 5) $("#clas").attr("max", ${max_5});
	else if($("#grade").val() == 6) $("#clas").attr("max", ${max_6});
}
//최대치를 넘은 숫자를 기입할경우 설정한 최대치로 설정
$(".classInp").change(function() {
	if($(this).val() - 0 > $(this).attr("max")) $(this).val($(this).attr("max"))
	else if($(this).val() - 0 < $(this).attr("min")) $(this).val($(this).attr("min"))
})
var overlap;
$("input[name=id]").change(function() {
	if($("#id").val() == ""){
		$("#idMessage").text("사용 불가능한 아이디 입니다.");
		$("#idMessage").css("color","red");
		return;
	}
	$.ajax({
		url:"http://localhost:8081/homework/register.do",
		type:"post",
		data:{
			id:$("#id").val(),
			how:"overlap"
		},
		success: function(data){
			overlap = data;
			console.log(overlap);
			if(data == 1){
				$("#idMessage").text("사용 불가능한 아이디 입니다.");
				$("#idMessage").css("color","red");
			}else{
				$("#idMessage").text("사용 가능한 아이디 입니다.");
				$("#idMessage").css("color","lime");
			}
		}
	})
})
</script>
</body>
</html>