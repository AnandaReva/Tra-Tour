class ArticlesModel {
  String title;
  String date;
  String description;
  String articleImage;

  ArticlesModel({
    required this.title,
    required this.date,
    required this.description,
    required this.articleImage,
  });

  static List<ArticlesModel> getArticles() {
    List<ArticlesModel> articles = [];
    articles.add(
      ArticlesModel(
        title: "Judul1",
        date: "17 Agustus 1945",
        description: "Rakesh anj",
        articleImage: 'assets/images/kucingg.jpeg',
      ),
    );
    articles.add(
      ArticlesModel(
        title: "Judul2",
        date: "17 Agustus 1945",
        description: "Rakesh anj",
        articleImage: 'assets/images/kucingg.jpeg',
      ),
    );
    articles.add(
      ArticlesModel(
        title: "Judul3",
        date: "17 Agustus 1945",
        description: "Rakesh anj",
        articleImage: 'assets/images/kucingg.jpeg',
      ),
    );
    articles.add(
      ArticlesModel(
        title: "Judul4",
        date: "17 Agustus 1945",
        description: "Rakesh anj",
        articleImage: 'assets/images/kucingg.jpeg',
      ),
    );
    articles.add(
      ArticlesModel(
        title: "Judul5",
        date: "17 Agustus 1945",
        description: "Rakesh anj",
        articleImage: 'assets/images/kucingg.jpeg',
      ),
    );
    return articles;
  }
}
