<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<style>
</style>
<h1 id="innerTitle" class="${homework.subject }">${homework.title }</h1>
<div id="questBox">
	<c:forEach items="${questList }" var="quest" varStatus="status">
		<c:choose>
			<%--오지선다 --%>
			<c:when test="${quest.kind eq 'five' }">
				<div style="display: flex; flex-wrap: wrap;" class="quest five">
					<div style="display: flex;">
						<span style="width: 30px;">${status.count }.</span>
						<span style="word-break: keep-all;"> ${quest.quest }</span>
					</div>
					<div class="questImageBox"></div>
					<div style="display: flex; flex-wrap: wrap; margin: 10px auto; width: 95%;">
						<span class="selectInQuest">①${quest.first }</span>
						<span class="selectInQuest">②${quest.second }</span>
						<span class="selectInQuest">③${quest.third }</span>
						<span class="selectInQuest">④${quest.fourth }</span>
						<span class="selectInQuest">⑤${quest.fifth }</span>
					</div>
				</div>
			</c:when>
			<%--다답형 --%>
			<c:when test="${quest.kind eq 'four' }">
				<div style="display: flex; flex-wrap: wrap;" class="quest four">
					<div style="display: flex;">
						<span style="width: 30px;">${status.count }.</span>
						<span style="word-break: keep-all;"> ${quest.quest }</span>
					</div>
					<div class="questImageBox"></div>
					<div style="display: flex; flex-wrap: wrap; margin: 10px auto; width: 95%; border: 1px solid black; padding: 5px;">
						<span class="selectInQuest">ㄱ. ${quest.first }</span>
						<span class="selectInQuest">ㄴ. ${quest.second }</span>
						<span class="selectInQuest">ㄷ. ${quest.third }</span>
						<span class="selectInQuest">ㄹ. ${quest.fourth }</span>
					</div>
				</div>
			</c:when>
			<%--단답형 --%>
			<c:when test="${quest.kind eq 'short' }">
				<div class="quest short">
					<div style="display: flex;">
						<span style="width: 30px;">${status.count }.</span>
						<span style="word-break: keep-all;"> ${quest.quest }</span>
					</div>
					<div class="questImageBox"></div>
				</div>
			</c:when>
			<%--서술형 --%>
			<c:when test="${quest.kind eq 'long' }">
				<div class="quest long">
					<div style="display: flex;">
						<span style="width: 30px;">${status.count }.</span>
						<span style="word-break: keep-all;"> ${quest.quest }</span>
					</div>
					<div class="questImageBox"></div>
				</div>
			</c:when>
		</c:choose>
	</c:forEach>
	<button class="bottomBtn" onclick="resolveHomework('${homework.homeworkId}')">문제풀기</button>
</div>
<script type="text/javascript">
	$("#subjectBookMark").css("display","none");
</script>