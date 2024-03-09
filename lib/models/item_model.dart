import 'package:stack_overflow_app/models/owner_model.dart';

/// A model class representing items from a Stack Exchange API response.
class Items {
  List<String>? _tags;
  Owner? _owner;
  bool? _isAnswered;
  int? _viewCount;
  int? _answerCount;
  int? _score;
  int? _lastActivityDate;
  int? _creationDate;
  int? _lastEditDate;
  int? _questionId;
  String? _contentLicense;
  String? _link;
  String? _title;

  /// Constructor for the [Items] class.
  Items({
    List<String>? tags,
    Owner? owner,
    bool? isAnswered,
    int? viewCount,
    int? answerCount,
    int? score,
    int? lastActivityDate,
    int? creationDate,
    int? lastEditDate,
    int? questionId,
    String? contentLicense,
    String? link,
    String? title,
  })  : _tags = tags,
        _owner = owner,
        _isAnswered = isAnswered,
        _viewCount = viewCount,
        _answerCount = answerCount,
        _score = score,
        _lastActivityDate = lastActivityDate,
        _creationDate = creationDate,
        _lastEditDate = lastEditDate,
        _questionId = questionId,
        _contentLicense = contentLicense,
        _link = link,
        _title = title;

  /// Constructor for creating [Items] from JSON data.
  Items.fromJson(dynamic json) {
    _tags = json['tags'] != null ? List<String>.from(json['tags']) : [];
    _owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    _isAnswered = json['is_answered'];
    _viewCount = json['view_count'];
    _answerCount = json['answer_count'];
    _score = json['score'];
    _lastActivityDate = json['last_activity_date'];
    _creationDate = json['creation_date'];
    _lastEditDate = json['last_edit_date'];
    _questionId = json['question_id'];
    _contentLicense = json['content_license'];
    _link = json['link'];
    _title = json['title'];
  }

  /// Getter for tags.
  List<String>? get tags => _tags;

  /// Getter for owner.
  Owner? get owner => _owner;

  /// Getter for isAnswered.
  bool? get isAnswered => _isAnswered;

  /// Getter for viewCount.
  int? get viewCount => _viewCount;

  /// Getter for answerCount.
  int? get answerCount => _answerCount;

  /// Getter for score.
  int? get score => _score;

  /// Getter for lastActivityDate.
  int? get lastActivityDate => _lastActivityDate;

  /// Getter for creationDate.
  int? get creationDate => _creationDate;

  /// Getter for lastEditDate.
  int? get lastEditDate => _lastEditDate;

  /// Getter for questionId.
  int? get questionId => _questionId;

  /// Getter for contentLicense.
  String? get contentLicense => _contentLicense;

  /// Getter for link.
  String? get link => _link;

  /// Getter for title.
  String? get title => _title;

  /// Convert [Items] object to JSON.
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tags'] = _tags;
    if (_owner != null) {
      map['owner'] = _owner?.toJson();
    }
    map['is_answered'] = _isAnswered;
    map['view_count'] = _viewCount;
    map['answer_count'] = _answerCount;
    map['score'] = _score;
    map['last_activity_date'] = _lastActivityDate;
    map['creation_date'] = _creationDate;
    map['last_edit_date'] = _lastEditDate;
    map['question_id'] = _questionId;
    map['content_license'] = _contentLicense;
    map['link'] = _link;
    map['title'] = _title;
    return map;
  }
}
