import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import './classes_list_item.dart';
import 'package:flutter/material.dart';

class Classifications extends StatefulWidget {
  @override
  State<Classifications> createState() => _ClassificationsState();
}

class _ClassificationsState extends State<Classifications> {
  bool _isIntialed = false;

  var _classifications = [];

  bool _isShowList = false;

  HttpRequest getClassifications =
      HttpRequest(url: '/api/public/classifications');

  void classification() async {
    var data = await getClassifications.sendRequest();

    _classifications = data;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_isIntialed) {
      getClassifications.sendRequest().then((data) {
        setState(() {
          _classifications = data;
          _isIntialed = true;
        });
      }).catchError((err) => print(err['message']));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary75,
      child: ExpansionTile(
        title: SizedBox(
          width: double.infinity,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Icon(Icons.menu), Text('  الأقسام')]),
        ),
        children: _classifications
            .map(
              (cl) => buildClassificationListItem(cl),
            )
            .toList(),
      ),
    );
  }
}
