import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/core/extension/device_info_on_num.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/features/user/presentation/controllers/get_all_users/get_all_users_cubit.dart';
import 'package:weider/features/user/presentation/widgets/add_edit_users_widgets/text_input/custom_text_input_field.dart';
import 'package:weider/features/user/presentation/widgets/display_users_widgets/UserCard/custom_container_card.dart';

import '../../../../../core/routes.dart';
import '../../../../../main.dart';
import 'data_list_view.dart';

class DisplayUsersBody extends StatefulWidget {
  const DisplayUsersBody({super.key});

  @override
  State<DisplayUsersBody> createState() => _DisplayUsersBodyState();
}

class _DisplayUsersBodyState extends State<DisplayUsersBody> with RouteAware {
  // int _total;
  // int _filteredNumber;
  late TextEditingController _searchController;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void didPopNext() {
    context.read<GetUsersCubit>().getUsers();
    super.didPopNext();
  }

  @override
  void didPush() {
    context.read<GetUsersCubit>().getUsers();

    super.didPush();
  }

  @override
  void initState() {
    super.initState();
    context.read<GetUsersCubit>().getUsers();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<GetUsersCubit>().getUsers();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5.sp(context),
            horizontal: 5.sp(context),
          ),
          child: Stack(
            children: [
              //* عرض الداتا
              Padding(
                padding: EdgeInsets.only(top: 28.5.sp(context)),
                child: BlocBuilder<GetUsersCubit, GetUsersState>(
                  // buildWhen: (previous, current) =>
                  //     previous != current && current is GetUsersSuccess,
                  builder: (context, state) {
                    // log("States cha")
                    if (state is GetUsersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetUsersFailed) {
                      return Center(
                        child: Text('حدث خطأ أثناء تحميل البيانات'),
                      );
                    } else if (state is GetUsersSuccess) {
                      return DataListView(users: state.users);
                    }
                    return const SizedBox();
                  },
                ),
              ),

              //* اضافة شخص جديد
              Positioned(
                bottom: 30,
                right: 15,
                child: IconButton(
                  style: ButtonStyle(
                    shadowColor: WidgetStatePropertyAll(Colors.black),
                    elevation: WidgetStatePropertyAll(5),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(4)),
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.secondary,
                    ),
                  ),
                  icon: Icon(Icons.add, size: 48),
                  onPressed: () {
                    Navigator.pushNamed(context, Screens.addEditUser);
                  },
                ),
              ),
              //* Search Bar
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10.0,
                        left: 16,
                        right: 16,
                      ),
                      child: CustomTextInputField(
                        isSearch: true,
                        controller: _searchController,
                        maxLines: 1,
                        onChanged: (input) {
                          context.read<GetUsersCubit>().getUsers(
                            userName: input,
                          );
                        },
                        label: "ابحث بالاسم",
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 8.sp(context),
                      child: BlocBuilder<GetUsersCubit, GetUsersState>(
                        builder: (context, state) {
                          if (state is GetUsersLoading) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("إجمالي: "),
                                CircularProgressIndicator(),
                              ],
                            );
                          } else if (state is GetUsersSuccess) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomContainerCard(
                                  title:
                                      "المشتركين : ${state.users.active.length + state.users.deactive.length}",
                                ),
                                CustomContainerCard(
                                  title:
                                      " الساري: ${state.users.active.length}",
                                ),
                                CustomContainerCard(
                                  title:
                                      " المنتهي: ${state.users.deactive.length}",
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // return Container(
    //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    //   child: UserCard(
    //     userModel: UserModel.mock()

    //   ),
    // );
  }
}
