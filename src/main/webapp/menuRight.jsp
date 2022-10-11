<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 과목선택 책갈피 -->
<div style="z-index: 1; width: 150px; position: relative; display: none;" id="subjectBookMark">
	<div class="bookmarkDiv" onclick="clickMark('korean')">
		<p class="bookmarkP">국어</p>
		<img src="img/redmark.png" alt="redmark" class="bookmarkImg">
	</div>
	<div class="bookmarkDiv" style="top: 80px;" onclick="clickMark('english')">
		<p class="bookmarkP">영어</p>
		<img src="img/yellowmark.png" alt="yellowmark" class="bookmarkImg">
	</div>
	<div class="bookmarkDiv" style="top: 160px;" onclick="clickMark('math')">
		<p class="bookmarkP">수학</p>
		<img src="img/greenmark.png" alt="greenmark" class="bookmarkImg">
	</div>
	<div class="bookmarkDiv" style="top: 240px;" onclick="clickMark('science')">
		<p class="bookmarkP">과학</p>
		<img src="img/bluemark.png" alt="bluemark" class="bookmarkImg">
	</div>
	<div class="bookmarkDiv" style="top: 320px;" onclick="clickMark()">
		<p class="bookmarkP">전체</p>
		<img src="img/purplemark.png" alt="purplemark" class="bookmarkImg">
	</div>
</div>
<script type="text/javascript">
	$(".bookmarkDiv").mouseenter(function() {
		$(this).css("margin-left", "0");
	})
	$(".bookmarkDiv").mouseleave(function() {
		$(this).css("margin-left", "-20px");
	})
</script>