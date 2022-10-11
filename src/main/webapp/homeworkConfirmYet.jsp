<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<style>

</style>


<div id="cover" style="z-index: 3; width: 100%; height: 100%; background-color: #00000055; position: absolute; top: 0; bottom: 0;"></div>

<%-- 교사가 확인하지 않았을 경우의 안내 메세지 --%>
<div style="z-index: 5; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; border-radius: 5px; overflow: hidden; width: 300px;"> 
	<h3 id="coverTitle" class="${homework.subject }">검토중이에요.</h3>
	<p style="word-break: keep-all; padding: 10px;">아직 선생님께서 숙제를 확인하지 않았어요. 조금만 더 기다려 볼까요?</p>
	<button style="margin: 0 100px 10px; width: 100px; height: 30px; " onclick="clickMenu('All'); return false;">돌아가기</button>
</div>
<h1 id="innerTitle" class="${homework.subject }">${homework.title }</h1>
<form id="questBox" name="resolveForm" action="homeworkSubmit.do" method="post">
	<input type="hidden" name="homeworkId" value="${homework.homeworkId }">
	<c:forEach var="quest" items="${questList }" varStatus="status">
		<c:choose>
			<%--오지선다 --%>
			<c:when test="${quest.kind eq 'five' }">
				<div style="display: flex; flex-wrap: wrap;" class="quest five">
					<div style="display: flex; position: relative;">
						<span style="width: 30px;">${status.count }.</span>
						<span style="word-break: keep-all;"> ${quest.quest }</span>
					</div>
					<div class="questImageBox"></div>
					<div style="display: flex; flex-wrap: wrap; margin: 10px auto; width: 95%;">
						<input type="radio" value="1" name="${status.index }" id="${quest.questNum }-1" class="check" disabled="disabled" 
						${submitQList[status.index].answer eq '1' ? "checked='checked'" : "" }>
						<label class="selectInQuest" for="${quest.questNum }-1">①${quest.first }</label>
						<input type="radio" value="2" name="${status.index }" id="${quest.questNum }-2" class="check" disabled="disabled" 
						${submitQList[status.index].answer eq '2' ? "checked='checked'" : "" }>
						<label class="selectInQuest" for="${quest.questNum }-2">②${quest.second }</label>
						<input type="radio" value="3" name="${status.index }" id="${quest.questNum }-3" class="check" disabled="disabled" 
						${submitQList[status.index].answer eq '3' ? "checked='checked'" : "" }>
						<label class="selectInQuest" for="${quest.questNum }-3">③${quest.third }</label>
						<input type="radio" value="4" name="${status.index }" id="${quest.questNum }-4" class="check" disabled="disabled" 
						${submitQList[status.index].answer eq '4' ? "checked='checked'" : "" }>
						<label class="selectInQuest" for="${quest.questNum }-4">④${quest.fourth }</label>
						<input type="radio" value="5" name="${status.index }" id="${quest.questNum }-5" class="check" disabled="disabled" 
						${submitQList[status.index].answer eq '5' ? "checked='checked'" : "" }>
						<label class="selectInQuest" for="${quest.questNum }-5">⑤${quest.fifth }</label>
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
						
						<input type="checkbox" value="ㄱ" name="${status.index }" id="${quest.questNum }-1" class="check" disabled="disabled" 
						${fn:contains(submitQList[status.index].answer, 'ㄱ') ? "checked='checked'" : "" }>
						<label class="selectInQuest" for="${quest.questNum }-1">ㄱ. ${quest.first }</label>
						<input type="checkbox" value="ㄴ" name="${status.index }" id="${quest.questNum }-2" class="check" disabled="disabled" 
						${fn:contains(submitQList[status.index].answer, 'ㄴ') ? "checked='checked'" : "" }>	
						<label class="selectInQuest" for="${quest.questNum }-2">ㄴ. ${quest.second }</label>
						<input type="checkbox" value="ㄷ" name="${status.index }" id="${quest.questNum }-3" class="check" disabled="disabled" 
						${fn:contains(submitQList[status.index].answer, 'ㄷ') ? "checked='checked'" : "" }>	
						<label class="selectInQuest" for="${quest.questNum }-3">ㄷ. ${quest.third }</label>
						<input type="checkbox" value="ㄹ" name="${status.index }" id="${quest.questNum }-4" class="check" disabled="disabled" 
						${fn:contains(submitQList[status.index].answer, 'ㄹ') ? "checked='checked'" : "" }>	
						<label class="selectInQuest" for="${quest.questNum }-4">ㄹ. ${quest.fourth }</label>
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
					<input type="text" class="answer" name="${status.index }" value="${submitQList[status.index].answer}" disabled="disabled">
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
					<textarea class="answer" name="${status.index }" disabled="disabled">${submitQList[status.index].answer }</textarea>
				</div>
			</c:when>
		</c:choose>
	</c:forEach>
	<button class="bottomBtn" onclick="clickMenu('All'); return false;">돌아가기</button>
</form>
<script type="text/javascript">
$("#subjectBookMark").css("display","none");
</script>