<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 스프링 시큐리티 관련 태그 라이브러리 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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
				<div class="panel panel-danger">
					<div class="panel-heading">게시글을 수정합니다</div>
					<div class="panel-body">
						<form role="form" action="/board/modify" method="post">
							<!-- POST 방식의 전송은 반드시 CSRF 토큰값 추가 -->
							<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
							
							<!-- 페이지 정보 -->
							<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
							<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
							<!-- 검색 정보 -->
							<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
							<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
							
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
								<sec:authentication property="principal" var="pinfo"/>
									<sec:authorize access="isAuthenticated()">
										<c:if test="${pinfo.username eq board.writer }">
											<button data-oper='modify' class="btn btn-warning">수정</button>
											<button data-oper='remove' class="btn btn-danger">삭제</button>
										</c:if>
									</sec:authorize>
							
							</div>
						</form>
					</div>
					
					<!-- 첨부파일 목록 -->
					<div class="row">
						<div class="col-xs-12">
							<br /> <br />
							<div class="panel panel-danger">
								<div class="panel-heading">첨부파일</div>
								<div class="panel-body">
									<div class="form-group uploadDiv">
										<input type="file" name="uploadFile" multiple="multiple">
									</div>
									
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
	</div>
	
<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form");
		
		$("button").on("click", function(e){
			// 기본 동작 방지
			e.preventDefault();
			
			var operation = $(this).data("oper");

			if(operation === 'remove') {
				formObj.attr("action", "/board/remove");
			}else if(operation === 'list') {
				formObj.attr("action", "/board/list").attr("method", "get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				
				formObj.empty();
				
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			}else if(operation === 'modify'){
				var str = "";
				
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					
					str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("path") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + jobj.data("type") + "'>";
				});

				formObj.append(str).submit();
			}

			formObj.submit();
		});
	});
</script>
<script type="text/javascript">
	$(document).ready(function(){
		(function(){
			var bno = '<c:out value="${board.bno}"/>';

			$.getJSON("/board/getAttachList", { bno: bno }, function(arr){
				var str = "";
				
				$(arr).each(function(i, attach){
					// image type
					if(attach.fileType){
						var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);

						str += "<li data-path='" + attach.uploadPath + "'";
						str += " data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "'data-type='" + attach.fileType + "'";
						str += " ><div>"; 
						str += "<span> " + attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\'data-type='image' class='btn btn-warning btn-xs pull-right'><span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button><br>";
						str += "<img src='/display?fileName=" + fileCallPath + "'>";
						str += "</div></li>";
					} else {
						var fileCallPath = encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
						
						str += "<li ";
						str += "data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename= '" + attach.fileName + "' data-type='" + attach.fileType + "'><div>"; 
						str += "<span> " + attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\'data-type='file' class='btn btn-warning btn-xs btn-circle pull-right'><span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button><br>";
						str += "<img src='/resources/img/attach.png'></a>";
						str += "</div></li>";
					}
					
					$(".uploadResult ul").html(str);
				});
			});
		})(); // 즉시 실행함수

		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; // 5MB
		
		// 파일 확장자 및 크기 검사
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈를 초과하였습니다.")
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 확장자의 파일은 업로드할 수 없습니다.");
				return false;
			}
			
			return true;
		}
		
		// 파일업로드는 태그 내용이 변경되는 것을 감지해서 처리
		$("input[type='file']").change(function(e){
			var formData = new FormData();

			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
		
			for(var i=0;i<files.length;i++){
				if(!checkExtension(files[i].name, files[i].size)) return false;

				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType: 'json',
				success: function(result){
					showUploadResult(result);
				}
			});
		});
		
		// 업로드 결과 반영
		function showUploadResult(uploadResultArr){
			if(!uploadResultArr || uploadResultArr.length == 0) return;
			
			var uploadUL = $(".uploadResult ul");
			var str = "";
			
			$(uploadResultArr).each(function(i, obj){
				if(obj.fileType){
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					
					str += "<li data-path='" + obj.uploadPath + "'";
					str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'data-type='" + obj.fileType + "'";
					str += " ><div>"; 
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\'data-type='image' class='btn btn-warning btn-xs pull-right'><span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button><br>";
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div></li>";
				}else {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
				
					str += "<li ";
					str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename= '" + obj.fileName + "' data-type='" + obj.fileType + "'><div>"; 
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\'data-type='file' class='btn btn-warning btn-xs btn-circle pull-right'><span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div></li>";
				}
			});
			
			uploadUL.append(str);
		}
		
		// 수정화면에서 첨부파일 삭제처리는 화면에서만 반영
		$(".uploadResult").on("click", "button", function(e){
			if(confirm("Remove this file?")){
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});
	});
</script>

</body>
</html>