class Book {
  final int id;
  final String title;
  final String author;
  final double price;
  final String condition;
  final String imageUrl;
  final String description;
  final int pages;
  final String publishDate;
  final String category;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.condition,
    required this.imageUrl,
    required this.description,
    required this.pages,
    required this.publishDate,
    required this.category,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      price: json['price'],
      condition: json['condition'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      pages: json['pages'],
      publishDate: json['publishDate'],
      category: json['category'],
    );
  }
}
