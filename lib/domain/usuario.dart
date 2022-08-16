class Usuario {
  Usuario({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.scope,
    this.userFirstName,
    this.userId,
  });

  String? accessToken;
  String? tokenType;
  int? expiresIn;
   String? scope;
   String? userFirstName;
   int? userId;

  Usuario.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    userFirstName = json['userFirstName'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['access_token'] = accessToken;
    _data['token_type'] = tokenType;
    _data['expires_in'] = expiresIn;
    _data['scope'] = scope;
    _data['userFirstName'] = userFirstName;
    _data['userId'] = userId;
    return _data;
  }

}

