import 'package:ayurveda/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants/apis.dart';
import '../common/horizontalposts.dart';
import '../common/bottombar.dart';

class Categories extends StatefulWidget {
  final String? username;

  const Categories({super.key, this.username});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final List<Map<String, dynamic>> staticHomeRemedies = [
    {
      'id': 1001,
      'title': {'rendered': 'Turmeric Milk for Acidity'},
      'content': {
        'rendered': '''
        <h3>Turmeric Milk Recipe for Acidity Relief</h3>
        <p>This traditional Ayurvedic remedy helps soothe stomach lining and reduce acid reflux.</p>
        <h4>Ingredients:</h4>
        <ul>
          <li>1 cup warm milk (dairy or plant-based)</li>
          <li>1/2 teaspoon turmeric powder</li>
          <li>1/4 teaspoon black pepper (enhances turmeric absorption)</li>
          <li>1 teaspoon ghee (optional)</li>
        </ul>
        <h4>Instructions:</h4>
        <ol>
          <li>Heat milk until warm but not boiling</li>
          <li>Add turmeric and black pepper, stir well</li>
          <li>Add ghee if using</li>
          <li>Drink before bedtime for best results</li>
        </ol>
        <h4>Benefits:</h4>
        <ul>
          <li>Reduces inflammation in digestive tract</li>
          <li>Helps heal stomach lining</li>
          <li>Natural antacid properties</li>
        </ul>
      '''
      },
      'featured_image_url': 'assets/images/acidity.jpg',
      'is_asset': true,
      'categories': [4]
    },
    {
      'id': 1002,
      'title': {'rendered': 'Ginger Tea for Stomach Ache'},
      'content': {
        'rendered': '''
        <h3>Ginger Tea for Digestive Relief</h3>
        <p>Ginger has powerful anti-inflammatory properties that help with various digestive issues.</p>
        <h4>Ingredients:</h4>
        <ul>
          <li>1 cup water</li>
          <li>1-inch fresh ginger root, sliced</li>
          <li>1 teaspoon honey (optional)</li>
          <li>Few drops of lemon juice (optional)</li>
        </ul>
        <h4>Instructions:</h4>
        <ol>
          <li>Bring water to a boil</li>
          <li>Add ginger slices and simmer for 5 minutes</li>
          <li>Strain into a cup</li>
          <li>Add honey and lemon if desired</li>
          <li>Drink warm 2-3 times daily as needed</li>
        </ol>
        <h4>Benefits:</h4>
        <ul>
          <li>Relieves nausea and indigestion</li>
          <li>Reduces bloating and gas</li>
          <li>Stimulates digestive enzymes</li>
        </ul>
      '''
      },
      'featured_image_url': 'assets/images/stomache.jpg',
      'is_asset': true,
      'categories': [4]
    }
  ];

  Future<Map<String, List<dynamic>>> fetchPosts() async {
    const String postsapiurl =
        '${postsApi}2,3,4,5,6,7,8,9,10,11,12&per_page=50';
    final response = await http.get(Uri.parse(postsapiurl));

    if (response.statusCode == 200) {
      final List<dynamic> posts = json.decode(response.body);
      Map<String, List<Map<String, dynamic>>> categorizedPosts = {};

      for (var post in posts) {
        int categoryid = post['categories'][0];
        String categoryName = 'category_$categoryid';
        post['is_asset'] = false;
        categorizedPosts.putIfAbsent(categoryName, () => []).add(post);
      }

      categorizedPosts.update(
        'category_4',
        (list) => list..addAll(staticHomeRemedies),
        ifAbsent: () => [...staticHomeRemedies],
      );

      return categorizedPosts;
    } else {
      throw Exception(
          'Failed to fetch categories. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService.getUserData(),
      builder: (context, snapshot) {
        final displayName = snapshot.data?['displayName'] ?? 'Guest';

        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Categories'),
                Text(
                  displayName,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            backgroundColor: const Color(0xfff7770f),
            automaticallyImplyLeading: false,
          ),
          backgroundColor: Colors.black,
          body: SafeArea(
            child: FutureBuilder<Map<String, List<dynamic>>>(
              future: fetchPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 222, 205, 252),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Error loading posts",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "No posts available",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final categorizedPosts = snapshot.data!;

                return ListView(
                  padding: const EdgeInsets.all(15.0),
                  children: [
                    HorizontalPosts(
                      key: const Key('dry_fruits'),
                      categoryName: 'Dry Fruits',
                      posts: categorizedPosts['category_2'] ?? [],
                    ),
                    HorizontalPosts(
                      key: const Key('ayurvedic_medicines'),
                      categoryName: 'Ayurvedic Medicines',
                      posts: categorizedPosts['category_3'] ?? [],
                    ),
                    HorizontalPosts(
                      key: const Key('home_remedies'),
                      categoryName: 'Home Remedies',
                      posts: categorizedPosts['category_4'] ?? [],
                    ),
                    HorizontalPosts(
                      key: const Key('yoga'),
                      categoryName: 'Yoga',
                      posts: categorizedPosts['category_5'] ?? [],
                    ),
                    HorizontalPosts(
                      key: const Key('fit_daily_rutines'),
                      categoryName: 'Fit Daily Rutines',
                      posts: categorizedPosts['category_6'] ?? [],
                    ),
                    HorizontalPosts(
                      key: const Key('fruits'),
                      categoryName: 'Fruits',
                      posts: categorizedPosts['category_7'] ?? [],
                    ),
                    HorizontalPosts(
                      key: const Key('vegitables'),
                      categoryName: 'Vegetables',
                      posts: categorizedPosts['category_8'] ?? [],
                    ),
                    HorizontalPosts(
                      key: const Key('beauty_tips'),
                      categoryName: 'Beauty Tips',
                      posts: categorizedPosts['category_9'] ?? [],
                    ),
                    HorizontalPosts(
                      key: const Key('skin_fitness'),
                      categoryName: 'Skin Fitness',
                      posts: categorizedPosts['category_10'] ?? [],
                    ),
                    HorizontalPosts(
                      key: const Key('herbal_cure'),
                      categoryName: 'Herbal Cure',
                      posts: categorizedPosts['category_12'] ?? [],
                    ),
                  ],
                );
              },
            ),
          ),
          bottomNavigationBar: Bottombar(currentIndex: 0),
        );
      },
    );
  }
}
