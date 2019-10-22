<form action="" class="form">
    <p>(*) 항목은 반드시 입력해 주세요.</p>
    <ul>
        <li>
            <label for="uid">ID(*):</label>
            <input id="uid" />
            영문, 숫자, 언더스코어(_), 하이픈(-)이 포함된 3~16 문자.
        </li>
        <li>
            <label for="upw">PW(*):</label>
            <input id="upw" type="password" />
            영문, 숫자, 언더스코어(_), 하이픈(-)이 포함된 6~18 문자.
        </li>
        <li>
            <label for="mail">Email(*):</label>
            <input id="mail" value="@" />
        </li>
        <li>
            <label for="url">Web(*):</label>
            <input id="url" value="http://" />
        </li>
        <li>
            <label for="tel">Tel(*):</label>
            <input id="tel" />
            하이픈(-)은 입력하지 마세요.
        </li>
    </ul>
    <input type="submit" value="전송" />
</form>
 
<script type="text/javascript">
$(document).ready(function(){
	var RegexEmail = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i; //이메일 요휴성검사
	var RegexName = /^[가-힣]{2,4}$/; //이름 유효성 검사 2~4자 사이
	var RegexId = /^[a-z0-9_-]{3,16}$/; //아이디 유효성 검사 316자 사이
	var RegexTel = /^[0-9]{8,11}$/; //전화번호 유효성 검사
	
	$("form").submit(function(){

		if ( !RegexName.test($.trim($("#uId").val())) )
		{
			alert("이름 오류");
			$("#name").focus();
			return false;
		}

		if ( !RegexName.test($.trim($("#uPw").val())) )
		{
			alert("아이디 오류");
			$("#id").focus();
			return false;
		}	

		if ( !RegexEmail.test($.trim($("#email").val())) )
		{
			alert("이메일 오류");
			$("#email").focus();
			return false;
		}
	
	});

});
</script>