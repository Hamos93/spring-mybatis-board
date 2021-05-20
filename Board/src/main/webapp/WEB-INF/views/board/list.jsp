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
					<td><a class='move' href='<c:out value="${board.bno}" />'><c:out
								value="${board.title}" /></a></td>
					<td><c:out value="${board.writer}" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.regdate }" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.updateDate }" /></td>
				</tr>
			</c:forEach>
		</table>

		<!-- 검색창 -->
		<div class="row">
			<form class="form-inline" id="searchForm" action="/board/list"
				method="get">
				<select class="form-control" name="type">
					<option value="T"
						<c:out value="${pageMaker.cri.type eq 'T' ? 'selected':'' }"/>>제목</option>
					<option value="C"
						<c:out value="${pageMaker.cri.type eq 'C' ? 'selected':'' }"/>>내용</option>
					<option value="W"
						<c:out value="${pageMaker.cri.type eq 'W' ? 'selected':'' }"/>>작성자</option>
					<option value="TC"
						<c:out value="${pageMaker.cri.type eq 'TC' ? 'selected':'' }"/>>제목
						+ 내용</option>
					<option value="TW"
						<c:out value="${pageMaker.cri.type eq 'TW' ? 'selected':'' }"/>>제목
						+ 작성자</option>
					<option value="TWC"
						<c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected':'' }"/>>제목
						+ 작성자 + 내용</option>
				</select> <input class="form-control" type="text" name="keyword"
					style="width: 400px;"
					value='<c:out value="${pageMaker.cri.keyword }"/>'> <input
					type="hidden" value="${pageMaker.cri.pageNum }"> <input
					type="hidden" value="${pageMaker.cri.amount }">
				<button class="btn btn-default">검색</button>
			</form>
		</div>
		<!-- /.row -->

		<!-- 페이지네이션 -->
		<div class='pull-right'>
			<ul class="pagination">

				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous"><a
						href="${pageMaker.startPage - 1}">이전</a></li>
				</c:if>

				<c:forEach var="num" begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }">
					<li
						class="paginate_button ${pageMaker.cri.pageNum == num ? 'active': '' }"><a
						href="${num }">${num }</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next }">
					<li class="paginate_button next"><a
						href="${pageMaker.endPage + 1}">다음</a></li>
				</c:if>
			</ul>
			<form id="actionForm" action="/board/list" method="get">
				<input type="hidden" name="pageNum"
					value="${pageMaker.cri.pageNum }"> <input type="hidden"
					name="amount" value="${pageMaker.cri.amount }">

				<!-- 페이지 이동 시에도 검색 데이터와 함께 전송 -->
				<input type="hidden" name="type" value="${pageMaker.cri.type }">
				<input type="hidden" name="keyword"
					value="${pageMaker.cri.keyword }">
			</form>
		</div>
		<!-- end Pagination -->
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
		$(document)
				.ready(
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
											parseInt(result)
													+ " 번 게시글이 등록되었습니다.");
								}

								$("#myModal").modal("show");
							}

							// 글 등록 버튼 클릭 이벤트 발생 시 페이지 이동
							$("#regBtn").on("click", function() {
								self.location = "/board/register";
							});

							// 페이지 버튼 이동
							var actionForm = $("#actionForm");
							$(".paginate_button a").on(
									"click",
									function(e) {
										e.preventDefault();

										actionForm
												.find("input[name='pageNum']")
												.val($(this).attr("href"));
										actionForm.submit();
									});

							// 게시물 클릭 시 페이징 정보와 함께 전송
							$(".move")
									.on(
											"click",
											function(e) {
												e.preventDefault();
												actionForm
														.append("<input type='hidden' name='bno' value='"
																+ $(this).attr(
																		"href")
																+ "'>");
												actionForm.attr("action",
														"/board/get");
												actionForm.submit();
											});

							// 검색 버튼 클릭 이벤트
							var searchForm = $("#searchForm");
							$("#searchForm button")
									.on(
											"click",
											function(e) {

												if (!searchForm
														.find(
																"input[name='keyword']")
														.val()) {
													alert("검색 키워드를 입력하세요.");
													return false;
												}

												searchForm
														.find(
																"input[name='pageNum']")
														.val(1);
												e.preventDefault();

												searchForm.submit();
											});

						});
	</script>

</body>
</html>