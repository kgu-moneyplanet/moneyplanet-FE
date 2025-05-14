class DiaryModel {
  final bool isIncome; // true면 수입, false면 지출
  final DateTime date;
  final int amount;
  final String category; // ex: 식비, 교통/차량 등
  final String payment; // ex: 계좌이체, 카드결제 등
  final String description; // 내용
  final String memo; // 메모
  final String type; // a, b, c 타입

  DiaryModel({
    required this.isIncome,
    required this.date,
    required this.amount,
    required this.category,
    required this.payment,
    required this.description,
    required this.memo,
    required this.type,
  });
}

List<DiaryModel> DiaryMockData = [
  DiaryModel(
    isIncome: false,
    date: DateTime(2025, 4, 9),
    amount: 20000,
    category: '식비',
    payment: '카드결제',
    description: '점심 식사',
    memo: '회사 근처 식당',
    type: 'a',
  ),
  DiaryModel(
    isIncome: false,
    date: DateTime(2025, 4, 9),
    amount: 3500,
    category: '마트/편의점',
    payment: 'pay류',
    description: 'CU 편의점',
    memo: '음료수',
    type: 'a',
  ),
  DiaryModel(
    isIncome: false,
    date: DateTime(2025, 4, 9),
    amount: 5800,
    category: '교통/차량',
    payment: '현금결제',
    description: '택시',
    memo: '퇴근길',
    type: 'b',
  ),
  DiaryModel(
    isIncome: false,
    date: DateTime(2025, 4, 8),
    amount: 60000,
    category: '패션/미용',
    payment: '카드결제',
    description: '쇼핑몰 구매',
    memo: '봄옷',
    type: 'c',
  ),
  DiaryModel(
    isIncome: true,
    date: DateTime(2025, 4, 8),
    amount: 300000,
    category: '월급',
    payment: '계좌이체',
    description: '용돈',
    memo: '부모님이 보내주심',
    type: 'a',
  ),
  DiaryModel(
    isIncome: false,
    date: DateTime(2025, 4, 7),
    amount: 12000,
    category: '문화생활',
    payment: 'pay류',
    description: '넷플릭스',
    memo: '정기 구독',
    type: 'b',
  ),
  DiaryModel(
    isIncome: false,
    date: DateTime(2025, 4, 6),
    amount: 25000,
    category: '생활용품',
    payment: '카드결제',
    description: '다이소',
    memo: '청소도구',
    type: 'b',
  ),
  DiaryModel(
    isIncome: false,
    date: DateTime(2025, 4, 5),
    amount: 80000,
    category: '주거/통신',
    payment: '계좌이체',
    description: '인터넷 요금',
    memo: 'KT',
    type: 'c',
  ),
];

