<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>게시판</title>

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- 구글 웹 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Song+Myung&display=swap"
	rel="stylesheet">

<style>
* {
	font-family: 'Song Myung', serif;
}
</style>

</head>
<body>
	<div class="container">
		<br /> <br />
		<div class="row">
			<div class="col-lg-10 col-lg-offset-1">
				<div class="panel panel-info">
					<div class="panel-heading">게시글을 등록합니다</div>
					<div class="panel-body">
						<form role="form" action="/board/register" method="post">
							<div class="form-group col-lg-9 col-lg-offset-1">
								<br /> <label>제목</label> <input type="text"
									class="form-control" name="title" placeholder="제목을 입력하세요">
							</div>
							<div class="form-group col-lg-9 col-lg-offset-1">
								<br /> <label>내용</label>
								<textarea class="form-control" name="content" rows="10"
									placeholder="글 내용을 입력하세요"></textarea>
							</div>
							<div class="form-group col-lg-9 col-lg-offset-1">
								<br /> <label>작성자</label>

								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1"><span
										class="glyphicon glyphicon-user"></span></span><input type="text"
										class="form-control" name="writer" placeholder="작성자를 입력하세요">
								</div>
							</div>
							<div class="form-group col-lg-9 col-lg-offset-1">
							<br/><br/>
							<button type="submit" class="btn btn-primary">등록</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>