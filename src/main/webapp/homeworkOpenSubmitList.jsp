<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<style>
tr {
height: 40px;	
}
</style>
<h1 id="innerTitle" class="${homework.subject }">${homework.title } 제출자 명단</h1>
<table border="1" style="border-collapse: collapse; margin: 60px auto; width: 1000px; border-radius: 10px; overflow: hidden; border: 3px solid white;" id="submitListTable">
	<thead>
		<tr class="brown">
			<th>번호</th>
			<th>이름</th>
			<th>제출일</th>
			<th>확인여부</th>
		</tr>
	</thead>
	<tbody style="cursor: pointer;">
		<c:forEach items="${submitList }" var="submission">
			<tr style="text-align: center;"
			<c:if test="${!empty submission.subDate }">
				onclick="openSubmission('${submission.homeworkId}','${submission.id}')"
			</c:if>>
				<td>${submission.num }</td>
				<td>${submission.name }</td>
				<td>${!empty submission.subDate ? submission.subDate : '-'}</td>
				<td>${submission.confirm}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<script type="text/javascript">
$("#subjectBookMark").css("display","none");
</script>
