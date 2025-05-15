// 행성들 정보 Data

class PlanetModel {
  final String name;
  final int number;
  final String summary;
  final String description;
  final String imageURL;
  final String iconsURL;

  PlanetModel({
    required this.name,
    required this.number,
    required this.summary,
    required this.description,
    required this.imageURL,
    required this.iconsURL,
  });
}

List<PlanetModel> planetList = [
  PlanetModel(
    name: '수성',
    summary: '분석적 소비형',
    description:
        '충동적인 소비를 줄이고, 데이터를 기반으로 신중한 소비를 추구. 제품 리뷰, 가격 변동, 장기적 가치를 고려하여 현명한 소비 습관 형성.',
    imageURL: 'assets/images/planet_icon/planet1.png',
    number: 1,
    iconsURL: 'assets/images/type_icon/reading_glasses.png',
  ),
  PlanetModel(
    name: '금성',
    summary: '균형 잡힌 감각적 소비형',
    description:
        '감각적인 만족을 추구하되, 과소비를 줄이고 균형 잡힌 소비 습관 형성. 패션, 뷰티, 예술 등 취향을 반영하되, 예산을 고려한 소비 패턴 유지.',
    imageURL: 'assets/images/planet_icon/planet2.png',
    number: 2,
    iconsURL: 'assets/images/type_icon/artist_palette.png',
  ),
  PlanetModel(
    name: '지구',
    summary: '계획적 소비형',
    description:
        '불필요한 지출을 줄이고, 철저한 예산 관리와 저축을 실천. 실용적이고 내구성이 좋은 제품을 선택하며, 경제적인 안정성을 높이는 소비 패턴 정착.',
    imageURL: 'assets/images/planet_icon/planet3.png',
    number: 3,
    iconsURL: 'assets/images/type_icon/money_bag.png',
  ),
  PlanetModel(
    name: '화성',
    summary: '경험 중심 소비형',
    description:
        '단순한 물건 구매를 줄이고, 삶의 질을 높이는 경험 소비를 늘리기. 충동 구매를 줄이고, 여행·레저·문화 활동 등 의미 있는 소비 습관 형성.',
    imageURL: 'assets/images/planet_icon/planet4.png',
    number: 4,
    iconsURL: 'assets/images/type_icon/roller_coaster.png',
  ),
  PlanetModel(
    name: '목성',
    summary: '가치 투자형 소비',
    description:
        '단순한 브랜드 소비를 넘어서, 자신에게 장기적으로 도움이 되는 소비를 추구. 프리미엄 제품보다는 자기 계발, 건강, 교육 등에 투자.',
    imageURL: 'assets/images/planet_icon/planet5.png',
    number: 5,
    iconsURL: 'assets/images/type_icon/crown.png',
  ),
  PlanetModel(
    name: '토성',
    summary: '절약 & 실속 소비형',
    description:
        '필요한 곳에만 돈을 쓰고, 가성비 높은 소비 습관을 기르기. DIY, 중고 거래, 구독 서비스 등을 활용해 낭비 없는 소비 생활 정착.',
    imageURL: 'assets/images/planet_icon/planet6.png',
    number: 6,
    iconsURL: 'assets/images/type_icon/objects.png',
  ),
  PlanetModel(
    name: '천왕성',
    summary: '가치 중심 소비형',
    description:
        '새로운 기술과 트렌드를 현명하게 활용하는 소비 습관 기르기. 최신 IT 기기, 구독 경제, 공유 서비스 등을 적극적으로 활용하여 효율적인 소비 패턴 형성.',
    imageURL: 'assets/images/planet_icon/planet7.png',
    number: 7,
    iconsURL: 'assets/images/type_icon/rocket.png',
  ),
  PlanetModel(
    name: '해왕성',
    summary: '균형 잡힌 감각적 소비형',
    description:
        '소비를 통해 자신의 철학과 가치관을 반영하는 습관 기르기. 윤리적 소비, 친환경 브랜드, 사회적 가치를 중시하는 소비 습관을 정착.',
    imageURL: 'assets/images/planet_icon/planet8.png',
    number: 8,
    iconsURL: 'assets/images/type_icon/sparkles.png',
  ),


];
PlanetModel classifyPlanet(Map<String, int> answers) {
  const groups = [
    ['q1', 'q2', 'q3', 'q4'],
    ['q5', 'q6', 'q7', 'q8'],
    ['q9', 'q10', 'q11', 'q12'],
  ];

  final bits = groups.map((keys) {
    final sum = keys.fold<int>(0, (acc, key) => acc + (answers[key] ?? 0));
    return sum >= 3 ? 1 : 0;
  }).toList();

  final mask = (bits[0] << 0) | (bits[1] << 1) | (bits[2] << 2);
  return planetList[mask];
}