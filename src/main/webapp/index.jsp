<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴먼초등학교 숙제마당</title>
<link rel="icon" href="img/favicon.ico"> 
<link href="css/designSheet.css" rel="stylesheet">
<style type="text/css">
/* https://610e2c3380568900398f148d-ulwliiyqae.chromatic.com/?path=/docs/chunks-participants--default */
/* https://www.flaticon.com/kr/packs/back-to-school-83 */
</style>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer">
	</script>
</head>
<body style="display: flex; background: rgb(246, 249, 252); height: 100vh; min-width: 1520px;">
	<jsp:include page="menuLeft.jsp"/>
	<section id="section"></section>
	<jsp:include page="menuRight.jsp"/>
	<script type="text/javascript">
	<%if(request.getAttribute("homeworkId") != null){%>
		$("#section").load("homeworkTeacher.do", {homeworkId : ${homeworkId}});
	<%}else{%>
		clickMenu('All');
	<%}%>
	function clickMenu(f,g,c) {
		$("#section").load("homeworkList.do", {filter : f, grade : g, clas : c});
	}
	function openHomework(homeworkId) {
		$("#section").load("homeworkOpen.do", {homeworkId : homeworkId, how : "open"});
	}
	function resolveHomework(homeworkId) {
		$("#section").load("homeworkOpen.do", {homeworkId : homeworkId, how : "resolve"});
	}
	function subjectBookMark() {
		$("#homeworkBookMark").css("display","none");
		$("#subjectBookMark").css("display","block");
	}
	function homeworkBookMark() {
		$("#subjectBookMark").css("display","none");
		$("#homeworkBookMark").css("display","block");
	}
	function openSubmitList(homeworkId) {
		$("#section").load("homeworkTeacher.do", {homeworkId : homeworkId});
	}
	function openSubmission(homeworkId, studentId) {
		$("#section").load("homeworkTeacher.do", {homeworkId : homeworkId, studentId : studentId});
	}
	</script>
</body>
</html>