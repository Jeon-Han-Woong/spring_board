<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>게시판 목록</title>
</head>
<body>
	<div class="container mt-5 mb-3">
	
	<h1 class="mb-3 text-primary text-center">전체 글 목록</h1>
	<div class="row">
		<div class="text-body">
			<select name="searchType">
				<option value="n"
				<c:out value="${cri.searchType == null ? 'selected' : ''}" />>
				검색 조건
				</option>
				<option value="t"
				<c:out value="${cri.searchType eq 't' ? 'selected' : ''}" />>
				제목
				</option>
				<option value="c"
				<c:out value="${cri.searchType eq 'c' ? 'selected' : ''}" />>
				내용
				</option>
				<option value="w"
				<c:out value="${cri.searchType eq 'w' ? 'selected' : ''}" />>
				작성자
				</option>
				<option value="tc"
				<c:out value="${cri.searchType eq 'tc' ? 'selected' : ''}" />>
				제목 + 내용
				</option>
				<option value="cw"
				<c:out value="${cri.searchType eq 'cw' ? 'selected' : ''}" />>
				내용 + 작성자
				</option>
				<option value="tcw"
				<c:out value="${cri.searchType eq 'tcw' ? 'selected' : ''}" />>
				제목 + 내용 + 작성자
				</option>
			</select>
			<input type="text" name="keyword" id="keywordInput" value="${cri.keyword}">
			<button id="searchBtn">Search</button>
		</div>
	</div>
	
	<div class="row mb-3">
		<a class="btn btn-primary col-md-1 offset-md-11" href="/board/register">글쓰기</a>
	</div>
	
	<table class="table table-bordered table-hover">
		<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일자</th>
			<th>수정일자</th>
		</tr>
		</thead>
		<tbody>
		<!-- forEach구문은 반복적으로 html요소를 표현할 때 사용하는 태그 라이브러리. 
		자바 코드와 html코드가 섞이는 상황을 막기 위해 사용.-->
		<c:forEach var="a" items="${list}">
		<tr>
			<td>${a.bno}</td>
			<td><a href="/board/get?bno=${a.bno}&page=${cri.page}&searchType=${cri.searchType}&keyword=${cri.keyword}">${a.title} [ ${a.replycount} ]</a></td>
			<td>${a.writer}</td>
			<td>${a.regdate}</td>
			<td>${a.updatedate}</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	
	<div class="container mt-5">
		<div class="row">
		
		<ul class="col-md-10 offset-md-1 pagination justify-content-center">
	    	<!-- 이전 페이지 버튼 -->
	    	<c:if test="${pageMaker.prev}">
	    		<li class="page-item">
	    			<a class="page-link"
	    				href="/board/list?page=${pageMaker.startPage -1}&searchType=${cri.searchType}&keyword=${cri.keyword}">
	    				&laquo;
	    			</a>
	    		</li>
	    	</c:if>
	    	<!-- 페이지 번호 버튼 -->
	    	<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
	    				var="idx">
	    		<li class="page-item
	    			<c:out value="${pageMaker.cri.page == idx ? 'active' : ''}" />">
	    			<a class="page-link"
	    				href="/board/list?page=${idx}&searchType=${cri.searchType}&keyword=${cri.keyword}">${idx}</a></li>
	    	</c:forEach>
	    	<!-- 다음 페이지 버튼 -->
	    	<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
	    		<li class="page-item">
	    			<a class="page-link"
	    				href="/board/list?page=${pageMaker.endPage +1}&searchType=${cri.searchType}&keyword=${cri.keyword}">
	    				&raquo;	
	    			</a>
	    		</li>
	    	</c:if>
  		</ul>
		</div>
	</div>
	
</body>
<script type="text/javascript">
	$(document).ready(function() {
		var bno = "${bno}";
		
		console.log(bno);
		
		if(bno !== $.trim()){
			alert(bno + "번 글이 삭제되었습니다.");		
		}		
		
		$('#searchBtn').on("click", function(event) {
			self.location = "list" + "?page=1" + "&searchType=" + $("select option:selected").val() 
							+ "&keyword=" + $('#keywordInput').val();
		})
	});
	
</script>
</html>