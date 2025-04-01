## Code Convention

### 1️⃣ **파일명 & 클래스명**

#### 파일명
**LowerCase**를 사용합니다.

ex) `test_file.dart`

#### 클래스명
**UpperCase**를 사용합니다.

ex) `RegisterView`

<br>

 
### 2️⃣ **변수 및 상수 이름**

**직관적인 변수명** 사용 및 **줄임말 금지**
```
var submitButton; (O)
var aButton; (X)

myContentCollectionViewCell (O)
myContentCVCel` (x)

약어는 전부 대문자로 사용
ex) URL, ID, API
```
<br>


### 3️⃣ Issue

모든 작업은 이슈를 파고,
해당 이슈에서 브랜치를 만들고, 
그 브랜치에서 작업합니다.

이슈는 템플릿대로 할 일들을 적어주시면 됩니다.

```
이슈 이름 : [작업종류] 작업 명

ex) [Feat] Main View UI 구현

담당자, 라벨 추가 꼭 하기
```

</br>


### 4️⃣ Branch
브랜치명은 **소문자**로 시작한다.
항상 Issue를 파서 브랜치를 생성한다.

```
브랜치명 : 작업종류/#이슈번호

ex) feat/#12
```

</br>


### 5️⃣ Commit
```
- [Feat] : 새로운 기능 구현
- [Fix] : 버그, 오류 해결
- [Chore] : 코드 수정, 내부 파일 수정, 애매한 것들이나 잡일은 이걸로!
- [Add] : 라이브러리 추가, 에셋 추가
- [Delete] : 쓸모없는 코드 삭제
- [Docs] : README나 WIKI 등의 문서 개정
- [Refactor] : 전면 수정이 있을 때 사용합니다
- [Setting] : 프로젝트 설정관련이 있을 때 사용합니다
- [Network] : 네트워크 관련 작업 시에 사용합니다
- [Style] : UI 관련 작업 시에 사용합니다
```


#### Commit Message
```
커밋 메시지 : [작업종류] #이슈번호 - 작업 내용

ex) [Style] #15 - 메인 UI 구현
```

커밋 단위는 엄청 세세하진 않아도 **최대한 자주** 해주세요

</br>


### 6️⃣ Pull Request

이슈에 해당하는 작업이 완료되면, 커밋 및 푸시한 내용들을 **pull request** 합니다. </br>

pr의 내용은 **템플릿에 맞춰**서 작성해주시면 되고, 최대한 동영상보다는 **gif** 사진으로 올리도록 합니다. </br>

항상 **reivewers**에 팀원을 추가하고, 팀원들의 **리뷰 및 approve**가 완료되면 merge합니다. </br>

```
pr 이름 : [작업종류] #이슈번호 - 이슈 명

ex) [Feat] #15 - Main View UI 구현

리뷰어, 담당자, 라벨 추가 꼭 하기
```

</br>


## 🗂️ Foldering
```
📁 lib
├── 📁 applacation
│   ├── 📁 tabBar
│   │   ├── 📁 view
│   │   ├── 📁 viewModel
│   └── main.dart
├── 📁 global
│   ├── 📁 assets
│   │   ├── 📁 fonts
│   │   ├── 📁 images
│   └── 📁 components
├── 📁 network
│   ├── 📁 base
│   └── 📁 domain
│       ├── 📁 dto
│       │   ├── 📁 request
│       └── └── 📁 response
└── 📁 presentation
    ├── 📁 chart
    │    ├── 📁 model
    │    ├── 📁 view
    │    └── 📁 viewModel
    ├── 📁 diary
    │    ├── 📁 model
    │    ├── 📁 view
    │    └── 📁 viewModel
    ├── 📁 home
    │    ├── 📁 model
    │    ├── 📁 view
    │    └── 📁 viewModel
    ├── 📁 myPage
    │    ├── 📁 model
    │    ├── 📁 view
    │    └── 📁 viewModel
    ├── 📁 onboarding
    │    ├── 📁 model
    │    ├── 📁 view
    │    └── 📁 viewModel
    ├── 📁 register
    │    ├── 📁 model
    │    ├── 📁 view
    │    └── 📁 viewModel
    ├── 📁 splash
    │    ├── 📁 model
    │    ├── 📁 view
    │    └── 📁 viewModel
    └── 📁 survey
         ├── 📁 Model
         ├── 📁 view
         └── 📁 viewModel
```

</br>

폴더명은 **lowerCamelCase** 를 사용합니다.
```
ex) myPage (O)
    MyPage (X)
    my_page (X)
    My_Page (X)
```
📁 application </br>
main.dart 파일과 탭바 관련 코드를 넣어두는 곳

📁 presentation </br>
화면 UI에 대한 폴더, 해당 화면을 표현하는 코드들을 모아두는 곳

📁 global </br>
앱 전체적으로 사용되는 기능을 위한 것
assets과 components 등이 포함

📁 assets </br>
안에 fonts, images, logo 등의 세부 폴더들이 위치할 수 있으며, 앱에서 사용할 asset들을 모아두는 폴더

📁 network </br>
이 폴더에는 API 호출, 데이터 저장소 또는 기타 네트워크 관련 로직을 다루는 클래스가 포함


<br/>
