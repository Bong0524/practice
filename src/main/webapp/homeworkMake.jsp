<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<style>
#questTitle{
	width: 40%; 
	background: none; 
	font-size: 25px; 
	font-weight: bold; 
	border: none; 
	outline: none; 
	border-bottom: 1px solid white;
	color: white;
}
.selectText, .questText{
	border: none; 
	outline: none; 
	border-bottom: 1px solid #ccc;
	font-size: 20px;
	vertical-align: middle;
	width: 100%;
	resize: none;
	font-family: auto;
}
.selectText::-webkit-scrollbar, questText::-webkit-scrollbar{ 
	display:none;
}
.selectLabel{
	width: 50%;
	display: flex;
}	
.check:checked + label, .check:checked + label .selectText{
	color: red;
}
</style>
<form name="questForm" method="post" action="homeworkMake.do">
<h1 id="innerTitle" class="brown">
	<input type="text" name="title" id="questTitle" placeholder="숙제의 제목을 입력해주세요.">
	<input type="date" name="enDate" id="enDate" style="background: none; color: white; border: 1px solid black; font-size: 25px; float: right;">
	<select name="subject" id="subject">
		<option value="korean">국어</option>
		<option value="english">영어</option>
		<option value="math">수학</option>
		<option value="science">과학</option>
	</select>
</h1>
<div id="questBox" style="overflow: overlay" >
	<div id="makeQuestBtnBox" style="order: 1;">
		<select id="questKind">
			<option value=five>오지선다형</option>
			<option value="four">다답형</option>
			<option value="short">단답형</option>
			<option value="long">서술형</option>
		</select>
		<button onclick="makeQuest(); return false;" style="order: 1;">문제추가</button>
		<button onclick="deleteQuest(); return false;" style="order: 1;">문제삭제</button>
	</div>
	<button class="bottomBtn" onclick="makeHomework(); return false;">숙제등록</button>
</div>
</form>
<script type="text/javascript">
$("#subjectBookMark").css("display","none");
$("#enDate").attr("min", new Date().toISOString().split("T")[0]);

var questText = document.getElementsByClassName("questText");
var kind = document.getElementsByName("kind");

function deleteQuest() {
	$(".questBox"+(questNum-1)+"").remove();
	questNum--;
}
$("#subject").change(function() {
	$("#innerTitle").attr("class", $("#subject").val()); 
})
function makeHomework() {
	if(!$("#questTitle").val()){
		alert("해당 숙제의 제목을 입력해주세요.");
		$("#questTitle").focus();
		return;
	}else if(!$("#enDate").val() ){
		alert("해당 숙제의 마감시간을 정해주세요.");
		return;
	}else if(questNum <= 1){
		alert("적어도 하나의 문제를 작성 해주세요");
		return;
	}
	for(var i = 0 ; i < questText.length ; i++){
		if(!questText[i].value){
			questText[i].focus();
			alert("모든 문제를 작성 해주세요.");
			return;
		}
		if(kind[i].value == "five" || kind[i].value == "four"){
			var selectText = document.getElementsByName("selectText"+(i+1)+"");
			for(var j = 0 ; j < selectText.length ; j++){
				if(!selectText[j].value){
					alert("모든 문제를 작성 해주세요.");
					selectText[j].focus();
					return;
				}
			}
			var answer = 0;
			for(var j = 1 ; j <= ($("input[name="+(i+1)+"]").length) ; j++){
				if($("#"+(i+1)+"-"+j).prop("checked")) answer++;
			}
			if(answer < 1) {
				questText[i].focus();
				alert("정답을 설정해주세요.");
				return;
			}
		}
	}
	questForm.submit();
}





var questNum = 1;
function makeQuest(){
	if($("#questKind").val() == "five"){
		$("#questBox").append("<div style='display: flex; flex-wrap: wrap;' class='questBox"+questNum+" five quest'>");
			$(".questBox"+questNum+"").append("<div style='display: flex; width: 100%;' class='quest"+questNum+"'>");
				$(".quest"+questNum+"").append("<span style='width: 30px;'>"+questNum+".</span>");
				$(".quest"+questNum+"").append("<input type='hidden' value='five' name='kind'>");
				$(".quest"+questNum+"").append("<textarea name='questText' class = 'questText' rows='1'></textarea>");
			$(".questBox"+questNum+"").append("<div class='questImageBox'></div>");
			$(".questBox"+questNum+"").append("<div class='questSelect"+questNum+"' style='display: flex; flex-wrap: wrap; margin: 10px auto; width: 95%;'>");
				$(".questSelect"+questNum+"").append("<input type='radio' value='1' name='"+questNum+"' id='"+questNum+"-1' class='check'>");
				$(".questSelect"+questNum+"").append("<label class='selectLabel' for='"+questNum+"-1'>①<textarea name='selectText"+questNum+"' rows='1' class ='selectText'></textarea></label>");
				$(".questSelect"+questNum+"").append("<input type='radio' value='2' name='"+questNum+"' id='"+questNum+"-2' class='check'>");
				$(".questSelect"+questNum+"").append("<label class='selectLabel' for='"+questNum+"-2'>②<textarea name='selectText"+questNum+"' rows='1' class ='selectText'></textarea></label>");
				$(".questSelect"+questNum+"").append("<input type='radio' value='3' name='"+questNum+"' id='"+questNum+"-3' class='check'>");
				$(".questSelect"+questNum+"").append("<label class='selectLabel' for='"+questNum+"-3'>③<textarea name='selectText"+questNum+"' rows='1' class ='selectText'></textarea></label>");
				$(".questSelect"+questNum+"").append("<input type='radio' value='4' name='"+questNum+"' id='"+questNum+"-4' class='check'>");
				$(".questSelect"+questNum+"").append("<label class='selectLabel' for='"+questNum+"-4'>④<textarea name='selectText"+questNum+"' rows='1' class ='selectText'></textarea></label>");
				$(".questSelect"+questNum+"").append("<input type='radio' value='5' name='"+questNum+"' id='"+questNum+"-5' class='check'>");
				$(".questSelect"+questNum+"").append("<label class='selectLabel' for='"+questNum+"-5'>⑤<textarea name='selectText"+questNum+"' rows='1' class ='selectText'></textarea></label>");
	}else if($("#questKind").val() == "four"){
		$("#questBox").append("<div style='display: flex; flex-wrap: wrap;' class='questBox"+questNum+" four quest'>");
			$(".questBox"+questNum+"").append("<div style='display: flex; width: 100%;' class='quest"+questNum+"'>");
				$(".quest"+questNum+"").append("<span style='width: 30px;'>"+questNum+".</span>");
				$(".quest"+questNum+"").append("<input type='hidden' value='four' name='kind'>");
				$(".quest"+questNum+"").append("<textarea name='questText' class = 'questText' rows='1'></textarea>");
			$(".questBox"+questNum+"").append("<div class='questImageBox'></div>");
			$(".questBox"+questNum+"").append("<div class='questSelect"+questNum+"' style='display: flex; flex-wrap: wrap; margin: 10px auto; width: 95%; border: 1px solid black; padding: 5px;'>");
				$(".questSelect"+questNum+"").append("<input type='checkbox' value='ㄱ' name='"+questNum+"' id='"+questNum+"-1' class='check'>");
				$(".questSelect"+questNum+"").append("<label class='selectLabel' for='"+questNum+"-1'>ㄱ.<textarea name='selectText"+questNum+"' rows='1' class ='selectText'></textarea></label>");
				$(".questSelect"+questNum+"").append("<input type='checkbox' value='ㄴ' name='"+questNum+"' id='"+questNum+"-2' class='check'>");
				$(".questSelect"+questNum+"").append("<label class='selectLabel' for='"+questNum+"-2'>ㄴ.<textarea name='selectText"+questNum+"' rows='1' class ='selectText'></textarea></label>");
				$(".questSelect"+questNum+"").append("<input type='checkbox' value='ㄷ' name='"+questNum+"' id='"+questNum+"-3' class='check'>");
				$(".questSelect"+questNum+"").append("<label class='selectLabel' for='"+questNum+"-3'>ㄷ.<textarea name='selectText"+questNum+"' rows='1' class ='selectText'></textarea></label>");
				$(".questSelect"+questNum+"").append("<input type='checkbox' value='ㄹ' name='"+questNum+"' id='"+questNum+"-4' class='check'>");
				$(".questSelect"+questNum+"").append("<label class='selectLabel' for='"+questNum+"-4'>ㄹ.<textarea name='selectText"+questNum+"' rows='1' class ='selectText'></textarea></label>");
	}else if($("#questKind").val() == "short"){
		$("#questBox").append("<div style='display: flex; flex-wrap: wrap;' class='questBox"+questNum+" short quest'>");
			$(".questBox"+questNum+"").append("<div style='display: flex; width: 100%;' class='quest"+questNum+"'>");
				$(".quest"+questNum+"").append("<span style='width: 30px;'>"+questNum+".</span>");
				$(".quest"+questNum+"").append("<input type='hidden' value='five' name='short'>");
				$(".quest"+questNum+"").append("<textarea name='questText' class = 'questText' rows='1'></textarea>");
			$(".questBox"+questNum+"").append("<div class='questImageBox'></div>");
			$(".questBox"+questNum+"").append("<textarea name='"+questNum+"' rows='1' class ='selectText'></textarea>");
	}else if($("#questKind").val() == "long"){
		$("#questBox").append("<div style='display: flex; flex-wrap: wrap;' class='questBox"+questNum+" long quest'>");
			$(".questBox"+questNum+"").append("<div style='display: flex; width: 100%;' class='short quest"+questNum+"'>");
				$(".quest"+questNum+"").append("<span style='width: 30px;'>"+questNum+".</span>");
				$(".quest"+questNum+"").append("<input type='hidden' value='five' name='long'>");
				$(".quest"+questNum+"").append("<textarea name='questText' class = 'questText make' rows='1'></textarea>");
			$(".questBox"+questNum+"").append("<div class='questImageBox'></div>");
			$(".questBox"+questNum+"").append("<textarea name='"+questNum+"' disabled='disabled'></textarea>");
	}
	$("textarea").on('keydown keyup', function() {
		$(this).css('height', 'auto' );
		$(this).css("height", ""+(($(this).prop('scrollHeight')+1+'px')+""))
		if($("#questBox").prop("scrollWidth") > 1010){
			$(".questBox"+(i-1)+"").remove();
			questNum--;
		}
	});
	if($("#questBox").prop("scrollWidth") > 1010){
		$(".questBox"+questNum+"").remove();
		return;
	}
	questNum++;
};
</script>
