<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Naver Smart Editor 2.0 -->
<script type="text/javascript" src="/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
#write-outer {
	padding: 20px 28% 20px 28%;
	}
</style>



</head>
<body>
	<jsp:include page="../header/header.jsp"/>
	<div id="write-outer" align="">
		<label>제목</label><br>
		<div class="ui input">
			<input type="text" name="b_title" style="height: 30px; width: 689px;">
		</div><br><br>		
		<label>내용</label><br>
		<textarea name="b_content" id="content" rows="10" cols="100"></textarea>
	
	</div>

</body>

<script type="text/javascript">
	var oEditors = [];
	$(function(){
		nhn.husky.EZCreator.createInIFrame({
		 oAppRef: oEditors,
		 elPlaceHolder: "content",
		 sSkinURI: "/se2/SmartEditor2Skin.html",
		 htParams : {
             // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
             bUseToolbar : true,             
             // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
             bUseVerticalResizer : true,     
             // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
             bUseModeChanger : true,         
             fOnBeforeUnload : function(){
             }
         },
		 fCreator: "createSEditor2"
		});
	});
</script>
</html>