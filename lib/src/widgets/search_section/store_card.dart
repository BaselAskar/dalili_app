import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/dimentions_utils.dart' as dym;

import './store_description.dart';
import '../../screens/store_screen.dart';

class StoreCard extends StatelessWidget {
  final Map<String, dynamic> store;

  StoreCard(this.store);

  Future<void> _launchUrl(String url) async {
    try {
      var successReq =
          await launchUrlString(url, mode: LaunchMode.externalApplication);

      if (!successReq) throw new Exception('faild to open');
    } catch (ex) {
      print(ex);
    }
  }

  void _goToStore(BuildContext context, String storeId) {
    Navigator.of(context).pushNamed(StoreScreen.path, arguments: storeId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      width: dym.maxWidthFormPreInPixel(context, 0.9, 460),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey,
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  width: constraints.maxWidth,
                  height: 120,
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      store['storePhotoUrl'],
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    store['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.storeTitle,
                      fontSize: 18,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: StoreDescription(store['description']),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'بإدارة: ',
                  style: TextStyle(
                    color: AppColors.storeTitle,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  store['manager'],
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: const Text(
                    'العنوان: ',
                    style: TextStyle(
                      color: AppColors.storeTitle,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Expanded(
                  child: Text(
                    store['address'],
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'واتساب: ',
                  style: TextStyle(
                    color: AppColors.storeTitle,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 3),
                Text(
                  store['whatsapp1'],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () => _launchUrl(
                      'https://wa.me/${(store['whatsapp1'] as String).substring(2)}'),
                  icon: Icon(Icons.whatsapp),
                  color: Colors.green,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'اتصال: ',
                  style: TextStyle(
                    color: AppColors.storeTitle,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  store['phoneNumber1'],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () => _goToStore(context, store['id']),
                    child: Row(
                      children: [
                        Icon(
                          Icons.store,
                          color: AppColors.primary,
                          size: 40,
                        ),
                        const Text(
                          'إلى المتجر',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    )),
                TextButton(
                  onPressed: () => _launchUrl(store['locationUrl']),
                  child: Row(
                    children: [
                      Icon(
                        Icons.pin_drop,
                        size: 40,
                        color: AppColors.primary,
                      ),
                      const Text(
                        'إلى الخرائط',
                        style: TextStyle(
                            fontSize: 15,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
