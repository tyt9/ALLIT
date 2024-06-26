# ALLIT
**자격증 시험 접수 페이지** 입니다.<br><br><br>

### 개발 기간
* 2023.09.01 ~ 2023.09.15 (약 2주)<br><br>

### 팀원 구성
* **팀장 : 본인 - ERD 설계, 시험 일정 조회 기능, 시험 접수 기능, 발표, 소스 통합**
* 팀원1 : 로그인/회원가입 기능, 마이페이지 기능, 발표
* 팀원2 : 공지사항 게시판
* 팀원3 : 문의 게시판 및 댓글 기능, CSS<br><br>

### 개발 환경
* Java 11
* **프레임워크** : Spring boot(2.7.15)
* **데이터베이스** : mysql - jdbcTemplate
* **프론트** : JSP, javascript, jQuery<br><br>

### 나의 역할
---
* **[ERD 설계](https://github.com/tyt9/ALLIT/edit/master/README.md#erd-%EC%B0%B8%EA%B3%A0%ED%95%98%EC%84%B8%EC%9A%94)**

기획 이후 기능에 따라 어떤 데이터가 필요한지, 그 데이터마다 어떤 관계가 필요한지 생각하며 테이블과 그 관계를 구성함
* **소스 통합**

팀장으로서 역할 분담 이후 각자 작성하는 코드를 취합하고 오류를 수정함

* **기능 구현**

   **1. 시험 일정 조회 기능**

     * 시험 일정 조회 페이지에 들어가면 올해의 시험 일정이 표시
     * 기본 정렬은 날짜순
     * 시험별 검색, 기간으로 필터링, 둘 다 필터링도 가능
     * 현재 날짜에 접수 가능한 시험은 접수 버튼이 보임
     * 시험 이름이나 접수 버튼을 클릭하면 시험 상세 페이지로 이동
  
  **2. 시험 접수 기능**
  
     * 시험 상세 페이지에서 접수 가능
     * 현재 접수 가능한 시험만 접수 버튼이 보임
     * 접수 가능한 인원이 있고 초과되면 접수 불가능함
     * 같은 시험의 이전 회차와 다음 회차로 이동할 수 있다

  **3. 시험 추가 및 삭제 기능**

     * 관리자는 시험을 추가하고 삭제할 수 있다

     












![스크린샷 2024-06-10 181432](https://github.com/tyt9/ALLIT/assets/143326223/e19637b8-5565-4b0a-9d51-f0085edd0d9b)<br>

맨 처음 들어가면 나오는 화면<br>
① 로그인 : 로그인, 회원가입, 아이디/비밀번호 찾기를 할 수 있다.<br>
② 이번달 시험 일정 : [**이번달에 있는 시험 일정**]이 나온다.<br>
③ 공지사항 : 공지사항이 나온다.<br>

밑에는 팀원분이 페이지가 허전한 것 같다고 귀여운 이미지를 만들어주셨다.<br><br><br>

![스크린샷 2024-06-10 181150](https://github.com/tyt9/ALLIT/assets/143326223/41383bd1-2df0-4b6b-bd5a-2bed3672ddee)<br>

내가 만든 [**시험 일정 조회 페이지**]<br><br>
① 날짜 검색 : 기간을 정해서 검색할 수 있다.<br>
② 시험별 분류 : 각 시험별로 볼 수 있다.<br>
③ 접수 버튼 : 접수 기간인 시험은 버튼이 뜬다<br>

왼쪽의 시험 이름을 누르거나 접수 버튼을 누르면<br>

![스크린샷 2024-06-10 181246](https://github.com/tyt9/ALLIT/assets/143326223/885e9fdc-143b-43d5-8569-2c074cbb842f)<br>

[**시험의 상세 정보**]가 나온다.<br>
① 시험명 : 0 회차 + 시험 이름이 나온다.<br>
② 접수 상황 : 접수 정원과 현재 접수 상황이 표시된다.<br>
③ 접수 버튼과 시험 일정 버튼 : 접수 기간이 아니거나 정원이 다 차면 비활성화 된다. <br>
시험 일정 버튼은 시험 일정으로 돌아가기 버튼.<br>
④ 이전 회차와 다음 회차 : 같은 시험의 이전 회차와 다음 회차로 바로가기 할 수 있다.<br><br>


로그인은 일반유저와 관리자가 있다.<br>
[**관리자로 로그인**] 하면 세가지 메뉴가 뜬다.<br>
![스크린샷 2024-06-10 181520](https://github.com/tyt9/ALLIT/assets/143326223/e500ad93-9e7a-41ca-a7e5-f3b2e9dfce8f)<br>
① 공지사항 쓰기 : 공지사항을 작성할 수 있다.<br>
② 회원 문의 관리 : 회원의 문의글에 답변을 작성할 수 있다.<br>
③ 시험 일정 추가 : **시험 일정을 추가**할 수 있다.<br>

![스크린샷 2024-06-10 181545](https://github.com/tyt9/ALLIT/assets/143326223/ca75aa08-2f6d-4a42-8d55-39612f094dad)<br>
① 시험 이름 선택 : 등록할 시험 이름을 선택하면 ③번 회차가 바뀐다.<br>
② 접수 기간 : 접수 시작일보다 종료일이 빠르거나, 시험 날짜를 넘어가면 기간을 확인하라는 알림창이 뜬다.<br>
③ 회차 : 선택한 시험에 따라 알맞는 회차가 자동으로 설정된다. (이전회차 + 1)<br><br><br>

![스크린샷 2024-06-10 184327](https://github.com/tyt9/ALLIT/assets/143326223/bbc38ee9-7f63-491e-ac22-0532f0ef678b)<br>
① 삭제 버튼 : 관리자는 시험 일정 조회 페이지에 들어가면 **삭제 버튼**이 뜬다. 일반 유저는 뜨지 않는다.<br><br>

![캡처 도구 2024-06-11 오후 5_14_20](https://github.com/tyt9/ALLIT/assets/143326223/599d96f9-11f5-43e6-bbca-726928ce013b)<br>
일반유저는 이런 메뉴들을 쓸 수 있다.<br><br><br><br><br>

##### **ERD** 참고하세요.<br>
![ALLITERD](https://github.com/tyt9/ALLIT/assets/143326223/a544e08e-0001-484a-9bb2-3d40033d9b23)

