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

<title>게시글 등록</title>

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
				<div class="panel panel-danger">
					<div class="panel-heading">게시글을 수정합니다</div>
					<div class="panel-body">
						<form role="form" action="/board/modify" method="post">
							<div class="form-group col-lg-9 col-lg-offset-1">
								<br /> <label>번호</label> <input type="text"
									class="form-control" name="bno"
									value='<c:out value="${board.bno }"/>' readonly="readonly">
							</div>
							<div class="form-group col-lg-9 col-lg-offset-1">
								<br /> <label>제목</label> <input type="text"
									class="form-control" name="title"
									value='<c:out value="${board.title }"/>'>
							</div>
							<div class="form-group col-lg-9 col-lg-offset-1">
								<br /> <label>내용</label>
								<textarea class="form-control" name="content" rows="10"><c:out
										value="${board.content }" /></textarea>
							</div>
							<div class="form-group col-lg-9 col-lg-offset-1">
								<br /> <label>작성자</label>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1"><span
										class="glyphicon glyphicon-user"></span></span><input type="text"
										class="form-control" name="writer"
										value='<c:out value="${board.writer }" />' readonly="readonly">
								</div>
							</div>
							<div class="form-group col-sm-3 col-sm-offset-1">
								<br /> <label>등록일</label>
								<div class="input-group">
									<input type="text" class="form-control" name="regDate"
										value='<fmt:formatDate pattern ="yyyy/MM/dd" value="${board.regdate }" />'
										readonly="readonly">
								</div>
							</div>
							<div class="form-group col-sm-3 col-sm-offset-1">
								<br /> <label>수정일</label>
								<div class="input-group">
									<input type="text" class="form-control" name="updateDate"
										value='<fmt:formatDate pattern ="yyyy/MM/dd" value="${board.updateDate }" />'
										readonly="readonly">
								</div>
							</div>
							
							<div class="col-lg-9 col-lg-offset-1">
								<br /> <br />
								<button data-oper='list' class="btn btn-primary">목록</button>
								<button data-oper='modify' class="btn btn-warning">수정</button>
								<button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form");
		
		$("button").on("click", function(e){
			// 기본 동작 방지
			e.preventDefault();
			
			var operation = $(this).data("oper");

			if(operation === 'remove') {
				console.log("=-0-===========================================");
				formObj.attr("action", "/board/remove");
			}else if(operation === 'list') {
				formObj.attr("action", "/board/list").attr("method", "get");
				formObj.empty();
			}
			
			formObj.submit();
		});
	});
</script>
	
</body>
</html>