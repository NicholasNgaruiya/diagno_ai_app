import 'package:flutter/material.dart';
import 'package:restaurant_frontend/features/shop/admin/models/dashboard_item.dart';

class GridDashboard extends StatelessWidget {
  GridDashboard({super.key});
  final DashboardItem item1 = DashboardItem(
    title: 'Add Products',
    img: 'assets/images/dashboard_images/add-item.png',
  );

  final DashboardItem item2 = DashboardItem(
    title: 'View Orders',
    img: 'assets/images/dashboard_images/orders.png',
  );
  final DashboardItem item3 = DashboardItem(
    title: 'View Orders',
    img: 'assets/images/dashboard_images/orders.png',
  );
  final DashboardItem item4 = DashboardItem(
    title: 'View Orders',
    img: 'assets/images/dashboard_images/orders.png',
  );
  final DashboardItem item5 = DashboardItem(
    title: 'View Orders',
    img: 'assets/images/dashboard_images/orders.png',
  );

  @override
  Widget build(BuildContext context) {
    List<DashboardItem> myList = [item1, item2, item3, item4, item5];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.only(left: 16, right: 16),
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return Container(
            decoration: BoxDecoration(
              color: Color(color),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  data.img,
                  width: 42,
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  data.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
