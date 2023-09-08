import 'package:bloc_grocery/features/home/models/home_product_data_model.dart';
import 'package:bloc_grocery/features/home/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget{
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget({super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 200,width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(productDataModel.imageUrl))
            ),
          ),
          Text(productDataModel.name,style: const TextStyle(fontSize: 30),),
          Text(productDataModel.description,style: const TextStyle(fontSize: 20)),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text(productDataModel.price.toString(),style: const TextStyle(fontSize: 30),),
           Row(
             children: [
               IconButton(onPressed: (){
                 homeBloc.add(HomeProductWishlistButtonClickedEvent(clickedProduct: productDataModel));

               }, icon: const Icon(Icons.favorite_border)),
               IconButton(onPressed: (){
                 homeBloc.add(HomeProductCartButtonClickedEvent(
                   clickedProduct:productDataModel
                 ));

               }, icon: const Icon(Icons.shopping_bag_outlined))

             ],
           ),

         ],
       )
        ],
      ),
    );
  }

}