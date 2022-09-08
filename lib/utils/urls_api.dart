// ignore_for_file: constant_identifier_names
import 'package:biblioteca_jogos/utils/secrets.dart';

abstract class APIUrl {
  static const baseUrl = 'api.igdb.com';

  static final authUrl = Uri.https(
    'id.twitch.tv',
    '/oauth2/token',
    {
      'client_id': Secret.clientID,
      'client_secret': Secret.clientSecret,
      'grant_type': 'client_credentials',
    },
  );

  static final searchUrl = Uri.https(baseUrl, '/v4/games/');
}
