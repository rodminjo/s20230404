<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="/css/list.css" rel="stylesheet" type="text/css">
    
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet">
    
    <style>
        .swiper-container {
            width:1600px;
            height:530px;
            padding:30px 0;
          /*   border:5px solid silver;
            border-radius:7px;
            box-shadow:0 0 20px #ccc inset;  */
        }
        .swiper-slide {
            text-align:center;
            display:flex; /* 내용을 중앙정렬 하기위해 flex 사용 */
            align-items:center; /* 위아래 기준 중앙정렬 */
            justify-content:center; /* 좌우 기준 중앙정렬 */
        }
        .swiper-slide img {
            box-shadow:0 0 5px #555;
        }
        th, td { 
            border-bottom: 2px solid rgb(64, 64, 64); 
        }
    </style>
    
    <script type="text/javascript">
        /* 검색어 입력 필드에서 Enter키 입력 시 검색 수행 */
        document.getElementById('searchId').addEventListener('keyup', function(event) {
            if (event.code === 'Enter') {
                event.preventDefault();
                document.querySelector('form').submit();
            }
        });
        
        /* 카테고리 선택에서 Enter키 입력 시 검색 수행 */
        document.getElementById('category').addEventListener('keyup', function(event) {
            if (event.code === 'Enter') {
                event.preventDefault();
                document.querySelector('form').submit();
            }
        });
    </script>  
</head>


<body>
  <div id="img_benner">
    <img src="img/travel-picture.png" alt="배너" >
  </div>
  
  <h1>
    <a href="tra">
      <img src="img/Tra.png" alt="여행지" width=250px height=250px>
    </a>
  </h1>


  <!-- 여행지종류 -->
  <div style="display: inline-block; width: 700px; text-align: center;">
    <c:forEach items="${boardTraList}" var="list" varStatus="status">
      <a href="traCodeFilter?code=${list.code}">
        <font size="5">${list.value}</font>
      </a>
      <c:if test="${not status.last}">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      </c:if>
    </c:forEach>
  </div>
  
  <br><br>

  <!-- 검색 -->
  <form action="traSearch">
    <select id="category" name="search">
      <option value="s_title">제목</option>
      <option value="s_content">내용</option>
    </select> 
    <div id="serch">
      <input type="text" name="keyword" placeholder="검색어를 입력하세요" value="${search}" id="searchId">
    </div>
    <p>
  </form>

  <c:set var="num" value="${page.total-page.start+1 }"></c:set>
  <br>

  <!-- 지역 종류 지역 종류  지역 종류  지역 종류  지역 종류  지역 종류  -->
  <div style="display: inline-block; width: 460px; text-align: center;">
    <c:forEach items="${traCommonLocCode}" var="list">
      <a href="traLocFilter?code=${list.code}">
        <font size="4">${list.value}</font>
      </a> 
      <c:if test="${not status.last}">
        &nbsp;&nbsp;&nbsp;
      </c:if>
    </c:forEach>
  </div>
  
  <br><br>   
  <hr>
  <br>          
   

<!-- 국내 인기 여행지  -->
<div id="session2">
  <h3>국내 인기 여행지</h3>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
  
  <!-- 클래스명은 변경하면 안 됨 -->
  <div class="swiper-container">
    <div class="swiper-wrapper">
      <c:forEach var="travel" items="${popularTravel}">
        <div class="swiper-slide">
          <a href="/traDetail?tid=${travel.travel_id}">
            <c:url value="/display" var="url">
              <c:param name="file" value="${travel.img_stored_file }"></c:param>
            </c:url>
            <div class="image-container">
              <img src="${url }" alt="${travel.t_name}" width="420" height="300">
              <div class="image-text">${travel.t_name}</div>
            </div>
          </a>
        </div>
      </c:forEach>
    </div>
    
    <!-- 네비게이션 -->
    <div class="swiper-button-next"></div> <!-- 다음 버튼 (오른쪽에 있는 버튼) -->
    <div class="swiper-button-prev"></div> <!-- 이전 버튼 -->
    
    <!-- 페이징 -->
    <div class="swiper-pagination"></div>
  </div>
  
  <script>
    new Swiper('.swiper-container', {
      slidesPerView: 3, // 동시에 보여줄 슬라이드 갯수
      spaceBetween: 20, // 슬라이드간 간격
      slidesPerGroup: 3, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음
      // 그룹수가 맞지 않을 경우 빈칸으로 메우기
      // 3개가 나와야 되는데 1개만 있다면 2개는 빈칸으로 채워서 3개를 만듬
      loopFillGroupWithBlank: true,
      loop: true, // 무한 반복
      pagination: { // 페이징
        el: '.swiper-pagination',
        clickable: true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
      },
      navigation: { // 네비게이션
        nextEl: '.swiper-button-next', // 다음 버튼 클래스명
        prevEl: '.swiper-button-prev', // 이번 버튼 클래스명
      },
    });
  </script>
  
  <br><br>
  <hr>
  <br>
</div>
      

<!-- 여행지리스트 테이블 -->
<h3>국내 전체 여행지 </h3>
<c:if test="${user_role == 'rol200' }">
   <a href="traWriteForm"><button type="submit" style="margin-left: 610px; margin-bottom: 10px">글 쓰기</button></a>
</c:if>

<div>
   <table style="margin:auto;">
      <tr>
         <td hidden>번호</td>                                       
         <td width="140px;">지역</td>
         <td width="300px;">숙소명</td>
         <td width="140px;">평점</td>
         <td width="60px;">리뷰수</td>         
      </tr>
      <c:forEach items="${traList}" var="travel">
         <tr>
            <td hidden>${travel.travel_id}</td>
            <td>${travel.t_common_loc}</td>
            <td><a href="traDetail?tid=${travel.travel_id}">${travel.t_name}</a></td>
            <td>
               <c:choose>
                  <c:when test="${travel.t_avgscore eq '1'}">
                     <c:out value="★☆☆☆☆"/>
                  </c:when>
                  <c:when test="${travel.t_avgscore eq '2'}">
                     <c:out value="★★☆☆☆"/>
                  </c:when>
                  <c:when test="${travel.t_avgscore eq '3'}">
                     <c:out value="★★★☆☆"/>
                  </c:when>
                  <c:when test="${travel.t_avgscore eq '4'}">
                     <c:out value="★★★★☆"/>
                  </c:when>
                  <c:when test="${travel.t_avgscore eq '5'}">
                     <c:out value="★★★★★"/>
                  </c:when>
                  <c:otherwise>
                     <c:out value="☆☆☆☆☆"/>
                  </c:otherwise>
               </c:choose>                                    
            </td>                                                            
            <td>${travel.t_revcount}</td>   
         </tr>                  
      </c:forEach>
   </table>
   <br><br>
</div>

   <!-- 페이징 처리 페이징 처리  페이징 처리  페이징 처리   -->
	<div>
	   <c:if test="${page.startPage > page.pageBlock }">
	      <a href="tra?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
	   </c:if>
	   <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
	      <a href="tra?currentPage=${i}">[${i}]</a>
	   </c:forEach>
	   <c:if test="${page.endPage < page.totalPage }">
	      <a href="tra?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
	   </c:if>
	</div> 

<br><br>
<hr>
<br>


<!-- 이 달의 축제 -->
<div id="session1">
  <h3>이달의 축제</h3>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
  <!-- 클래스명은 변경하면 안 됨 -->
  <div class="swiper-container">
    <div class="swiper-wrapper">
      <div class="swiper-slide">            
        <figure>
          <a href="https://www.chf.or.kr/chf">
            <img src="img/fes1.jpg" alt="이미지 1" width=310px height=400px>
          </a>
          <br>[서울] 창경궁 야연                  
          <br>5/2(화)~5/19(금)
        </figure>
      </div>         
      <div class="swiper-slide">
        <figure>
          <a href="https://www.xn--vk1b9fv8tlkdzuqf4h.com/">
            <img src="img/fes2.jpg" alt="이미지 2" width=310px height=400px>
          </a>   
          <br>[대전] 대청호 대덕물빛축제
          <br>4/7(금)~5/7(일)
        </figure>
      </div>
      <div class="swiper-slide">
        <figure>
          <a href="https://www.herbisland.co.kr">
            <img src="img/fes3.jpg" alt="이미지 3" width=310px height=400px>
          </a>   
          <br>[경기 포천] 허브아일랜드 라벤더
          <br>4/22(토)~7/1(토)
        </figure>
      </div>
      <div class="swiper-slide">
        <figure>
          <a href="http://bba48.or.kr">
            <img src="img/fes4.jpg" alt="이미지 4" width=310px height=400px>
          </a>   
          <br>[부산] 2567 부산연등축제
          <br>4/28(금)~5/14(일)
        </figure>
      </div>
      <div class="swiper-slide">
        <figure>
          <a href="http://hwangmaefestival.com/">
            <img src="img/fes5.png" alt="이미지 5" width=310px height=400px>
          </a>
          <br>[경남 합천] 황매산 철쭉제
          <br>4/29(토)~5/14(일)
        </figure>
      </div>
      <div class="swiper-slide">
        <figure>
          <a href="https://www.hpftf.or.kr/">
            <img src="img/fes6.png" alt="이미지 6" width=310px height=400px>
          </a>   
          <br>[전남 함평] 함평 나비 대축제
          <br>4/28(금)~5/7(일)
        </figure>
      </div>      
    </div>  
    
  <!-- 네비게이션 -->
      <div class="swiper-button-next"></div> <!-- 다음 버튼 (오른쪽에 있는 버튼) -->
      <div class="swiper-button-prev"></div> <!-- 이전 버튼 -->
  <!-- 페이징 -->
      <div class="swiper-pagination"></div>
  </div>
      
  <script>
    new Swiper('.swiper-container', {
     slidesPerView : 3, // 동시에 보여줄 슬라이드 갯수
     spaceBetween : 20, // 슬라이드간 간격
     slidesPerGroup : 3, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음
     // 그룹수가 맞지 않을 경우 빈칸으로 메우기
     // 3개가 나와야 되는데 1개만 있다면 2개는 빈칸으로 채워서 3개를 만듬
     loopFillGroupWithBlank : true,
     loop : true, // 무한 반복
     pagination : { // 페이징
       el : '.swiper-pagination',
       clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
     },
     navigation : { // 네비게이션
       nextEl : '.swiper-button-next', // 다음 버튼 클래스명
       prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
     },
    });
  </script>
  <br><br>
  <hr>   


</body>
    <c:import url="../fragments/footer.jsp"/>
</html>