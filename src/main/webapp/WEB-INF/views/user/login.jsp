<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>login</title>
</head>
<body>

	<form action="/user/loginPost" method="post">
		<div class="form-group has feedback">
			<input type="text" name="uid" class="form-control" placeholder="ID">
			<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
		</div>
		
		<div class="form-group has-feedback">
			<input type="password" name="upw" class="form-control" placeholder="PW">
			<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
		</div>
		<div class="row">
			<div class="col-xs-8">
				<div class="checkbox icheck">
					<label>
						<input type="checkbox" name="useCookie">Remeber ME
					</label>
				</div>
			</div>
			<div class="col-xs-4">
				<button type="submit" class="btn btn-primary btn-block btn-flat">SIGN IN</button>
			</div>
		</div>
	</form>
	<form action="/user/signupform" method="get">
		<button type="submit" class="btn btn-primary btn-block btn-flat">SIGN UP</button>
	</form>

</body>
</html>