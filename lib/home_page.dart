import 'package:auto_route/auto_route.dart';
import 'package:demo_ezv_app/features/products/presentation/bloc/favorite_actor/product_actor_bloc.dart';
import 'package:demo_ezv_app/injection.dart';
import 'package:demo_ezv_app/routes/router.gr.dart';
import 'package:demo_ezv_app/shared/loading_overlay.dart';
import 'package:demo_ezv_app/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/products/presentation/bloc/loader/product_loader_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductActorBloc, ProductActorState>(
      listener: (context, state) {
        state.maybeMap(
          orElse: () {},
          successfullyAdded: (_) {
            showToast(
              context,
              title: const Text(
                'Successfully added',
              ),
            );
            context
                .read<ProductLoaderBloc>()
                .add(const ProductLoaderEvent.favoriteFetched());
          },
          successfullyRemoved: (_) {
            showToast(
              context,
              title: const Text(
                'Successfully removed',
              ),
            );
            context
                .read<ProductLoaderBloc>()
                .add(const ProductLoaderEvent.fetched());
          },
        );
      },
      child: Stack(
        children: [
          AutoTabsScaffold(
            routes: const [
              ProductOverviewRoute(),
              ProductFavoriteRoute(),
            ],
            bottomNavigationBuilder: (context, tabsRouter) {
              return BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: (value) => tabsRouter.setActiveIndex(value),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: 'Chat',
                  ),
                ],
              );
            },
          ),
          BlocBuilder<ProductLoaderBloc, ProductLoaderState>(
            buildWhen: (p, c) => p.isLoading != c.isLoading,
            builder: (context, state) {
              return LoadingIndicatorOverlay(isLoading: state.isLoading);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ProductActorBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ProductLoaderBloc>()
            ..add(const ProductLoaderEvent.fetched()),
        ),
      ],
      child: this,
    );
  }
}
