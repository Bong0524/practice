<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<style>

</style>

<img alt="stamp" src="img/stamp.png" style="height: 150px; width: 150px; z-index: 3; position: absolute; top: 10px; right: 30px;">
<h1 id="innerTitle" class="${homework.subject }">${homework.title } ${submission.num}번 ${submission.name }</h1>
<form id="questBox" name="confirmForm" action="homeworkTeacher.do" method="post">
	<input type="hidden" name="homeworkId" value="${homework.homeworkId }">
	<input type="hidden" name="studentId" value="${submission.id }">
	<c:forEach var="quest" items="${questList }" varStatus="status">
		<c:choose>
			<%--오지선다 --%>
			<c:when test="${quest.kind eq 'five' }">
				<div style="display: flex; flex-wrap: wrap;" class="quest five">
					<div style="display: flex; position: relative;">
						<input type="hidden" name="correctList" value="${submitQList[status.index].correct eq '1' ? '1' : '0'}">
						<img class="correctImg" alt="correct" src="img/${submitQList[status.index].correct eq '1' ? '' : 'in'}correct.png" ${!empty submitQList[status.index].correct ? "" : " style='display: none;'"}>
						<span style="width: 30px;" class="questNum">${status.count }.</span>
						<span style="word-break: keep-all;"> ${quest.quest }
							<input type="button" value="풀이" class="openExplan">
						</span>
						<div class="explanBox">
							<textarea class="explanText" name="explanList">${submitQList[status.index].explan }</textarea>
							<input type="button" value="닫기" class="closeExplan" style="display: block;">
						</div>
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
						<input type="hidden" name="correctList" value="${submitQList[status.index].correct eq '1' ? '1' : '0'}">
						<img class="correctImg" alt="correct" src="img/${submitQList[status.index].correct eq '1' ? '' : 'in'}correct.png" ${!empty submitQList[status.index].correct ? "" : " style='display: none;'"}>
						<span style="width: 30px;" class="questNum">${status.count }.</span>
						<span style="word-break: keep-all;"> ${quest.quest }							
							<input type="button" value="풀이" class="openExplan">
						</span>
						<div class="explanBox">
							<textarea class="explanText" name="explanList">${submitQList[status.index].explan }</textarea>
							<input type="button" value="닫기" class="closeExplan" style="display: block;">
						</div>
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
						<input type="hidden" name="correctList" value="${submitQList[status.index].correct eq '1' ? '1' : '0'}">
						<img class="correctImg" alt="correct" src="img/${submitQList[status.index].correct eq '1' ? '' : 'in'}correct.png" ${!empty submitQList[status.index].correct ? "" : " style='display: none;'"}>
						<span style="width: 30px;" class="questNum">${status.count }.</span>
						<span style="word-break: keep-all;"> ${quest.quest }							
							<input type="button" value="풀이" class="openExplan">
						</span>
						<div class="explanBox">
							<textarea class="explanText" name="explanList">${submitQList[status.index].explan }</textarea>
							<input type="button" value="닫기" class="closeExplan" style="display: block;">
						</div>
					</div>
					<div class="questImageBox"></div>
					<input type="text" class="answer" name="${status.index }" value="${submitQList[status.index].answer}" disabled="disabled" >
				</div>
			</c:when>
			<%--서술형 --%>
			<c:when test="${quest.kind eq 'long' }">
				<div class="quest long">
					<div style="display: flex;">
						<input type="hidden" name="correctList" value="${submitQList[status.index].correct eq '1' ? '1' : '0'}">
						<img class="correctImg" alt="correct" src="img/${submitQList[status.index].correct eq '1' ? '' : 'in'}correct.png" ${!empty submitQList[status.index].correct ? "" : " style='display: none;'"}>
						<span style="width: 30px;" class="questNum">${status.count }.</span>
						<span style="word-break: keep-all;"> ${quest.quest }							
							<input type="button" value="풀이" class="openExplan">
						</span>
						<div class="explanBox">
							<textarea class="explanText" name="explanList">${submitQList[status.index].explan }</textarea>
							<input type="button" value="닫기" class="closeExplan" style="display: block;">
						</div>
					</div>
					<div class="questImageBox"></div>
					<textarea class="answer" name="${status.index }" disabled="disabled" >${submitQList[status.index].answer }</textarea>
				</div>
			</c:when>
		</c:choose>
	</c:forEach>
	<button class="bottomBtn" onclick="submitConfirm(); return false;">채점완료</button>
</form>
<script type="text/javascript">
$("#subjectBookMark").css("display","none");
$(".questNum").click(function() {
	$(this).prev().css("display","block")
})
//클릭시 정답여부 변경
$(".correctImg").click(function() {
	if($(this).attr("src") == 'img/correct.png'){
		$(this).attr("src", 'img/incorrect.png');
		$(this).prev().val(0);
	}
	else if($(this).attr("src") == 'img/incorrect.png') {
		$(this).attr("src", 'img/correct.png');
		$(this).prev().val(1);
	}
})
$(".closeExplan").click(function(e) {
	e.preventDefault;
	$(this).parent().css("display", "none");
})
$(".openExplan").click(function(e) {
	e.preventDefault;
	$(this).parent().next().css("display", "block");
})
function submitConfirm() {
	confirm("채점을 끝내시겠습니까?") ? confirmForm.submit() : ""
}
</script>