import '../models/celebrity_data.dart';
import '../models/season_palette.dart';

/// 서버 없이, 진단 결과를 Firebase Hosting에 올려둔 정적 진단서 페이지의
/// URL 파라미터로 인코딩한다. 그 페이지가 파라미터를 읽어 진단서를 그려주고
/// 다운로드 버튼도 제공하므로, 앱은 이 링크를 QR로 보여주기만 하면 된다.
class CertificateService {
  static const _baseUrl = 'https://muldeulda-app.web.app';

  static String buildCertificateUrl(SeasonPalette palette, DateTime issuedAt, {Celebrity? celebrity}) {
    final date = '${issuedAt.year.toString().padLeft(4, '0')}'
        '${issuedAt.month.toString().padLeft(2, '0')}'
        '${issuedAt.day.toString().padLeft(2, '0')}';
    final params = {
      'type': palette.id,
      'date': date,
      if (celebrity != null) 'celeb': celebrity.name,
      if (celebrity != null) 'score': celebrity.matchScore().toString(),
    };
    final query = params.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value)}').join('&');
    return '$_baseUrl/?$query';
  }
}
