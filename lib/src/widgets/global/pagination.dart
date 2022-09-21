import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Pagination extends StatefulWidget {
  final int pageSize;
  final int numberOfPages;
  final List initialList;
  final Widget Function(BuildContext context, List listData, int index)
      itemsBuilder;

  final Function(BuildContext context, String pageNumber, String pageSize)
      getItmesRequest;

  Pagination({
    required this.pageSize,
    required this.numberOfPages,
    required this.itemsBuilder,
    required this.getItmesRequest,
    required this.initialList,
  });

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  bool _initail = false;
  List<Widget> listItems = [];
  int _pageNumber = 1;

  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    if (!_initail) {
      setState(() {
        listItems = List<Widget>.generate(widget.pageSize,
            (index) => widget.itemsBuilder(context, widget.initialList, index));
        _initail = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Future _getItems() async {
      setState(() {
        _isLoading = true;
      });
      var data = await widget.getItmesRequest(
          context, (_pageNumber + 1).toString(), widget.pageSize.toString());

      List<Widget> newItems = (data as List)
          .map<Widget>((item) =>
              widget.itemsBuilder(context, data, (data).indexOf(item)))
          .toList();

      List<Widget> newStateItems = [...listItems];
      newStateItems.addAll(newItems);

      setState(() {
        _isLoading = false;
        _pageNumber += 1;
        listItems = newStateItems;
      });
    }

    return Column(
      children: [
        ...listItems,
        if (widget.numberOfPages > _pageNumber)
          !_isLoading
              ? TextButton(
                  onPressed: () {
                    _getItems();
                  },
                  child: Text('عرض المزيد'))
              : SpinKitRing(
                  color: AppColors.primary,
                  size: 35,
                  lineWidth: 3,
                ),
      ],
    );
  }
}
