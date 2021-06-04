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
								<br /> <br />
								<button type="submit" class="btn btn-primary">등록</button>
							</div>
						</form>
					</div>
				</div>

				<div class="panel panel-info">
					<div class="panel-heading">첨부파일</div>
					<div class="panel-body">
						<div class="form-group uploadDiv">
							<input type="file" name="uploadFile" multiple>
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

	<script>
		$(document).ready(function(){
			var formObj = $("form[role='form']");
			
			$("button[type='submit']").on("click", function(e){
				e.preventDefault();
				
				console.log("submit clicked !");
			});

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
			
			// 업로드 결과 반영
			function showUploadResult(uploadResultArr){
				if(!uploadResultArr || uploadResultArr.length == 0) return;
				
				var uploadUL = $(".uploadResult ul");
				var str = "";
				
				$(uploadResultArr).each(function(i, obj){
					if(obj.fileType){
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						
						str += "<li><div>";
						str += "<span> " + obj.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\'data-type='image' class='btn btn-warning btn-xs pull-right'><span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button><br>";
						str += "<img src='/display?fileName=" + fileCallPath + "'>";
						str += "</div></li>";
					}else {
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					
						str += "<li><div>";
						str += "<span> " + obj.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\'data-type='file' class='btn btn-warning btn-xs btn-circle pull-right'><span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button><br>";
						str += "<img src='/resources/img/attach.png'></a>";
						str += "</div></li>";
					}
				});
				
				uploadUL.append(str);
			}
			
			// 첨부파일 삭제 클릭 이벤트
			$(".uploadResult").on("click", "button", function(e){
				console.log("delete !");
				
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				
				var targetLi = $(this).closest("li");

				$.ajax({
					url: '/deleteFile',
					data: { fileName: targetFile, type: type },
					dataType: 'text',
					type: 'POST',
					success: function(result){
						alert(result);
						targetLi.remove();
					}
				});
			});
			
			// 태그 내용이 변경되는 것을 감지해서 처리
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
						console.log(result);
						
						showUploadResult(result);
					}
				});
			});
		});
	</script>

</body>
</html>