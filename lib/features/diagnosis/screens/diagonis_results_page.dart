import 'package:flutter/material.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class DiagnosisResultsPage extends StatefulWidget {
  const DiagnosisResultsPage({super.key});

  @override
  State<DiagnosisResultsPage> createState() => _DiagnosisResultsPageState();
}

class _DiagnosisResultsPageState extends State<DiagnosisResultsPage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    //Simulate loading
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(
        index,
        curve: Curves.easeInOut,
        // duration: const Duration(milliseconds: 900),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: TColors.primaryColor,
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  iconTheme: const IconThemeData(color: Colors.white),
                  expandedHeight: 150.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/diagnosis/pexels-cottonbro-studio-6203473(1).jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Common cold',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                //?Two switchable tabs to display either details or Treatment results
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      // width: TDeviceUtils.getScreenWidth(context) * 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _onTabSelected(0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _selectedIndex == 0 ? Colors.green : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Tab(
                                  child: Text(
                                    'Diagnosis',
                                    style: TextStyle(
                                      color: _selectedIndex == 0 ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _onTabSelected(1),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _selectedIndex == 1 ? Colors.green : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Tab(
                                  child: Text(
                                    'Treatment',
                                    style: TextStyle(
                                      color: _selectedIndex == 1 ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: _selectedIndex == 0 ? const DetailsTab() : const TreatmentTab(),
                ),
              ],
            ),
    );
  }
}

class DetailsTab extends StatelessWidget {
  const DetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   alignment: Alignment.center,
    //   child: const Text('Details Tab Content'),
    // );
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'The common cold is a viral infection primarily affecting the upper respiratory tract, caused by various strains of viruses, most commonly rhinoviruses.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          const Text(
            'Precautions',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'The common cold is a viral infection primarily affecting the upper respiratory tract, caused by various strains of viruses, most commonly rhinoviruses.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

class TreatmentTab extends StatelessWidget {
  const TreatmentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Medications',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'The common cold is a viral infection primarily affecting the upper respiratory tract, caused by various strains of viruses, most commonly rhinoviruses.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          const Text(
            'Precautions',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'The common cold is a viral infection primarily affecting the upper respiratory tract, caused by various strains of viruses, most commonly rhinoviruses.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
