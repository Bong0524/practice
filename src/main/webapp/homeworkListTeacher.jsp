<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<style type="text/css">

</style>
<c:choose>
	<c:when test="${subject eq 'math' }"><c:set var="subjectString" value="수학"/></c:when>
	<c:when test="${subject eq 'korean' }"><c:set var="subjectString" value="국어"/></c:when>
	<c:when test="${subject eq 'science' }"><c:set var="subjectString" value="과학"/></c:when>
	<c:when test="${subject eq 'english' }"><c:set var="subjectString" value="영어"/></c:when>
</c:choose>
<h1 id="innerTitle" class="${empty subject ? 'brown' : subject}">${subjectString } 숙제마당(선생)
	<input type="button" value="숙제등록" onclick="makeHomeworkBtn(); return false;">
	<input type="button" value="학생관리" onclick="showStudentList(); return false;">
</h1>
<div id="homeworkList">
	<c:forEach items="${homeworkList }" var="homework">
		<div class="homework" onclick="openSubmitList('${homework.homeworkId}')">
			<h2 class="homeworkTitle ${homework.subject}">${homework.title }</h2>
			<div style="overflow: hidden; position: relative;">
				<img alt="과목이미지" src="img/${homework.subject}.png" width="200px;" style="padding: 10px;">
			</div>
			<c:choose>
				<c:when test="${homework.timeout <= 0 }"><p class="end remain">마감</p></c:when>
				<c:when test="${homework.timeout <= 1 }"><p class="tight remain">오늘까지!!</p></c:when>
				<c:when test="${homework.timeout <= 3 }"><p class="middle remain">${homework.timeout }일 남았어요!</p></c:when>
				<c:otherwise><p class="free remain">${homework.enDate}까지</p></c:otherwise>
			</c:choose>
		</div>
	</c:forEach>
</div>
<script type="text/javascript">
	function makeHomeworkBtn() {
		$("#section").load("homeworkMake.jsp");
	}
	function showStudentList() {
		var popup = window.open('userTeacher.do', '네이버팝업', 'width=700px,height=800px,scrollbars=yes');
	}
	
	
	
	
	$("#subjectBookMark").css("display","block");
	function clickMark(s) {
		$("#section").load("homeworkList.do", {filter : "${filter}", grade : "${grade}", clas : "${clas}", subject : s});
	}
</script>