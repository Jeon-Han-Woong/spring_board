<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<style type="text/css">
	#modDiv {
		width: 300px;
		height: 100px;
		background-color: yellow;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-top: -50px;
		margin-left: -150px;
		padding: 10px;
		z-index: 1000;
	}
	
	#uploadResult {
		width: 100%;
		background-color: gray;
	}
	#uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	#uploadResult ul li {
		list-style: none;
		padding: 10px;
		align-content: center;
		text-align: center;
	}
	#uploadResult ul li img {
		width: 100px;
	}
</style>
<title>get.jsp</title>
</head>
<body>
	
	<div class="container">
	<h1 class="m-3">상세하게 보기</h1>
		<div class="row">
			<h2 class="m-3 text-primary">${board.bno}번 글</h2>
			<h3 class="text-info">${cri.page }페이지</h3>
			<form class="m-3 form-group">
				<input type="hidden" name="bno" value="${board.bno}"/>
				<input type="hidden" name="page" value="${cri.page}"/>
				<input type="hidden" name="searchType" value="${cri.searchType}"/>
				<input type="hidden" name="keyword" value="${cri.keyword}"/>
				작성자<input class="form-control col-md-5" type="text" readonly value="${board.writer}"><br>
				제목<input class="form-control" type="text" readonly value="${board.title}"><br>
				본문<br>
				<textarea class="form-control" readonly>${board.content}</textarea><br>
				작성일자<input class="form-control" type="text" readonly value="${board.regdate}"><br>
				수정일자<input class="form-control" type="text" readonly value="${board.updatedate}"><br>
					
	<%-- 			<a href="/board/modify?bno=${get.bno}" id="btn_update" role="button" class="btn btn-success">수정</a> --%>
	<%-- 			<a href="/board/remove?bno=${get.bno}" id="btn_delete" role="button" class="btn btn-danger">삭제</a> --%>
	<!-- 			<a href="/board/list" id="btn_update" role="button" class="btn btn-primary">목록</a> -->
				
				<!-- 가변적으로 action(목표 url)속성을 바꿔주기 위해서 data-oper 속성을 이용해
					 어떤 버튼을 눌렀는지 함께 정보가 제공되도록 사용. -->
					 <c:if test="${login.uname == board.writer}">
					<button type="submit"
							data-oper="modify"
							class="btn btn-success manabutton">수정</button>
					<button type="submit"
							data-oper="remove"
							class="btn btn-danger manabutton">삭제</button>
					 </c:if>
					<a href="/board/list?page=${cri.page}&searchType=${cri.searchType}&keyword=${cri.keyword}"
						class="btn btn-primary">목록</a>	
			</form>
			
			
		</div>
			<div class="row">
				<h3 class="text-primary">첨부파일</h3>
				<div id="uploadResult">
					<ul>
					</ul>
				</div>
			</div>
			
			<div class="row box-box-success">
				<c:if test="${!empty login}">
				<div class="box-header">
					<h2 class="text-primary">댓글 작성</h2>
				</div>
				<div class="box-body">
					<strong>Writer</strong>
					<input type="text" id="newReplyer" value="${login.uname}" readonly class="form-control">
					<strong>ReplyText</strong>
					<input type="text" id="newReplyText" placeholder="ReplyText" class="form-control">
				</div>
				
				</c:if>
			
			</div>
			
			<div class="row">
				<div class="box-footer">
					<button type="button" class="btn btn-success" id="replyAddBtn">Add Reply</button>
				</div>
			</div>
			
			<div class="row mt-3">
						
				<c:if test="${empty login}">
					<br>
					<a href="/user/login" type="button" class="btn btn-primary col-md-3">로그인 하러가기</a>
				</c:if>
			</div>	
			
			
			
			<div class="row">
				<h3 class="text-primary">댓글</h3>
				<div id="replies">
				
				</div>
			</div>
			<div id="modDiv" style="display:none;">
				<div class="modal-title"></div>
				<div>
					<input type="text" id="replytext">
				</div>
				<div>
					<button type="button" id="replyModBtn">Modify</button>
					<button type="button" id="replyDelBtn">Delete</button>
					<button type="button" id="closeBtn">Close</button>
				</div>
			</div>
	</div>

		
</body>
<!--  통상적으로 Javascript 코드는 페이지 제일 마지막에 기술.
이유는 맨 위에 작성할 경우, 자바스크립트 코드가 모두 파싱되어야 그 때부터 html코드가 그려지기 시작하기 때문에
사용자 입장에서 파싱이 늦어지면 사이트가 느리다고 느낄 수 있다.
자바 스크립트 코드는 <script></script> 태그 사이에 입력하게 되며
스크립트릿과 마찬가지로 html코드 사이에 html이 아닌 코드를 삽입하기 위해서 사용한다. -->
	<script type="text/javascript">
		// 페이지가 로딩되자마자 버튼 감지 사전주비를 위해
		// 아래와 같이 작성.
		// $(document).ready() 내부의 코드는
		// 페이지가 로딩되는 순간 바로 실행.
		$(document).ready(function() {
			
			// j query 작동 확인
			// alert("제이 쿼리 작동!");
			// form 태그를 불러온다.
			var formObj = $("form");
			
			
			// form태그의 내용 확인
			// console.log(formObj);
			
			// .attr은 해당 태그의 속성값을 설정.
			// .("속성명", "대입할 속성") 순으로 작성.
			// form태그의 action(목적주소)를
			// www.dndndnd.com 으로 변경.
 			// formObj.attr("action", "http://www.dndndnd.com");
			// console.log(formObj);
			
			// 페이지 로딩 완료가 아닌 버튼 클릭시 감지해야 하므로
			// 버튼 클릭 이벤트 처리.
			$(".manabutton").on("click", function(e) {
				// 버튼 클릭시 submit으로 설정되어 있어서
				// 의도와 상관없이 바로 submit을 진행.
				// 따라서 그걸 막기 위해 코드 추가
				e.preventDefault();
				
// 				var operation = $(this).data("oper");
// 				console.log(operation);
				
				formObj.attr("method", "post");
				if ($(this).data("oper") === "remove"){
					formObj.attr("action", "remove")
				} else if($(this).data("oper") === "modify") {
					formObj.attr("action", "modify")
				}
				formObj.submit();
			});
			
			// 감지 로직
			var myname = "${login.uname}";
			var bno = ${board.bno};
			function getAllList(){
				$.getJSON("/replies/all/" + bno, function(data) {
					
					console.log(data.length);
					console.log("=================");
					console.log(data);
					var str = "";
					$(data).each(function() {
						console.log(data);
						var timestamp = this.updatedate;
						var date = new Date(timestamp);
						
						var formattedTime = "게시일 : " + date.getFullYear()
											+ "/" + (date.getMonth()+1)
											+ "/" + date.getDate();
						
						
						
						if(myname === this.replyer){
							
							str += "<div class='replyLi' data-rno='" + this.rno + "'><strong>@"
									+ this.replyer + "</strong> - " + formattedTime + "<br>"
									+ "<div class='replytext'>" + this.replytext + "</div>"
									+ "<button type='button' class='btn btn-info'>수정/삭제</button>"
									+ "</div>";
						} else{
							str += "<div class='replyLi' data-rno='" + this.rno + "'><strong>@"
								+ this.replyer + "</strong> - " + formattedTime + "<br>"
								+ "<div class='replytext'>" + this.replytext + "</div>"
								+ "</div>";
						}
										
								
						$("#replies").html(str);
					})
				})
						
			}
			getAllList();
			
			
			$("#replyAddBtn").on("click", function(){
				var replyer = $("#newReplyer").val();
				var replytext = $("#newReplyText").val();
				
				$.ajax({
					type : 'post',
					url : '/replies',
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					dataType : 'text',
					data : JSON.stringify({
						bno : bno,
						replyer : replyer,
						replytext : replytext
					}),
					success : function(result) {
						if(result == 'SUCCESS') {
							alert("등록 되었습니다.");
							// input 태그 내부 비우기.
// 							$("#newReplyer").val("");
							$("#newReplyText").val("");
// 							location.href = "/board/get?bno=" + bno
// 										+ "&page=" + "${cri.page}"
// 										+ "&searchType=" + "${cri.searchType}"
// 										+ "&keyword=" + "${cri.keyword}";
							getAllList();
						}
					}
				})
			})
			
			$("#replies").on("click", ".replyLi button", function() {
				// "클릭한 버튼"의 부모요소만 특정지어 가져옴
				var reply = $(this).parent();
				
				
				// .attr()는 파라미터를 하나 받은 경우 해당 속성의 값을 가져옴
				var rno = reply.attr("data-rno");
				// .text()는 해당 태그의 <와 >사이의 모든 자료를 삭제하고
				// 남는 요소만 가져옴
				var replytext = reply.children('.replytext').text();
				
				console.log(replytext);
				
				// 댓글 내에 들어있던 rno와 보눈이 잘 가져와지는지 확인
		// 		alert(rno + " : " + replytext);
				console.log(rno);
				
				$(".modal-title").html(rno);
				$("#replytext").val(replytext);
				$("#modDiv").show("slow");
			});
			
			$("#replyDelBtn").on("click", function() {
				var rno = $(".modal-title").html();
				var replytext = $("#replytext").val();
				
				$.ajax({
					type : 'delete',
					url : '/replies/' + rno,
					header : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "DELETE"
					},
					dataType : 'text',
					success : function(result) {
						console.log("result: " + result);
						if(result == 'SUCCESS') {
							alert("삭제 되었습니다.");
							$("#modDiv").hide("slow");
							getAllList();
						}
					}
				})
			});
			
			$("#replyModBtn").on("click", function(){
				var rno = $(".modal-title").html();
				var replytext = $("#replytext").val();
				
				$.ajax({
					type : 'patch',
					url : '/replies/' + rno,
					header : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "PATCH"
					},
					contentType : "application/json",
					data : JSON.stringify({replytext : replytext}),
					dataType : 'text',
					success : function(result) {
						console.log("result : " + result);
						if(result == 'SUCCESS') {
							alert("수정 되었습니다.");
							$("#modDiv").hide("slow");
							getAllList();
						}
					}
				})
			});
			
			$("#closeBtn").on("click", function(){
				$("#modDiv").hide("slow");
			});
			
			(function() {
				$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
					console.log(arr);
					
					var str = "";
					
					$(arr).each(function(i, attach) {
						if(attach.fileType) {
							var fileCallPath = encodeURIComponent (attach.uploadPath + "/s_" +
										attach.uuid + "_" + attach.fileName);
							
							str += "<li data-path='" + attach.uploadPath + "' data-uuid='"
								+ attach.uuid + "' data-filename='" + attach.fileName
								+ "' data-type='" + attach.fileType + "' ><div>"
								+ "<img src='/display?fileName=" + fileCallPath + "'>"
								+ "</div>"
								+ "</li>";
						} else {
							str += "<li data-path='" + attach.uploadPath + "' data-uuid='"
								+ attach.uuid + "' data-filename='" + attach.fileName
								+ "' data-type='" + attach.fileType + "' ><div>"
								+ "<span> " + attach.fileName + "</span><br>"
								+ "<img src='/resources/fileimage.png' width='100px' height='100px'>"
								+ "</div>"
								+ "</li>";
						}
						console.log(str);
					});
					
					$("#uploadResult ul").html(str);
				});
			})();
			
			$("#uploadResult").on("click", "li", function(e) {
				
				var liObj = $(this);
				
				var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
				
				self.location = "/download?fileName=" + path;
			});
			
		});// document
	</script>
</html>