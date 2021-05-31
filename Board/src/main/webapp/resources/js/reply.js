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
		var bno = param.bno;
		var page = param.page || 1;

		$.getJSON("/replies/pages/" + bno + "/" + page + ".json", 
				function(data){
			if(callback){
				// 댓글 목록만 가져오는 경우
				// callback(data); 
				
				// 댓글의 숫자와 목록을 가져오는 경우
				callback(data.replyCnt, data.list);
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
	
	// 시간에 대한 처리
	function displayTime(time){
		var today = new Date();
		var gap = today.getTime() - time;
		
		var dateObj = new Date(time);
		var str = "";
		
		// 오늘 등록된 댓글
		if(gap < (1000 * 60 * 60 * 24)){
			var hh = dateObj.getHours();
			var mm = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '': '0') + hh, ':', (mm > 9 ? '' : '0') + mm, ':', (ss > 9 ? '' : '0') + ss ].join('');
		}else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd ].join('');
		}
	}
	
	return { 
		add: add,
		get: get,
		getList: getList,
		update: update,
		remove: remove,
		displayTime: displayTime
	};
	
})();