<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<style>

</style>
<h1 id="innerTitle" class="${homework.subject }">${homework.title }</h1>
<form id="questBox" name="resolveForm" action="homeworkSubmit.do" method="post">
	<input type="hidden" name="homeworkId" value="${homework.homeworkId }">
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
						<input type="radio" value="1" name="${status.index }" id="${quest.questNum }-1" class="check">
						<label class="selectInQuest" for="${quest.questNum }-1">①${quest.first }</label>
						<input type="radio" value="2" name="${status.index }" id="${quest.questNum }-2" class="check">
						<label class="selectInQuest" for="${quest.questNum }-2">②${quest.second }</label>
						<input type="radio" value="3" name="${status.index }" id="${quest.questNum }-3" class="check">
						<label class="selectInQuest" for="${quest.questNum }-3">③${quest.third }</label>
						<input type="radio" value="4" name="${status.index }" id="${quest.questNum }-4" class="check">
						<label class="selectInQuest" for="${quest.questNum }-4">④${quest.fourth }</label>
						<input type="radio" value="5" name="${status.index }" id="${quest.questNum }-5" class="check">
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
						<input type="checkbox" value="ㄱ" name="${status.index }" id="${quest.questNum }-1" class="check">	
						<label class="selectInQuest" for="${quest.questNum }-1">ㄱ. ${quest.first }</label>
						<input type="checkbox" value="ㄴ" name="${status.index }" id="${quest.questNum }-2" class="check">	
						<label class="selectInQuest" for="${quest.questNum }-2">ㄴ. ${quest.second }</label>
						<input type="checkbox" value="ㄷ" name="${status.index }" id="${quest.questNum }-3" class="check">	
						<label class="selectInQuest" for="${quest.questNum }-3">ㄷ. ${quest.third }</label>
						<input type="checkbox" value="ㄹ" name="${status.index }" id="${quest.questNum }-4" class="check">	
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
					<input type="text" class="answer" name="${status.index }">
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
					<textarea class="answer" name="${status.index }"></textarea>
				</div>
			</c:when>
		</c:choose>
	</c:forEach>
	<input type="button" value="돌아가기" class="bottomBtn" onclick="openHomework('${homework.homeworkId}'); return false;">
	<input type="button" value="제출하기" onclick="submitBtn(); return false;">
</form>
<script type="text/javascript">
	$("#subjectBookMark").css("display","none");
	function submitBtn() {
		 for(var i = 1 ; i <= ${fn:length(questList)} ; i++){
			if($("input[name="+i+"]").length == 1) {
				if(!$("input[name="+i+"]").val()){
					alert("모든 문제를 풀어주세요.");
					return;
				}
			}else if($("input[name="+i+"]").length > 1){
				if($("input[name="+i+"]:checked").length == 0){
					alert("모든 문제를 풀어주세요.");
					return;
				}
			}
		}
		resolveForm.submit();
	}
</script>