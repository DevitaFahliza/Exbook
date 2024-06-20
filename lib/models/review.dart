class Review {
  final String id;
  final String bookId;
  final String user;
  final String comment;
  final double rating;

  Review(
      {required this.id,
      required this.bookId,
      required this.user,
      required this.comment,
      required this.rating});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      bookId: json['bookId'],
      user: json['user'],
      comment: json['comment'],
      rating: json['rating'].toDouble(),
    );
  }
}
