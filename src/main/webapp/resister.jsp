<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.resisterTypeBtn{
	width: 40%;
	height: 70px;
	font-size: 20px;
	font-weight: bold;
}
.agree{
	margin-left: 10px; 
	width: 19px; 
	height: 19px; 
	vertical-align: sub;
}
</style>
</head>
<body>
<div style="width: 800px; margin: 100px auto;">
	<a href="index.jsp"><img id="logo" alt="LOGO" src="img/logo.png" style="margin: 0 auto; width: 400px; display: block"></a>
	<p style="font-weight: bold;">회원 약관</p>
	<p style="width: 800px; height: 100px; overflow: auto; border: 1px solid black">
		<strong>1. 개인정보의 수집항목</strong><br>
		숙제마당 홈페이지 회원에 가입하시면 더욱 더 다양한 서비스를 이용하실 수 있습니다. 
		우리 사이트는 정보통신망 이용촉진에 관한 법률 등 관련 법령에 따라 아래와 같이 이용자의 동의를 받은 후 회원가입을 받고 있습니다.
		<br><br>
		제1조 (목적)<br>
		이 약관은 숙제마당에서 제공하는 인터넷 관련 서비스(이하 “서비스”)를 이용함에 있어 이용자와 누리집의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.<br>
		제2조 (정의)<br>
		본 약관에서 사용하는 용어의 정의는 다음과 같습니다.<br>
		① 이용계약 : 서비스 이용과 관련하여 누리집과 이용자 간에 체결하는 계약<br>
		② 가입 : 누리집이 제공하는 신청서 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스 이용계약을 완료시키는 행위<br>
		③ 회원 : 누리집에 회원가입에 필요한 개인 정보를 제공하여 회원 등록을 한 자로서, 누리집의 정보 및 서비스를 이용할 수 있는 자<br>
		④ 이용자번호(ID) : 이용고객의 식별과 이용자가 서비스 이용을 위하여 이용자가 정하고 누리집이 승인하는 문자와 숫자의 조합<br>
		⑤ 비밀번호(PW) : 이용자가 등록회원과 동일인인지 신원을 확인하고 통신상의 자신의 개인정보보호를 위하여 이용자 자신이 정한 문자와 숫자의 조합
	</p>
	<label style="font-weight: bold;" for="agree1">약관동의(필수)</label>
	<input type="checkbox" id="agree1" class="agree">
	<p style="font-weight: bold;">필수 개인정보 수집동의</p>
	<p style="width: 800px; height: 100px; overflow: auto; border: 1px solid black">
		<strong>1. 개인정보의 수집항목</strong><br>
		숙제마당 홈페이지 회원 가입 시 회원 서비스 제공에 필요한 최소한의 정보를 수집하고 있으며 개인정보파일에 수집되는 항목은 다음과 같습니다.<br>
		&lt;회원가입&gt;<br>
		- 이름, 아이디, 본인 혹은 보호자의 연락처, 학급정보<br><br>
		
		<strong>2. 개인정보 수집목적</strong><br>
		숙제마당이 제공하는 맞춤화된 서비스의 이용을 위해 수집합니다. 
		숙자마당은 원칙적으로 이용자의 개인정보를 수집 및 이용 목적범위 내에서 처리하며, 
		이용자의 사전 동의 없이는 본래의 범위를 초과하여 처리하거나 제3자에게 제공하지 않습니다.
	</p>
	<label style="font-weight: bold;" for="agree2">개인정보 수집동의(필수)</label>
	<input type="checkbox" class="agree" id="agree2">
	<div style="display: flex; justify-content: space-around; margin-top: 20px;">
		<button onclick="resisterTypeBtn('Student'); return false;" class="resisterTypeBtn">학생 회원가입</button>
		<button onclick="resisterTypeBtn('Teacher'); return false;" class="resisterTypeBtn">교사 회원가입</button>
	</div>
</div>

<script type="text/javascript">
var agree = document.getElementsByClassName("agree");
function resisterTypeBtn(a) {
	for(var i = 0 ; i < agree.length ; i++){
		if(!agree[i].checked){
			alert("필수약관에 동의하셔야 가입하실 수 있습니다.");
			return;
		}
		location.href = "resister"+a+".jsp";
	}
}
</script>
</body>
</html>