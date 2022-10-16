import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:dalili_app/src/widgets/global/grid.dart';
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
          List classifications = snapshot.data as List;

          return Container(
            color: AppColors.primary75,
            child: ExpansionTile(
              title: SizedBox(
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.menu), Text('  الأقسام')]),
              ),
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Grid(
                      numOfCol: 2,
                      children: classifications
                          .map((cl) => ClassificationListItem(cl))
                          .toList()),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}
