class Course {
  final String id;
  final String courseName;
  final String description;
  final int maximum;
  final double price;
  final String location;
  final double? lat;
  final double? lng;
  final String present;
  final String teacher;
  final String mainImage;
  final String coverImage;
  final bool isApproved;
  final int? creditHour;
  final List<VideoLecture> videoLectures;
  final int? rating;
  Course({
    required this.id,
    required this.courseName,
    required this.description,
    required this.maximum,
    required this.price,
    required this.location,
    this.lat,
    this.lng,
    required this.present,
    required this.teacher,
    required this.mainImage,
    required this.coverImage,
    required this.isApproved,
    this.creditHour,
    required this.videoLectures,
    this.rating,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      courseName: json['courseName'],
      description: json['description'],
      maximum: json['maximum'],
      price: json['price'].toDouble(),
      location: json['location'],
      lat: json['lat'] != null ? double.parse(json['lat']) : null,
      lng: json['lng'] != null ? double.parse(json['lng']) : null,
      present: json['present'],
      teacher: json['teacher'],
      mainImage: json['mainImage'],
      coverImage: json['coverImage'],
      isApproved: json['isApproved'],
      creditHour: json['CriditHoure'],
      rating: json['rating'],
      videoLectures: (json['videoLectures'] as List<dynamic>)
          .map((lectureJson) => VideoLecture.fromJson(lectureJson))
          .toList(),
    );
  }
}

class VideoLecture {
  final String id;
  final String video;
  final String title;
  final String thumbnailData;

  final String description;
  final String duration;
  VideoLecture({
    required this.id,
    required this.video,
    required this.title,
    required this.thumbnailData,

    required this.description,
    required this.duration,
  });

  factory VideoLecture.fromJson(Map<String, dynamic> json) {
    return VideoLecture(
      id: json['_id'],
      video: json['video'],
      title: json['title'],
      thumbnailData: json['thumbnailData'],
      description: json['description'],
      duration: json['duration'],
    );
  }
}


