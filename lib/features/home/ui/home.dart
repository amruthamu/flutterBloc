import 'package:bloc_grocery/features/cart/ui/cart.dart';
import 'package:bloc_grocery/features/home/home_bloc/home_bloc.dart';
import 'package:bloc_grocery/features/home/ui/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }
  final HomeBloc homeBloc=HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous,current)=>current is HomeActionState,
      buildWhen:(previous,current)=>current is !HomeActionState,
      listener: (context, state) {
        if(state is HomeNavigateToCartPageActionState){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart()),);
        } else if(state is HomeProductItemWishListedActionState){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("item wishlisted")));
        }else if(state is HomeProductItemCartActionState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("item carted")));

        }

      },
      builder: (context, state) {
        switch(state.runtimeType){
          case  HomeLoadingState:
            return const Scaffold(body: Center(
              child: CircularProgressIndicator(),
            ),);
          case HomeLoadedSuccessState:
            final successState=state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Shopping App'),
                actions: [
                  IconButton(onPressed: (){
                    homeBloc.add(HomeCartButtonNavigateClickedEvent());
                  }, icon: const Icon(Icons.shopping_bag_outlined))
                ],
              ),
              body: ListView.builder(itemCount: successState.products.length,
                  itemBuilder: (context,index){
                return ProductTileWidget(productDataModel: successState.products[index], homeBloc: homeBloc,);

              }
              ),
            );
          case HomeErrorState:
            return const Scaffold(body: Center(
              child: Text("error"),
            ),);
             default:
               return const SizedBox();

        }

      },
    );
  }
}