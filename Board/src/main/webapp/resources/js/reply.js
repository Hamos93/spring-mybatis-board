/* 댓글 관련 자바스크립트 모듈 파일 */
/* [ 모듈 패턴 ] */
//- Java의 클래스처럼 JavaScript를 이용해서 메서드를 가지는 객체를 구성
//- 모듈 패턴은 JavaScript의 즉시 실행함수와 { }를 이용해서 객체를 구성
//- 즉시 실행하는 함수 내부에서 필요한 메서드를 구성해서 객체를 구성

console.log("Reply Module !");

var replyService = (function(){

	// 등록 처리
	function add(reply, callback, error){
		$.ajax({
			type: 'post',
			url: '/replies/new',
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}

	// 조회 처리
	function get(rno, callback, error){
		$.get("/replies/" + rno + ".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, er){
			if(error){
				error();
			}
		});
	}
	
	// 목록 처리
	function getList(param, callback, error){
		var page = param.page || 1;

		$.getJSON("/replies/pages/" + bno + "/" + page + ".json", 
				function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	// 수정 처리
	function update(reply, callback, error){
		$.ajax({
			type: 'put',
			url: '/replies/' + reply.rno,
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	// 삭제 처리
	function remove(rno, callback, error){
		$.ajax({
			type: 'delete',
			url: '/replies/' + rno,
			success: function(deleteResult, status, xhr){
				if(callback) {
					callback(deleteResult);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	return { 
		add: add,
		get: get,
		getList: getList,
		update: update,
		remove: remove
	};
	
})();