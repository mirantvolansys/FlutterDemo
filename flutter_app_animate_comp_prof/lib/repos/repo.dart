import 'package:flutter_app_animate_comp_prof/models/company.dart';

class RepoData {
  static final company bawp = new company(
      name: "Build App with paulo",
      location: "Spokane, WA",
      logo: "images/logo.png",
      backdropPhoto: "images/bawp_creator.jpeg",
      about: "sfioyu aksfhksjf jahjkdhasjkd iujshdjkashdjkashd ijahsdjkash djkahsdjh ajksd asjdhjwq ehjkqwhejawhejahdjkh jkhjkhj jkh",
      courses: <course>[
        new course(
            title: "The complete Android & Java Bootcamp",
            thumbnail: "images/android_bootcamp.jpeg",
            url: "https://www.google.com/"),

        new course(
            title: "Kotlin Android develeopment",
            thumbnail: "images/kotlin.png",
            url: "https://www.google.com/"),

        new course(
            title: "Java 9 Master",
            thumbnail: "images/java9_course.png",
            url: "https://www.google.com/"),

        new course(
            title: "Android developer portfolio",
            thumbnail: "images/android_portfolio.jpeg",
            url: "https://www.google.com/"),
      ]);
}