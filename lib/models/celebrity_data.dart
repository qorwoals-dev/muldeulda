import 'dart:math';

/// 퍼스널 컬러가 같은 것으로 알려진 연예인 한 명.
/// [subtype]은 커뮤니티에서 통용되는 세부 톤 표기(라이트/브라이트/뮤트/딥/스트롱 등)로,
/// 없는 경우도 있다.
class Celebrity {
  final String name;
  final String? subtype;
  const Celebrity(this.name, [this.subtype]);

  /// 이름 기반으로 고정된(=재실행해도 안 바뀌는) 90~99% 매칭 지수.
  /// 실제 정밀 측정치가 아니라 재미 요소용 수치다.
  int matchScore() => 90 + (name.hashCode.abs() % 10);
}

/// 4계절 퍼스널 컬러별 대표 연예인 목록.
/// 출처: 커뮤니티에서 통용되는 퍼스널 컬러 진단 사례 모음.
class CelebrityData {
  CelebrityData._();

  static const springWarm = <Celebrity>[
    Celebrity('강형욱'),
    Celebrity('강호동', '라이트'),
    Celebrity('고창석', '라이트'),
    Celebrity('걸스데이 혜리', '라이트'),
    Celebrity('라이관린', '라이트'),
    Celebrity('러블리즈 류수정', '브라이트'),
    Celebrity('르세라핌 사쿠라', '라이트'),
    Celebrity('박민영'),
    Celebrity('샤이니 키', '라이트'),
    Celebrity('샤이니 태민', '브라이트'),
    Celebrity('세븐틴 승관'),
    Celebrity('소녀시대 윤아', '라이트'),
    Celebrity('송혜교', '라이트'),
    Celebrity('수지', '브라이트'),
    Celebrity('스테이씨 세은', '라이트'),
    Celebrity('아이유', '브라이트'),
    Celebrity('엔시티 정우'),
    Celebrity('엔시티 태용'),
    Celebrity('오마이걸 아린', '라이트'),
    Celebrity('오은영', '라이트'),
    Celebrity('우주소녀 루다', '브라이트'),
    Celebrity('이연희', '라이트'),
    Celebrity('한지민', '라이트'),
    Celebrity('한지현'),
    Celebrity('환승연애2 나연'),
    Celebrity('아이들 슈화', '봄라~여라'),
  ];

  static const summerCool = <Celebrity>[
    Celebrity('김구라', '뮤트'),
    Celebrity('김재욱', '뮤트'),
    Celebrity('김혜윤', '라이트'),
    Celebrity('노라조 조빈', '뮤트'),
    Celebrity('더보이즈 영훈'),
    Celebrity('딘딘', '뮤트'),
    Celebrity('레드벨벳 슬기', '뮤트'),
    Celebrity('레드벨벳 아이린', '브라이트'),
    Celebrity('마마무 화사', '라이트'),
    Celebrity('모모랜드 낸시', '뮤트'),
    Celebrity('몬스타엑스 민혁', '뮤트'),
    Celebrity('박명수', '라이트'),
    Celebrity('방탄소년단 지민', '뮤트'),
    Celebrity('방탄소년단 진', '뮤트'),
    Celebrity('백종원', '라이트'),
    Celebrity('베리베리 강민', '라이트'),
    Celebrity('비투비 육성재', '뮤트'),
    Celebrity('샘 오취리', '뮤트'),
    Celebrity('서장훈', '라이트'),
    Celebrity('세븐틴 디노', '브라이트'),
    Celebrity('세븐틴 민규'),
    Celebrity('세븐틴 에스쿱스'),
    Celebrity('세븐틴 우지'),
    Celebrity('세븐틴 원우'),
    Celebrity('세븐틴 정한'),
    Celebrity('세븐틴 호시'),
    Celebrity('소녀시대 태연', '뮤트'),
    Celebrity('손예진', '라이트'),
    Celebrity('슈퍼주니어 규현'),
    Celebrity('스트레이키즈 리노'),
    Celebrity('신혜선'),
    Celebrity('아스트로 문빈', '뮤트'),
    Celebrity('아스트로 차은우', '라이트'),
    Celebrity('아이브 장원영', '뮤트'),
    Celebrity('SF9 로운', '뮤트'),
    Celebrity('에이오에이 설현', '라이트'),
    Celebrity('엑소 세훈', '뮤트'),
    Celebrity('엑소 시우민'),
    Celebrity('엔시티 마크', '라이트'),
    Celebrity('옹성우'),
    Celebrity('우주소녀 설아', '브라이트'),
    Celebrity('유재석', '뮤트'),
    Celebrity('이광수', '뮤트'),
    Celebrity('이영애'),
    Celebrity('전지현'),
    Celebrity('정채연', '라이트'),
    Celebrity('조규성', '브라이트'),
    Celebrity('조승연', '뮤트'),
    Celebrity('트와이스 나연', '라이트'),
    Celebrity('트와이스 다현', '뮤트'),
    Celebrity('트와이스 사나', '뮤트'),
    Celebrity('하이라이트 윤두준', '라이트'),
    Celebrity('한현민', '라이트'),
    Celebrity('홍석천', '라이트'),
  ];

  static const autumnWarm = <Celebrity>[
    Celebrity('강혜원', '딥'),
    Celebrity('김구라', '뮤트'),
    Celebrity('김민주', '스트롱'),
    Celebrity('김세정', '딥'),
    Celebrity('김유정', '딥'),
    Celebrity('뉴이스트 황민현', '뮤트'),
    Celebrity('뉴진스 민지'),
    Celebrity('뉴진스 해린', '스트롱'),
    Celebrity('더보이즈 뉴', '뮤트'),
    Celebrity('더보이즈 주연'),
    Celebrity('더보이즈 현재', '뮤트'),
    Celebrity('러블리즈 이미주', '뮤트'),
    Celebrity('러블리즈 케이', '딥'),
    Celebrity('레드벨벳 예리', '스트롱'),
    Celebrity('레드벨벳 웬디', '뮤트'),
    Celebrity('레드벨벳 조이', '스트롱'),
    Celebrity('르세라핌 김채원', '뮤트'),
    Celebrity('르세라핌 허윤진', '뮤트'),
    Celebrity('박보영', '뮤트'),
    Celebrity('박서준', '뮤트'),
    Celebrity('박성웅', '딥'),
    Celebrity('블랙핑크 로제', '뮤트'),
    Celebrity('블랙핑크 리사', '뮤트'),
    Celebrity('블랙핑크 제니', '뮤트'),
    Celebrity('블랙핑크 지수', '뮤트'),
    Celebrity('빅톤 한승우', '뮤트'),
    Celebrity('서은광', '딥'),
    Celebrity('선미', '뮤트'),
    Celebrity('세븐틴 도겸', '딥'),
    Celebrity('세븐틴 버논', '스트롱'),
    Celebrity('세븐틴 준', '뮤트'),
    Celebrity('송가인', '뮤트'),
    Celebrity('스테이씨 세은', '뮤트'),
    Celebrity('신세경', '뮤트'),
    Celebrity('아이브 안유진', '딥/스트롱'),
    Celebrity('업텐션 김우석', '딥'),
    Celebrity('에스파 닝닝', '스트롱'),
    Celebrity('에스파 윈터', '뮤트'),
    Celebrity('에스파 지젤'),
    Celebrity('에이비식스 이대휘', '뮤트'),
    Celebrity('엑소 카이', '딥'),
    Celebrity('엔믹스 설윤', '뮤트'),
    Celebrity('엔시티 재현'),
    Celebrity('엔시티 쟈니'),
    Celebrity('엔시티 태일', '뮤트'),
    Celebrity('엔시티 해찬'),
    Celebrity('오마이걸 유아', '뮤트'),
    Celebrity('이성경', '뮤트'),
    Celebrity('이효리'),
    Celebrity('있지 류진', '딥'),
    Celebrity('있지 유나', '딥'),
    Celebrity('있지 채령', '뮤트'),
    Celebrity('전현무', '딥'),
    Celebrity('정유미'),
    Celebrity('조유리', '뮤트'),
    Celebrity('케플러 김채현', '뮤트'),
    Celebrity('투바투 휴닝카이', '뮤트'),
    Celebrity('트와이스 모모', '뮤트 소프트'),
    Celebrity('트와이스 미나', '딥'),
    Celebrity('트와이스 정연', '뮤트'),
    Celebrity('트와이스 지효', '딥'),
    Celebrity('트와이스 쯔위', '딥'),
    Celebrity('한소희', '뮤트/딥'),
    Celebrity('환승연애2 나언'),
  ];

  static const winterCool = <Celebrity>[
    Celebrity('곽윤기'),
    Celebrity('국가스텐 하현우', '딥'),
    Celebrity('권은비', '브라이트'),
    Celebrity('김혜수'),
    Celebrity('몬스타엑스 형원', '딥'),
    Celebrity('세븐틴 조슈아'),
    Celebrity('문근영', '딥'),
    Celebrity('방탄소년단 뷔', '브라이트'),
    Celebrity('아이들 소연', '딥'),
    Celebrity('SF9 태양', '딥'),
    Celebrity('아스트로 제이알', '딥'),
    Celebrity('에스파 카리나'),
    Celebrity('엑소 디오', '딥'),
    Celebrity('엔시티 도영'),
    Celebrity('왕이보', '딥'),
    Celebrity('이다희'),
    Celebrity('이정재', '딥'),
    Celebrity('지석진', '딥'),
    Celebrity('트와이스 채영', '브라이트'),
    Celebrity('하이라이트 양요섭', '브라이트'),
    Celebrity('호날두', '브라이트'),
  ];

  static List<Celebrity> forSeason(String seasonId) {
    switch (seasonId) {
      case 'spring_warm':
        return springWarm;
      case 'summer_cool':
        return summerCool;
      case 'autumn_warm':
        return autumnWarm;
      case 'winter_cool':
        return winterCool;
      default:
        return const [];
    }
  }

  /// 해당 시즌에서 서로 다른 연예인 [count]명을 무작위로 뽑는다.
  static List<Celebrity> pickRandom(String seasonId, {int count = 1}) {
    final pool = List<Celebrity>.from(forSeason(seasonId))..shuffle(Random());
    return pool.take(count).toList();
  }
}
