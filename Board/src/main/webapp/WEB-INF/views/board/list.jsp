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
		<div class="row">
			<br /> <br />

			<div class="jumbotron">
				<h1>게시판</h1>
				<p>Spring + MyBatis로 구현한 게시판</p>
			</div>
			<div class="alert alert-success" role="alert">
				새로운 게시글을 등록해주세요
				<button id="regBtn" type="button"
					class="btn btn-default col-xs-offset-9">글 등록</button>
			</div>
		</div>

		<table class="table table-hover">
			<tr class="info">
				<th>글 번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록일</th>
				<th>수정일</th>
			</tr>
			<c:forEach items="${list}" var="board">
				<tr>
					<td><c:out value="${board.bno}" /></td>
					<td><a href='/board/get?bno=<c:out value="${board.bno}" />'><c:out value="${board.title}" /></a></td>
					<td><c:out value="${board.writer}" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.regdate }" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.updateDate }" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<!-- 모달 -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">
						<i class="glyphicon glyphicon-ok" aria-hidden="true">&nbsp;</i>알림
					</h4>
				</div>
				<div class="modal-body">처리가 완료되었습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<script type="text/javascript">
		$(document).ready(
				function() {
					var result = '<c:out value="${result}"/>';

					checkModal(result);

					// 뒤로가기 제어 -> 브라우저 주소창에서 보관하고 있는 데이터를 제거
					history.replaceState({}, null, null);
					
					// 모달창 여부
					function checkModal(result) {
						if (result == '' || history.state)
							return;

						if (parseInt(result) > 0) {
							$(".modal-body").html(
									parseInt(result) + " 번 게시글이 등록되었습니다.");
						}

						$("#myModal").modal("show");
					}
	
					// 글 등록 버튼 클릭 이벤트 발생 시 페이지 이동
					$("#regBtn").on("click", function() {
						self.location = "/board/register";
					});
				});
	</script>

</body>
</html>