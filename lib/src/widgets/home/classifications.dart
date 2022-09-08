import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import './classes_list_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Classifications extends StatefulWidget {
  @override
  State<Classifications> createState() => _ClassificationsState();
}

class _ClassificationsState extends State<Classifications> {
  var _classifications = [];

  bool _isShowList = false;

  HttpRequest getClassifications =
      HttpRequest(url: '/api/public/classifications');

  @override
  void initState() {
    classification();
    // _classifications = DUMMY_DATA;
    super.initState();
  }

  void classification() async {
    var data = await getClassifications.sendRequest();

    _classifications = data;
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: double.infinity,
    //   padding: EdgeInsets.all(0),
    //   color: AppColors.secondary,
    //   child: Column(children: [
    //     ElevatedButton(
    //       style: ButtonStyle(
    //         backgroundColor: MaterialStateProperty.all(AppColors.secondary),
    //         elevation: MaterialStateProperty.all(0),
    //         overlayColor: MaterialStateProperty.resolveWith(
    //           (states) {
    //             if (states.contains(MaterialState.pressed)) {
    //               return Colors.black12;
    //             }
    //           },
    //         ),
    //       ),
    //       onPressed: () {
    //         setState(() {
    //           _isShowList = !_isShowList;
    //         });
    //       },
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: const [
    //           Text(
    //             'الأقسام  ',
    //             style: TextStyle(color: Colors.black),
    //           ),
    //           Icon(
    //             Icons.menu,
    //             color: Colors.black,
    //           ),
    //         ],
    //       ),
    //     ),

    //Classifications Lists Section
    // if (_isShowList)
    // Container(
    //   color: AppColors.secondary,
    //   child: Column(
    //     children:
    //         _classifications.map((cl) => ClassesListItem(cl)).toList(),
    //   ),
    // )

    //   ]),
    // );

    return Container(
      color: AppColors.primary75,
      child: ExpansionTile(
        title: SizedBox(
          width: double.infinity,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Icon(Icons.menu), Text('  الأقسام')]),
        ),
        children: _classifications.map((cl) => ClassesListItem(cl)).toList(),
      ),
    );
  }
}
