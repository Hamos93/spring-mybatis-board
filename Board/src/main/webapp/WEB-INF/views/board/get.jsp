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

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

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

.uploadResult {
	width: 100%;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 200px;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100%;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>

</head>
<body>
	<div class="container">
		<br /> <br />
		<div class="row">
			<div class="col-lg-10 col-lg-offset-1">
				<div class="panel panel-warning">
					<div class="panel-heading">게시글을 조회합니다</div>
					<div class="panel-body">
						<div class="form-group col-lg-9 col-lg-offset-1">
							<br /> <label>번호</label> <input type="text" class="form-control"
								name="title" value='<c:out value="${board.bno }"/>'
								readonly="readonly">
						</div>
						<div class="form-group col-lg-9 col-lg-offset-1">
							<br /> <label>제목</label> <input type="text" class="form-control"
								name="title" value='<c:out value="${board.title }"/>'
								readonly="readonly">
						</div>
						<div class="form-group col-lg-9 col-lg-offset-1">
							<br /> <label>내용</label>
							<textarea class="form-control" name="content" rows="10"
								readonly="readonly"><c:out value="${board.content }" /></textarea>
						</div>
						<div class="form-group col-lg-9 col-lg-offset-1">
							<br /> <label>작성자</label>
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon1"><span
									class="glyphicon glyphicon-user"></span></span><input type="text"
									class="form-control" name="writer"
									value='<c:out value="${board.writer }"/>' readonly="readonly">
							</div>
						</div>
						<div class="col-lg-9 col-lg-offset-1">
							<br /> <br />
							<button data-oper='list' class="btn btn-primary">목록</button>
							<button data-oper='modify' class="btn btn-warning">수정</button>

							<form id='operForm' action="/board/modify" method="get">
								<input type='hidden' id='bno' name='bno'
									value='<c:out value="${board.bno }"/>'>
								<!-- 페이지 정보 -->
								<input type='hidden' name='pageNum'
									value='<c:out value="${cri.pageNum }"/>'> <input
									type='hidden' name='amount'
									value='<c:out value="${cri.amount }"/>'>
								<!-- 검색 정보 -->
								<input type="hidden" name="type"
									value='<c:out value="${cri.type }"/>'> <input
									type="hidden" name="keyword"
									value='<c:out value="${cri.keyword }"/>'>
							</form>
						</div>
					</div>

					<!-- 첨부파일 목록 -->
					<div class="row">
						<div class="col-xs-12">
							<br /> <br />
							<div class="panel panel-warning">
								<div class="panel-heading">첨부파일</div>
								<div class="panel-body">
									<div class="uploadResult">
										<ul>

										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 댓글 -->
		<div class="row">
			<div class="col-lg-10 col-lg-offset-1">
				<div class="panel panel-default">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-comment" aria-hidden="true"></span>&nbsp;댓글
						<button id="addReplyBtn" type="button"
							class="btn btn-primary btn-xs pull-right" aria-label="Left Align">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</button>
					</div>
					<div class="panel-body">
						<ul class="chat list-unstyled">
							<li data-rno="12">
								<div>
									<div class="header">
										<strong></strong> <small class="pull-right text-muted">
										</small>
									</div>
									<p></p>
								</div>
							</li>
						</ul>
					</div>

					<!-- 댓글 페이징 -->
					<div class="panel-footer"></div>
				</div>
			</div>
		</div>
	</div>

	<!-- 첨부파일 원본이미지 -->
	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>

	<!-- 댓글 등록 모달 -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">
						<i class="glyphicon glyphicon-ok" aria-hidden="true">&nbsp;</i>댓글
						등록
					</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>댓글</label> <input class="form-control" name="reply"
							value="새로운 댓글">
					</div>
					<div class="form-group">
						<label>작성자</label> <input class="form-control" name="replyer"
							value="댓글러">
					</div>
					<div class="form-group">
						<label>등록일</label> <input class="form-control" name="replyDate"
							value="">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				</div>
				<div class="modal-footer">
					<button id="modalModifyBtn" type="button" class="btn btn-warning">수정</button>
					<button id="modalRemoveBtn" type="button" class="btn btn-danger">삭제</button>
					<button id="modalRegisterBtn" type="button" class="btn btn-primary">등록</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<script type="text/javascript">
		$(document).ready(function() {
			var operForm = $("#operForm");

			$("button[data-oper='list']").on("click", function(e) {
				operForm.find("#bno").remove();
				operForm.attr("action", "/board/list");
				operForm.submit();
			});

			$("button[data-oper='modify']").on("click", function(e) {
				operForm.attr("action", "/board/modify").submit();
			});
		});
	</script>

	<!-- 첨부파일 관련 JavaScript -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							(function() {
								var bno = '<c:out value="${board.bno}"/>';

								$
										.getJSON(
												"/board/getAttachList",
												{
													bno : bno
												},
												function(arr) {
													console.log(arr);

													var str = "";

													$(arr)
															.each(
																	function(i,
																			attach) {
																		if (attach.fileType) {
																			var fileCallPath = encodeURIComponent(attach.uploadPath
																					+ "/s_"
																					+ attach.uuid
																					+ "_"
																					+ attach.fileName);

																			str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-fileName='" + attach.fileName + "' data-type='" + attach.fileType + "'><div>";
																			str += "<img src='/display?fileName="
																					+ fileCallPath
																					+ "'>";
																			str += "</div></li>";
																		} else {
																			str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-fileName='" + attach.fileName + "' data-type='" + attach.fileType + "'><div>";
																			str += "<span> "
																					+ attach.fileName
																					+ "</span><br/>"
																			str += "<img src='/resources/img/attach.png'>";
																			str += "</div></li>";
																		}
																	});

													$(".uploadResult ul").html(
															str);
												});
							})(); // 즉시 실행 함수

							// 업로드 결과 클릭 이벤트
							$(".uploadResult")
									.on(
											"click",
											"li",
											function(e) {
												var liObj = $(this);

												var path = encodeURIComponent(liObj
														.data("path")
														+ "/"
														+ liObj.data("uuid")
														+ "_"
														+ liObj
																.data("filename"));

												if (liObj.data("type")) {
													showImage(path.replace(
															new RegExp(/\\/g),
															"/"));
												} else {
													self.location = "/download?fileName="
															+ path;
												}
											});

							function showImage(fileCallPath) {
								$(".bigPictureWrapper").css("display", "flex")
										.show();

								$(".bigPicture").html(
										"<img src='/display?fileName="
												+ fileCallPath + "'>").animate(
										{
											width : '100%',
											height : '100%'
										}, 1000);
							}
							
							$(".bigPictureWrapper").on("click", function(e){
								$(".bigPicture").animate({ width: '0%', height: '0%' }, 1000);
								setTimeout(function(){
									$('.bigPictureWrapper').hide();
								}, 1000);
							});
						});
	</script>

	<!-- 댓글 처리 관련 JavaScript -->
	<script type="text/javascript" src="/resources/js/reply.js"></script>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var bnoValue = '<c:out value="${board.bno}"/>';
							var replyUL = $(".chat");

							showList(1);

							// 댓글 목록 조회
							function showList(page) {
								console.log("[ 댓글목록 조회 ]: " + page);

								replyService
										.getList(
												{
													bno : bnoValue,
													page : page || 1
												},
												function(replyCnt, list) {
													console.log("replyCnt: "
															+ replyCnt);
													console
															.log("list: "
																	+ list);

													if (page == -1) {
														pageNum = Math
																.ceil(replyCnt / 10.0);
														showList(pageNum);
														return;
													}

													var str = "";

													if (list == null
															|| list.length == 0) {
														return;
													}

													for (var i = 0, len = list.length || 0; i < len; i++) {
														str += "<li data-rno='" + list[i].rno + "'>";
														str += "	<div><div class='header'><strong>"
																+ list[i].replyer
																+ "</strong>";
														str += "		<small class='pull-right text-muted'>"
																+ replyService
																		.displayTime(list[i].replyDate)
																+ "</small></div>";
														str += "		<p>"
																+ list[i].reply
																+ "</p></div></li>";
													}

													replyUL.html(str);

													// 댓글 페이징
													showReplyPage(replyCnt);
												});
							}

							// 댓글 페이징 처리
							var pageNum = 1;
							var replyPageFooter = $(".panel-footer");

							function showReplyPage(replyCnt) {
								var endNum = Math.ceil(pageNum / 10.0) * 10;
								var startNum = endNum - 9;

								var prev = startNum != 1;
								var next = false;

								if (endNum * 10 >= replyCnt)
									endNum = Math.ceil(replyCnt / 10.0);

								if (endNum * 10 < replyCnt)
									next = true;

								var str = "<div><ul class='pagination pull-right'>";

								if (prev) {
									str += "<li class='page-item'><a class='page-link' href='"
											+ (startNum - 1) + "'>이전</a></li>";
								}

								for (var i = startNum; i <= endNum; i++) {
									var active = pageNum == i ? "active" : "";

									str += "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'>"
											+ i + "</a></li>";
								}

								if (next) {
									str += "<li class='page-item'><a class='page-link' href='"
											+ (endNum + 1) + "'>다음</a></li>";
								}

								str += "</ul></div>";
								replyPageFooter.html(str);
							}

							// 페이지 번호 클릭 이벤트
							replyPageFooter.on("click", "li a", function(e) {
								e.preventDefault();

								var targetPageNum = $(this).attr("href");

								pageNum = targetPageNum;

								showList(pageNum);
							});

							// 댓글 모달
							var modal = $(".modal");
							var modalInputReply = modal
									.find("input[name='reply']");
							var modalInputReplyer = modal
									.find("input[name='replyer']");
							var modalInputReplyDate = modal
									.find("input[name='replyDate']");

							var modalModifyBtn = $("#modalModifyBtn");
							var modalRemoveBtn = $("#modalRemoveBtn");
							var modalRegisterBtn = $("#modalRegisterBtn");

							$("#addReplyBtn")
									.on(
											"click",
											function() {
												modal.find("input").val("");
												modalInputReplyDate.closest(
														"div").hide();
												modal
														.find(
																"button[id != 'modalCloseBtn']")
														.hide();

												modalRegisterBtn.show();

												$(".modal").modal("show");
											});

							// 댓글 등록 클릭 이벤트
							modalRegisterBtn.on("click", function(e) {
								var reply = {
									reply : modalInputReply.val(),
									replyer : modalInputReplyer.val(),
									bno : bnoValue
								};

								replyService.add(reply, function(result) {
									alert(result);

									modal.find("input").val("");
									modal.modal("hide");

									// 새로운 댓글 등록 후 댓글 목록의 마지막 페이지로 이동
									showList(-1);
								});
							});

							// 댓글 조회 클릭 이벤트 -> 이벤트 위임
							$(".chat")
									.on(
											"click",
											"li",
											function(e) {
												var rno = $(this).data("rno");

												replyService
														.get(
																rno,
																function(reply) {
																	modalInputReply
																			.val(reply.reply);
																	modalInputReplyer
																			.val(reply.replyer);
																	modalInputReplyDate
																			.val(
																					replyService
																							.displayTime(reply.replyDate))
																			.attr(
																					"readonly",
																					"readonly");

																	// 수정 및 삭제를 위해 모달에 속성 추가
																	modal
																			.data(
																					"rno",
																					reply.rno);

																	modal
																			.find(
																					"button[id != 'modalCloseBtn']")
																			.hide();
																	modalModifyBtn
																			.show();
																	modalRemoveBtn
																			.show();

																	$(".modal")
																			.modal(
																					"show");
																});
											});

							// 댓글 수정 클릭 이벤트
							modalModifyBtn.on("click", function(e) {
								var reply = {
									rno : modal.data("rno"),
									reply : modalInputReply.val(),
									replyer : modalInputReplyer.val()
								};
								console.log(reply);

								replyService.update(reply, function(result) {
									alert(result);

									modal.modal("hide");

									showList(pageNum);
								});
							})

							// 댓글 삭제 클릭 이벤트
							modalRemoveBtn.on("click", function(e) {
								var rno = modal.data("rno");

								replyService.remove(rno, function(result) {
									alert(result);

									modal.modal("hide");

									showList(pageNum);
								});
							});
						});
	</script>

</body>
</html>