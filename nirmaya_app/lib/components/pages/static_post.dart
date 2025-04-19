import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../common/appbar.dart';
import '../common/bottombar.dart';

class StaticPost extends StatefulWidget {
  final Map<String, dynamic> postData;

  const StaticPost({super.key, required this.postData});

  @override
  State<StaticPost> createState() => _StaticPostState();
}

class _StaticPostState extends State<StaticPost> {
  late String likes = '0';
  late String dislikes = '0';
  late String comments = '0';
  late bool likedIcon = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.postData;

    return Scaffold(
      appBar: Appbar(title: post['title']['rendered']),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image for static post
                    post['is_asset']
                        ? Image.asset(
                            post['featured_image_url'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 260.0,
                          )
                        : Image.network(
                            post['featured_image_url'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 260.0,
                          ),
                    const SizedBox(height: 20),
                    // Content
                    Html(data: '''
                      <h2>${post['title']['rendered']}</h2>
                      <p>${post['content']['rendered']}</p>
                    '''),
                    const SizedBox(height: 20),
                    // Like/Dislike buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            likedIcon
                                ? Icons.thumb_up
                                : Icons.thumb_up_alt_outlined,
                            color: likedIcon ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              likedIcon = !likedIcon;
                              if (likedIcon) {
                                likes = (int.parse(likes) + 1).toString();
                              } else {
                                likes = (int.parse(likes) - 1).toString();
                              }
                            });
                          },
                        ),
                        Text(likes),
                        const SizedBox(width: 30),
                        IconButton(
                          icon: const Icon(Icons.thumb_down_alt_outlined),
                          onPressed: () {
                            // Add dislike functionality
                          },
                        ),
                        Text(dislikes),
                      ],
                    ),
                    const Divider(
                      height: 2.0,
                      color: Colors.black26,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Bottombar(currentIndex: 0),
    );
  }
}
