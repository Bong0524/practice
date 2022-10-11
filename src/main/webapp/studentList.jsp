<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>${user.grade }학년 ${user.clas }반 학생목록</h1>
<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>부모님 전화번호</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${studentList }" var="student">
			<tr>
				<td>${student.num }</td>
				<td>${student.name }</td>
				<td>${student.tel }</td>
				<td>${student.parent }</td>
			</tr>
		</c:forEach>	
	</tbody>
</table>
</body>
</html>