# 소콘소콘
> 지역 상생을 위한 소상공인 기프티콘 플랫폼!

## FE
### 김아현 
* 작업 내용
  * 위젯 구현
    * 반응형 설정
    * 컬러팔레트
    * 타이포그래피(폰트)
    * 탭 바
    * 장소 목록 카드
    * 검색박스
    * 토스트메세지
    * 이미지 로더
    * svg 아이콘 로더
      

*  기능
    * [반응형 설정](https://www.notion.so/kdie44/3a703cd271594436af0e19420bea16a4?pvs=4)
    * [컬러팔레트](https://www.notion.so/kdie44/209795c102e24db7a9915c7ab39e1a04?pvs=4)
    * [타이포그래피(폰트)](https://www.notion.so/kdie44/724df960598b48618e817a2fd3aaa75f?pvs=4)
    * [탭 바](https://www.notion.so/kdie44/adfb7da2fbb04a47ac41ec307571a87e?pvs=4)
    * [장소 목록 카드](https://www.notion.so/kdie44/a289f4352dc74fa48f3d3f15e157a75c?pvs=4)
    * [검색박스](https://www.notion.so/kdie44/748a8a266e9d49be9b50bdd3e6525ad2?pvs=4)
    * [토스트메세지](https://www.notion.so/kdie44/ebaf3c1cf3e0425ca246b87fb07d6236?pvs=4)
    * [이미지 로더](https://www.notion.so/kdie44/ce3acb8c49a24b08a2e0b6a46d1a113c?pvs=4)
    * [svg 아이콘 로더](https://www.notion.so/kdie44/svg-aa6aabd73d0b473cb53dc199366dd849?pvs=4)


* 학습 자료 모음
    * [Git Fetch와 Git Pull 명령어의 차이점](https://www.notion.so/kdie44/Git-Fetch-Git-Pull-20ec6a5061ba4012a7c97b145d2df335?pvs=4)
    * [keystore 생성 방법](https://www.notion.so/kdie44/keystore-dd4f4fbfa9764410bcd0c382643b461a?pvs=4)
    * [hot reload](https://www.notion.so/kdie44/Flutter-hot-reload-3f87e47709c2400c884be31062de49d6?pvs=4)
    * [Flutter에서는 어떤 디자인 패턴을 사용해야하지…?](https://www.notion.so/kdie44/Flutter-a55ab51a7e7c4f14b27fc1fabcfa5f53?pvs=4)

### 김온유
* 역할
*  기능
   * **기능명 1**
      * 기능1 상세
      * 화면

### 탁하윤
* 역할
*  기능
   * **기능명 1**
      * 기능1 상세
      * 화면

## BE
![feign_client](/uploads/61771223fec7e7cc38593618eee4aaf3/feign_client.PNG)
MSA 방식에서 도메인 간의 소통 -> feign client
### 김다희
* 역할
*  기능
   * **기능명 1**
      * 기능1 상세
      * 화면

### 김도휘
* Gateway, 회원, 결제 
*  기능
   * **Gateway**
      * Jwt 토큰 검증
      * memberId, role을 도메인에게 넘겨줌
   * **회원**
      * 로그인
      * 회원가입
      * 이메일 중복검사
      * 비밀번호 찾기
      * 마이페이지
   * **결제**
      * 기프티콘 결제
      * 소콘머니 충전
      * 소콘머니 출금
   * **정리한 내용 노션 링크**
      * https://dohwiii.notion.site/128e41ea366340578a4eeadc6304ef63?pvs=4

### 이유빈
* 점포, 소콘(기프티콘), 소곤(커뮤니티)
*  점포
   * **점포 정보 등록** : 사업자 인증이 된 유저에 한하여 본인 명의의 점포 등록 가능
   * **점포 목록 조회** : 점주 유저의 본인이 등록한 점포 목록 조회
   * **점포 정보 상세 조회**
       * 일반 유저 : 점보 일반 정보, 발행 중 소콘 정보 조회
       * 점주 유저 : 점포 일반 정보, 등록 상품 정보, 모든 발행 정보 조회
   * **점포 정보 수정** : 수정 가능 필드에 한하여 점주의 점포 정보 수정 가능
   * **폐업 신고** : 점주의 폐업 신고 시 폐업 날짜 업데이트
   * **상품 정보 등록**
   * **상품 정보 상세 조회**
   * **관심 가게 추가, 취소**
   * **관심 가게 목록 조회**
* 소콘
  * **소콘 상세 조회** : 발행된 기프티콘 정보 상세 조회 
  * **소콘북 보유 소콘 목록 조회**
  * **소콘북 내 소콘 검색**
  * **소콘 사용 승인** : 점주 유저가 본인 점포 소콘에 한하여 소콘 사용 승인 가능
  * **소콘 발행(생성)** : 주문 및 결제 완료 시 소콘 발행
  * **소콘 발행 중지** : 점주 유저의 요청 시 발행 중 소콘 발행 중지
  * **소콘 주문** : 주문 정보 생성 후 결제에 요청
* 소곤
  * **소곤 작성** : 본인 위치에 게시글 작성 기능
  * **소곤 댓글 추가** : 근처 소곤에 댓글 작성 기능
  * **소곤 댓글 채택** : 본인 작성 소곤에 작성자가 본인이 아닌 댓글 채택 기능
  * **소곤 상세 조회**
  * **작성 소곤 목록 조회** : 본인이 작성한 소곤 목록 조회
  * **작성 댓글 목록 조회** : 본인이 작성한 댓글 목록 조회
  * **반경 내 소콘 목록 조회** : 내 주변 반경 1.5km 내의 소곤 목록 조회