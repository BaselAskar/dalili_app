import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import './classes_list_item.dart';
import 'package:flutter/material.dart';

class Classifications extends StatefulWidget {
  @override
  State<Classifications> createState() => _ClassificationsState();
}

class _ClassificationsState extends State<Classifications> {
  HttpRequest getClassifications =
      HttpRequest(url: '/api/public/classifications');



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getClassifications.sendRequest(),
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: AppColors.primary75,
            child: ExpansionTile(
              title: SizedBox(
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.menu), Text('  الأقسام')]),
              ),
              children: (snapshot.data as List)
                  .map(
                    (cl) => buildClassificationListItem(cl),
                  )
                  .toList(),
            ),
          );
        }

        return Container();
      },
    );
  }
}
