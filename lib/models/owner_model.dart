/// A model class representing the owner of a Stack Exchange item.
class Owner {
  int? _accountId;
  int? _reputation;
  int? _userId;
  String? _userType;
  String? _profileImage;
  String? _displayName;
  String? _link;

  /// Constructor for the [Owner] class.
  Owner({
    int? accountId,
    int? reputation,
    int? userId,
    String? userType,
    String? profileImage,
    String? displayName,
    String? link,
  })  : _accountId = accountId,
        _reputation = reputation,
        _userId = userId,
        _userType = userType,
        _profileImage = profileImage,
        _displayName = displayName,
        _link = link;

  /// Constructor for creating [Owner] from JSON data.
  Owner.fromJson(dynamic json) {
    _accountId = json['account_id'];
    _reputation = json['reputation'];
    _userId = json['user_id'];
    _userType = json['user_type'];
    _profileImage = json['profile_image'];
    _displayName = json['display_name'];
    _link = json['link'];
  }

  /// Getter for accountId.
  int? get accountId => _accountId;

  /// Getter for reputation.
  int? get reputation => _reputation;

  /// Getter for userId.
  int? get userId => _userId;

  /// Getter for userType.
  String? get userType => _userType;

  /// Getter for profileImage.
  String? get profileImage => _profileImage;

  /// Getter for displayName.
  String? get displayName => _displayName;

  /// Getter for link.
  String? get link => _link;

  /// Convert [Owner] object to JSON.
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_id'] = _accountId;
    map['reputation'] = _reputation;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['profile_image'] = _profileImage;
    map['display_name'] = _displayName;
    map['link'] = _link;
    return map;
  }
}
