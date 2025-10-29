import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/core/utils/app_router.dart';
import 'package:travel_hub/data/cubits/hotels_cubit/hotels_cubit.dart';
import 'package:travel_hub/data/cubits/hotels_cubit/hotels_state.dart';
import 'package:travel_hub/features/hotels/presentation/widgets/custom_button.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreen();
}

class _HotelsScreen extends State<HotelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kWhite,
        title: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Hotels",
                style: TextStyle(color: kBlack, fontSize: 24.sp),
              ),
              Text(
                "Find your perfect stay",
                style: TextStyle(color: kAssets, fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: kWhite,
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: BlocBuilder<HotelsCubit, HotelsState>(
          builder: (context, state) {
            return state is HotelsLoading
                ? Center(child: CircularProgressIndicator())
                : state is HotelsError
                ? Center(child: Text(state.massage))
                : state is HotelsSuccess
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final hotels = state.hotels[index];
                            return GestureDetector(
                              onTap: () {
                                GoRouter.of(context).push(AppRouter.kHotelsDetailsView,extra: hotels);
                              },
                              child: Card(
                                elevation: 5.r,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.r),
                                ),
                                margin: EdgeInsets.all(5.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(24.r),
                                          ),
                                          child: Image.network(
                                            hotels.imageUrl,
                                            height: 180.h,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(8.r),
                                          width: 62.11.w,
                                          height: 27.95.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              42152500.r,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star_rate,
                                                color: kStar,
                                              ),
                                              SizedBox(width: 3.w),
                                              Text(
                                                "${hotels.stars}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12.r),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    hotels.name,
                                                    style: TextStyle(
                                                      color: kBlack,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "${hotels.pricePerNight} EGP",
                                                    style: TextStyle(
                                                      color: kPriceColor,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    hotels.city,
                                                    style: TextStyle(
                                                      color: kAssets,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "per night",
                                                    style: TextStyle(
                                                      color: kAssets,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          CustomButton(
                                            buttonText: "Book Now",
                                            onPressed: () {
                                              GoRouter.of(
                                                context,
                                              ).push(AppRouter.kBookView);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: state.numHotels,
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<HotelsCubit>().loadMoreHotels();
                          },
                          child: Text(
                            "See more",
                            style: TextStyle(color: kBackgroundColor),
                          ),
                        ),
                        SizedBox(height: 15.h),
                      ],
                    ),
                  )
                : SizedBox();
          },
        ),
      ),
    );
  }
}
