import 'package:biblioteca_jogos/utils/secrets.dart';
import 'package:biblioteca_jogos/utils/urls_api.dart';
import 'package:http/http.dart';

class Repository {
  Future<Response> recommendations(dynamic responseBody) async {
    final time = (DateTime.now().microsecondsSinceEpoch / 1000000).round();
    const fields =
        'fields name,cover.url,platforms.name,release_dates.human,rating,summary,genres.name';
    final where = 'where follows > 10 & release_dates.date < $time';
    const limit = 'limit 100';
    const sort = 'sort first_release_date desc';

    return await post(
      APIUrl.searchUrl,
      headers: {
        "Client-ID": Secret.clientID,
        "Authorization": "Bearer ${responseBody["access_token"]}",
      },
      body: '$fields; $where; $limit; $sort;',
    );
  }

  Future<Response> searchGamesByid(
      dynamic responseBody, List<String> ids_list) async {
    final fields = 'fields name,cover.url';
    final ids = ids_list.toString().substring(1, ids_list.toString().length);
    final where = 'where id = ($ids)';

    return await post(
      APIUrl.searchUrl,
      headers: {
        "Client-ID": Secret.clientID,
        "Authorization": "Bearer ${responseBody["access_token"]}",
      },
      body: '$fields; $where;',
    );
  }

  Future<Response> searchByText(dynamic responseBody, String busca) async {
    final fields =
        'search "$busca"; fields name,cover.url,platforms.name,release_dates.human,rating,summary,genres.name';
    const limit = 'limit 100';

    return await post(
      APIUrl.searchUrl,
      headers: {
        "Client-ID": Secret.clientID,
        "Authorization": "Bearer ${responseBody["access_token"]}",
      },
      body: '$fields; $limit;',
    );
  }

  Future<Response> auth() async {
    return await post(APIUrl.authUrl);
  }
}
