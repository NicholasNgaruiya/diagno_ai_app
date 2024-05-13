import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/shop/blocs/categories/bloc/categories_bloc.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/local_storage/storage_utility.dart';
import 'category_details_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  // late CategoriesBloc _categoriesBloc;
  @override
  Widget build(BuildContext context) {
    //Add the below ,above this widget
    // late CategoriesBloc _categoriesBloc;
    // @override
    // void initState() {
    //   super.initState();
    //   _categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    //   _categoriesBloc.add(FetchCategoriesEvent());
    // }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(
                child: CircularProgressIndicator(color: TColors.primaryColor),
              );
            } else if (state is FetchCategoriesSuccess) {
              final categories = state.categories;
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: TColors.primaryColor,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(
                          category.image ??
                              'https://www.google.com/search?client=ubuntu-sn&hs=gJ2&sa=X&sca_esv=9a71a41fad6c3417&sca_upv=1&channel=fs&biw=1920&bih=995&sxsrf=ACQVn0-unZqiOTC2RMPCAuuj41URFJqRHQ:1711981283919&si=AKbGX_paaCugDdYkuX2heTJMr0_FGRox2AzKVmiTg2eQr2d-rnKq70LLmgXYOMzLtvEbExzSwMLcP28qgB2GyZcGLa_FPg7vJ_17grm_eQJMMb2rrkPpiRFzgqNHBp-47eWUDSMMGcNFdA6cliBc47QEJx_11QZWNKFtA1i15fM1pp85fPD8rB_OMuZ_OMFXiesxa1nKtiqJDtteEQ6Ev77RLrm3iOd_LYzSpAUPGjg5Vjdj2pRnikHhyZ4V9QU8ZwEqSJ9b3BAN7C2zjGXRPMJB5wwdyn5MnHgAazjlD6RMK62WDIuKAEvQ2QAhrGdnWLRN7NW-Sozx3E_jhLpbxXChLQdoSRx_fA%3D%3D&q=Pizza&lei=68IKZovBHvGAxc8PlbCEmAo#',
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                      title: Text(category.name),
                      onTap: () {
                        TLocalStorage.saveString('selectedCategoryId', category.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailsScreen(categories: category),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is FetchCategoriesFailure) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            } else {
              return const SizedBox(); // Handle other states as needed
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addCategoryScreen');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
