import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/data/shop/blocs/categories/bloc/categories_bloc.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(color: TColors.primaryColor),
          );
        } else if (state is FetchCategoriesSuccess) {
          final categories = state.categories;
          return SizedBox(
            height: 120,
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    //Handle when you click a category
                    print('Clicked This category:${category.name}');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(
                            category.image ??
                                'https://www.google.com/search?client=ubuntu-sn&hs=gJ2&sa=X&sca_esv=9a71a41fad6c3417&sca_upv=1&channel=fs&biw=1920&bih=995&sxsrf=ACQVn0-unZqiOTC2RMPCAuuj41URFJqRHQ:1711981283919&si=AKbGX_paaCugDdYkuX2heTJMr0_FGRox2AzKVmiTg2eQr2d-rnKq70LLmgXYOMzLtvEbExzSwMLcP28qgB2GyZcGLa_FPg7vJ_17grm_eQJMMb2rrkPpiRFzgqNHBp-47eWUDSMMGcNFdA6cliBc47QEJx_11QZWNKFtA1i15fM1pp85fPD8rB_OMuZ_OMFXiesxa1nKtiqJDtteEQ6Ev77RLrm3iOd_LYzSpAUPGjg5Vjdj2pRnikHhyZ4V9QU8ZwEqSJ9b3BAN7C2zjGXRPMJB5wwdyn5MnHgAazjlD6RMK62WDIuKAEvQ2QAhrGdnWLRN7NW-Sozx3E_jhLpbxXChLQdoSRx_fA%3D%3D&q=Pizza&lei=68IKZovBHvGAxc8PlbCEmAo#',
                          ),
                        ),

                        const SizedBox(
                          height: TSizes.spaceBtwItems / 2,
                        ),

                        ///Text
                        SizedBox(
                          width: 55,
                          child: Text(
                            category.name,
                            style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.black),
                            // maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is FetchCategoriesFailure) {
          return Center(
            child: Text('Error: ${state.error}'),
          );
        } else {
          return const Center(
            child: Text(
              'WTF',
              style: TextStyle(color: Colors.black),
            ),
          );
        }
      },
    );
  }
}
