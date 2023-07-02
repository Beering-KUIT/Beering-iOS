## Beering-iOS
KUIT 1기 Beering 팀 iOS 파트 레포지토리


##  Git Commit Convetion

### 📌 Type

| commit 명 | commit 뜻 |
| --- | --- |
| Feat | 새로운 기능 추가 |
| Refactor | 코드 리펙토링 |
| Fix | 버그 수정 |
| Update | Fix와 달리 원래 정상적으로 동작했지만 보완의 개념 |
| Add | 파일 추가 |
| Rename | 파일 혹은 폴더 이름 수정 |
| Move | 코드, 파일 혹은 폴더 이동 |
| Remove | 파일 삭제 |
| Design | UI 디자인 변경 |
| Docs | 문서 수정 |
| Style | 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우 |
| Test | 테스트 코드, 리펙토링 테스트 코드 추가 |
| Chore | 패키지 매니저 수정, 패키지 관리자 구성 등 업데이트, Production Code 변경 없음 |
| Build | 빌드 관련 파일 수정 |
| CI | CI 설정 파일 수정 |
| Pref | 성능 개선 |




##  Git Branch 전략

### `main`
서비스의 버전 별로 관리가 된다고 생각하면 됩니다. 하지만 저희 프로젝트 특성상, 가장 마지막에 한번만 merge 될 예정이고, 거의 사용하지 않을 브랜치라 생각하시면 됩니다.


### `develop`
 ****default branch**** 로 설정해놓을, 이번 프로젝트에서의 main 브랜치라고 생각하시면 됩니다. 1.0.0 버전의 develop 을 진행하는 브랜치이고, 상세 기능들은 기능별 feature 브랜치에서 작업 후 이 develop 브랜치에 merge 됩니다.


### `feature`
develop 브랜치에서 파생된 기능 구현용 브랜치로, 파트원별로 맡은 기능별 브랜치를 만들면 됩니다.  

예를 들어, Server 의 경우 소셜로그인 / 상세페이지 받아오기 / 리뷰등록 의 기능을 구현해야 한다면, 인원별로 작업을 나누고, feature-socialLogin / feature-detailPage / feature-review 등이 될 수 있겠습니다.(브랜치 이름은 예시일 뿐이고, 파트별로 컨벤션을 정해도 됩니다.)

iOS / Android 의 경우 구현해야 할 화면별로 feature 브랜치를 파면 됩니다. 회원가입 화면의 레이아웃을 짤 때는, feature/join-layout 으로, 회원가입 시 실제 서버에 요청하는 등 실제 기능을 구현할 때는, feature/join 식으로 브랜치를 관리하겠습니다.

### 정리하자면,
Upstream Remote Repository 를 Fork 했을 때, default 로 develop 브랜치 입니다.

Fork 한 개인의 Repository 의 develop 브랜치에서 feature-OOO 브랜치 를 파생하여 기능을 구현하고, develop 브랜치에 Merge 합니다.

자신이 맡은 작업이 완료가 되었다면, 공유 레포지토리(최종 레포지토리) 에 merge 합니다. 이때는 Pull Request 를 보내고, 파트원끼리 코드를 리뷰한 후 수정/충돌해결 등을 거쳐 merge 합니다.

공유 레포지토리에 다른 팀원이 추가한 코드들이 있을 수 있으므로, 다음 작업으로 넘어가기 전에 공유 레포지토리에서 Forked Repository 로 코드들을 받아오고(Pull / Sync?(Github 기능)) 다음 작업을 진행합니다.

