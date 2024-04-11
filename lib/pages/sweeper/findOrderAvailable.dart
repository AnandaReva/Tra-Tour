import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';



class FindOrderAvailabales extends StatefulWidget {
  const FindOrderAvailabales({Key? key}) : super(key: key);

  @override
  _FindOrderAvailabalesState createState() => _FindOrderAvailabalesState();
}

class _FindOrderAvailabalesState extends State<FindOrderAvailabales> {
  final PagingController<int, OrderSummary> _pagingController =
      PagingController(firstPageKey: 0);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await fetchOrders(pageKey);
      final isLastPage = newItems.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<List<OrderSummary>> fetchOrders(int pageKey) async {
    final response = await http.get(
        Uri.parse('https://tratour.000webhostapp.com/findAvailableOrders.php?page=$pageKey'));
    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<OrderSummary> orders = decodedData
          .map((order) => OrderSummary(
              title: order['title'], description: order['description']))
          .toList();
      return orders;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Orders'),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView<int, OrderSummary>(
          pagingController: _pagingController,
          scrollController: _scrollController,
          builderDelegate: PagedChildBuilderDelegate<OrderSummary>(
            itemBuilder: (context, order, index) => ListTile(
              title: Text(order.title),
              subtitle: Text(order.description),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class OrderSummary {
  final String title;
  final String description;

  OrderSummary({required this.title, required this.description});
}
