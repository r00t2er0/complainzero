<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- datatable css -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.css"/>
 
        <!-- Content Column -->
        <div class="col-lg-9 mb-4">
        <table class="table table-striped table-bordered table-hover" id="dt"
        style="display: inline-block;">
          <thead>
            <tr>
              <th class="text-center">제안서 번호</th>
              <th class="text-center">작성자</th>
              <th class="text-center">게시글 번호</th>       
              <th class="text-center">링크</th>              
              <th class="text-center">회사명</th>              
              <th class="text-center">연락처</th>              
              <th class="text-center">기타사항</th>     
              <th class="text-center">제안 상태</th> 
              <th class="text-center">신고 처리</th>           
            </tr>
          </thead>
          <tbody>    
            <c:forEach var="suggest" items="${suggestList }">
            <tr class="table-primary">
              <td>${suggest.sno }</td>
              <td>${suggest.mid }</td>
              <td>${suggest.bno }</td>
              <td>${suggest.link }</td>
              <td>${suggest.companyName }</td>
              <td>${suggest.tel }</td>
              <td>${suggest.etc }</td>
              <c:if test="${suggest.statusCode == 'S00' }">
              <td>대기</td>
              <td><button class="btn btn-primary"><label class="approve">승인</label></button>
              <button class="btn btn-primary"><label class="refuse">거절</label></button></td>
              </c:if>
              <c:if test="${suggest.statusCode == 'S01' }">
              <td>반려</td><td><input type="hidden"></td>
              </c:if>
              <c:if test="${suggest.statusCode == 'S02' }">
              <td>승인</td><td><input type="hidden"></td>
              </c:if>
            </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
      <!-- /.row -->

    </div>
    <!-- /.container -->

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.js"></script>
    <!-- datatable js -->
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.js"></script>
    
    <script type="text/javascript">
     $(document).ready(function() { 
    	 var lang_kor = {
    		      "decimal" : "",
    		      "emptyTable" : "데이터가 없습니다.",
    		      "info" : "_START_ - _END_ (총 _TOTAL_ 글)",
    		      "infoEmpty" : "0명",
    		      "infoFiltered" : "(전체 _MAX_ 명 중 검색결과)",
    		      "infoPostFix" : "",
    		      "thousands" : ",",
    		      "lengthMenu" : "_MENU_ 개씩 보기",
    		      "loadingRecords" : "로딩중...",
    		      "processing" : "처리중...",
    		      "search" : "검색 : ",
    		      "zeroRecords" : "검색된 데이터가 없습니다.",
    		      "paginate" : {
    		          "first" : "첫 페이지",
    		          "last" : "마지막 페이지",
    		          "next" : "다음",
    		          "previous" : "이전"
    		      },
    		      "aria" : {
    		          "sortAscending" : " :  오름차순 정렬",
    		          "sortDescending" : " :  내림차순 정렬"
    		      }
    		  };
    	 
      $('#dt').DataTable({
        responsive: true,
        searching: true,
        bAutoWidth: true,
        bPaginate: true,
        language : lang_kor
//     	  pageLength:3
      }); 
      
      $(document).on('click', '.approve', function() {
		var no = $(this).parents('tr').children().eq(0).text();
		var me = this;

    	  $.ajax({
    		  url : 'updateSuggest.do/' + no + '/' + 2,
    		  type : 'PUT',
    		  contentType : 'application/json;charset=UTF-8',
//     		  data : parameter,
    		  success : function(data) {
    			  alert("승인되었습니다.");
    			  $(me).parents('tr').children().eq(7).text('승인');
    			  $(me).parents('tr').children().eq(8).children().hide();
    		  }, error :  function(xhr, status, error) {
    			  alert(error);
    		  }
    	  });
      });
      
      $(document).on('click', '.refuse', function() {
		var no = $(this).parents('tr').children().eq(0).text();
		var me = this;

    	  $.ajax({
    		  url : 'updateSuggest.do/' + no + '/' + 1,
    		  type : 'PUT',
    		  contentType : 'application/json;charset=UTF-8',
//     		  data : parameter,
    		  success : function(data) {
    			  alert("거절되었습니다.");
    			  $(me).parents('tr').children().eq(7).text('반려');
    			  $(me).parents('tr').children().eq(8).children().hide();
    		  }, error :  function(xhr, status, error) {
    			  alert(error);
    		  }
    	  });
      });
     }); 
    </script>
  </body>
</html>