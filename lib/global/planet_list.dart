class PlanetModel {
  final String code; // MERCURY, EARTH 등
  final String name;
  final int number;
  final String summary;
  final String description;
  final String imageURL;
  final String iconsURL;
  final List<String> mbtiTypes; // 이 행성에 속하는 MBTI 타입

  PlanetModel({
    required this.code,
    required this.name,
    required this.number,
    required this.summary,
    required this.description,
    required this.imageURL,
    required this.iconsURL,
    required this.mbtiTypes,
  });

}

// 기존 planetList 정의 (mbtiTypes 추가)
List<PlanetModel> planetList = [
  PlanetModel(
    code: 'MERCURY',
    name: '수성',
    number: 1,
    summary: '분석적 소비형',
    description:
    '충동적인 소비를 줄이고, 데이터를 기반으로 신중한 소비를 추구. 제품 리뷰, 가격 변동, 장기적 가치를 고려하여 현명한 소비 습관 형성.',
    imageURL: 'assets/images/planet_icon/MERCURY.png',
    iconsURL: 'assets/images/type_icon/reading_glasses.png',
    mbtiTypes: ['INTJ', 'INTP'],
  ),
  PlanetModel(
    code: 'VENUS',
    name: '금성',
    number: 2,
    summary: '균형 잡힌 감각적 소비형',
    description:
    '감각적인 만족을 추구하되, 과소비를 줄이고 균형 잡힌 소비 습관 형성. 패션, 뷰티, 예술 등 취향을 반영하되, 예산을 고려한 소비 패턴 유지.',
    imageURL: 'assets/images/planet_icon/VENUS.png',
    iconsURL: 'assets/images/type_icon/artist_palette.png',
    mbtiTypes: ['ESFP', 'ESFJ'],
  ),
  PlanetModel(
    code: 'EARTH',
    name: '지구',
    number: 3,
    summary: '계획적 소비형',
    description:
    '불필요한 지출을 줄이고, 철저한 예산 관리와 저축을 실천. 실용적이고 내구성이 좋은 제품을 선택하며, 경제적인 안정성을 높이는 소비 패턴 정착.',
    imageURL: 'assets/images/planet_icon/EARTH.png',
    iconsURL: 'assets/images/type_icon/money_bag.png',
    mbtiTypes: ['ISTJ', 'ESTJ'],
  ),
  PlanetModel(
    code: 'MARS',
    name: '화성',
    number: 4,
    summary: '경험 중심 소비형',
    description:
    '단순한 물건 구매를 줄이고, 삶의 질을 높이는 경험 소비를 늘리기. 충동 구매를 줄이고, 여행·레저·문화 활동 등 의미 있는 소비 습관 형성.',
    imageURL: 'assets/images/planet_icon/MARS.png',
    iconsURL: 'assets/images/type_icon/roller_coaster.png',
    mbtiTypes: ['ISTP', 'ESTP'],
  ),
  PlanetModel(
    code: 'JUPITER',
    name: '목성',
    number: 5,
    summary: '가치 투자형 소비',
    description:
    '단순한 브랜드 소비를 넘어서, 자신에게 장기적으로 도움이 되는 소비를 추구. 프리미엄 제품보다는 자기 계발, 건강, 교육 등에 투자.',
    imageURL: 'assets/images/planet_icon/JUPITER.png',
    iconsURL: 'assets/images/type_icon/crown.png',
    mbtiTypes: ['ENTJ', 'ENFJ'],
  ),
  PlanetModel(
    code: 'SATURN',
    name: '토성',
    number: 6,
    summary: '절약 & 실속 소비형',
    description:
    '필요한 곳에만 돈을 쓰고, 가성비 높은 소비 습관을 기르기. DIY, 중고 거래, 구독 서비스 등을 활용해 낭비 없는 소비 생활 정착.',
    imageURL: 'assets/images/planet_icon/SATURN.png',
    iconsURL: 'assets/images/type_icon/objects.png',
    mbtiTypes: ['ISTP', 'ISFP'],
  ),
  PlanetModel(
    code: 'URANUS',
    name: '천왕성',
    number: 7,
    summary: '가치 중심 소비형',
    description:
    '새로운 기술과 트렌드를 현명하게 활용하는 소비 습관 기르기. 최신 IT 기기, 구독 경제, 공유 서비스 등을 적극적으로 활용하여 효율적인 소비 패턴 형성.',
    imageURL: 'assets/images/planet_icon/URANUS.png',
    iconsURL: 'assets/images/type_icon/rocket.png',
    mbtiTypes: ['ENFP', 'ENTP'],
  ),
  PlanetModel(
    code: 'NEPTUNE',
    name: '해왕성',
    number: 8,
    summary: '균형 잡힌 감각적 소비형',
    description:
    '소비를 통해 자신의 철학과 가치관을 반영하는 습관 기르기. 윤리적 소비, 친환경 브랜드, 사회적 가치를 중시하는 소비 습관을 정착.',
    imageURL: 'assets/images/planet_icon/NEPTUNE.png',
    iconsURL: 'assets/images/type_icon/sparkles.png',
    mbtiTypes: ['INFJ', 'INFP'],
  ),
];


PlanetModel classifyPlanet(Map<String, int> answers) {
  // 1) 4개 지표별 다수결
  final eCount = ['q1', 'q2', 'q3']
      .fold<int>(0, (sum, k) => sum + ((answers[k] ?? 0) == 0 ? 1 : 0));
  final iCount = 3 - eCount;
  final first = eCount >= 2 ? 'E' : 'I';

  final nCount = ['q4', 'q5', 'q6']
      .fold<int>(0, (sum, k) => sum + ((answers[k] ?? 0) == 0 ? 1 : 0));
  final sCount = 3 - nCount;
  final second = nCount >= 2 ? 'N' : 'S';

  final fCount = ['q7', 'q8', 'q9']
      .fold<int>(0, (sum, k) => sum + ((answers[k] ?? 0) == 0 ? 1 : 0));
  final tCount = 3 - fCount;
  final third = fCount >= 2 ? 'T' : 'F';

  final pCount = ['q10', 'q11', 'q12']
      .fold<int>(0, (sum, k) => sum + ((answers[k] ?? 0) == 0 ? 1 : 0));
  final jCount = 3 - pCount;
  final fourth = pCount >= 2 ? 'J' : 'P';

  final mbti = '$first$second$third$fourth';

  return planetList.firstWhere(
        (planet) => planet.mbtiTypes.contains(mbti),
    orElse: () => planetList[0],
  );

}
