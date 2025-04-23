class Constants {
  static String mainUrl = "http://10.0.2.2:3000/api/v1/";

  //auth endpoints
  static const String registerEndPoint = "registerUser";
  static const String loginEndPoint = "loginUser";
  static const String refreshTokenEndPoint = "refresh";

  //products endpoints 
  static const String getAllProductsEndpoint = "products";

  //api keys Names 
  static const String apiRefreshTokenName = "refresh_token";
  static const String apiAccessTokenName = "access_token";

  //secure storage keys
  static const String accessTokenKey = "accessToken";
  static const String refreshTokenKey = "refreshToken";
}
