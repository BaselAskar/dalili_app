import 'package:dalili_app/src/screens/seach_screen.dart';
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
            child: Column(
              children: [
                Container(
                  width: 250,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.primary),
                      borderRadius: BorderRadius.circular(12)),
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(SearchScreen.path),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(
                              Icons.search,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'البحث عن متجر أو منتج',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ExpansionTile(
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
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}
