/* import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:aplikasi_sampah/components/appBar.dart';
import 'package:aplikasi_sampah/components/footer.dart';

import 'package:aplikasi_sampah/globalVar.dart';

class PostListPage extends StatelessWidget {
  final PagingController<int, PostSummary> _pagingController;
  final _scrollController = ScrollController();

  PostListPage(this._pagingController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          _pagingController.refresh();
        },
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: ScrollConfiguration(
          behavior: MyScrollBehavior(),
          child: PostListView(
            pagingController: _pagingController,
            scrollController: _scrollController,
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}

class MyScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }
}

class PostSummary {
  final String name;
  final String title;
  final String content;
  final String username;
  final String profilePhoto;

  PostSummary({
    required this.name,
    required this.title,
    required this.content,
    required this.username,
    required this.profilePhoto, required comments, required likeCount, required attachments, required date,
  });
}

class PostListView extends StatefulWidget {
  final PagingController<int, PostSummary> pagingController;
  final ScrollController scrollController;

  const PostListView({
    Key? key,
    required this.pagingController,
    required this.scrollController,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PostListViewState createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  static const _pageSize = 5;
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
   // NewPostsMongoDatabase(globalVar: GlobalVar.instance).connect();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await getNewPosts(pageKey, _pageSize);

      final isLastPage = newItems.isEmpty || newItems.length < _pageSize;
      if (isLastPage) {
        widget.pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        widget.pagingController.appendPage(newItems, nextPageKey);
      }

      // Gunakan Timer untuk menjalankan lompatan setelah sejumlah waktu
      Timer(const Duration(milliseconds: 10), () {
        widget.scrollController
            .jumpTo(widget.scrollController.position.maxScrollExtent);
      });
    } catch (error) {
      widget.pagingController.error = error;
    }
  }

  Future<List<PostSummary>> getNewPosts(int pageKey, int pageSize) async {/*  */
/*     final data = await NewPostsMongoDatabase(globalVar: GlobalVar.instance)
        .getNewPosts(pageKey, pageSize); */

        final data = await NewPostsMongoDatabase(globalVar: GlobalVar.instance);
    return data;
  }

  @override
  Widget build(BuildContext context) => PagedListView<int, PostSummary>(
        reverse: true,
        pagingController: widget.pagingController,
        scrollController: widget.scrollController,
        builderDelegate: PagedChildBuilderDelegate<PostSummary>(
          itemBuilder: (context, item, index) => PostListItem(
            post: item,
          ),
        ),
      );

  @override
  void dispose() {
    widget.pagingController.dispose();
    super.dispose();
  }
}

class PostListItem extends StatelessWidget {
  final PostSummary post;

  static const mainColor = Color.fromRGBO(21, 16, 38, 1.0);
  static const baseColor = Color.fromRGBO(240, 240, 240, 1.0);

  const PostListItem({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // title: Text(post.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: mainColor,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.profilePhoto),
                ),
                Text(
                  post.username,
                  style: const TextStyle(
                    fontFamily: 'Poppins-Bold',
                    fontWeight: FontWeight.normal,
                    color: baseColor, // Warna teks hitam
                  ),
                ),
                Text(
                  post.title,
                  style: const TextStyle(
                    fontFamily: 'Poppins-Bold',
                    fontWeight: FontWeight.bold,
                    color: baseColor, // Warna teks hitam
                  ),
                ),
                Text(
                  post.content,
                  style: const TextStyle(
                    fontFamily: 'Poppins-Bold',
                    fontWeight: FontWeight.normal,
                    color: baseColor, // Warna teks hitam
                  ),
                  maxLines: null, // Untuk menampilkan semua teks
                ),
              ],
            ),
          ),

          // Text(post.content),
        ],
      ),
      /*  leading: CircleAvatar(
        backgroundImage: NetworkImage(post.profilePhoto),
      ), */
    );
  }
}
 */