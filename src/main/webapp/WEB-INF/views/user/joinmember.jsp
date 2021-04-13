<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<br><br>
	
	<div class="container ">
		<h1 class="text-info">회원가입</h1>
		<br>
<!-- 		<form role="form" action="/user/signup" method="post"> -->
			
			<div class="row">			
			<div class="form-group">
				<label for="uid" class="control-label col-lg-1">ID </label>
				<div class="col-lg-5">
				<input type="text" id="uid" name="uid" class="form-control" placeholder="ID">
				</div>
				<button class="btn btn-default" id="chkid">중복체크</button>
			</div>
			</div>
			<br>
			
			<div class="row">
				<div class="form-group">
					<label for="upw" class="control-label col-lg-1">Password </label>
					<div class="col-lg-5">
					<input type="password" id="upw" name="upw" class="form-control" placeholder="PASSWORD">
					</div>
				</div>	
			</div>
			<br>
			
			<div class="row">
				<div class="form-group">
					<label for="uname" class="control-label col-lg-1">Nickname </label>
					<div class="col-lg-5">
					<input type="text" id="uname" name="uname" class="form-control" placeholder="NICKNAME">
					</div>
				</div>
			</div>
			
			<br>
<!-- 			<button class="btn btn-primary" type="submit">COMPLETE</button> -->
<!-- 		</form> -->
	
	</div>
	<script type="text/javascript">
	$(document).ready(function() {
		var temp = "";
// 		function checkId() {			
// 			$.getJSON("/check/" + uid, function(data) {
// 				tempid = data.uid;
// 			})
// 		} 
		
		$("#chkid").on("click", function() {
			var uid = $("#uid").val();
			
			console.log(uid)
// 			var tempid= "";
			
// 			$.getJSON("/check/" + uid, function(data) {
// 				console.log(data);
// 			})
			
			
// 			if(tempid === uid) {
// 				alert("이미 등록된 ID입니다!")
// 			}
			
			
			$.ajax({
				type : 'post',
				url : '/check/' + uid,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				success : function(result) {
					console.log(result);
					if(result.uid == uid) {
						alert("이미 존재하는 ID입니다!");
						$("#uid").val("");
					} else {
						temp = "readonly"
					}
				},
				
				
				
			});
		});
	});
	</script>
</body>
</html>