import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/core/extension/device_info_on_num.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/features/user/presentation/controllers/get_all_users/get_all_users_cubit.dart';
import 'package:weider/features/user/presentation/widgets/add_edit_users_widgets/text_input/custom_text_input_field.dart';

import '../../../../../core/routes.dart';
import '../../../../../main.dart';
import 'data_list_view.dart';

class DisplayUsersBody extends StatefulWidget {
  const DisplayUsersBody({super.key});

  @override
  State<DisplayUsersBody> createState() => _DisplayUsersBodyState();
}

class _DisplayUsersBodyState extends State<DisplayUsersBody> with RouteAware {
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
              Padding(
                padding: EdgeInsets.only(top: 19.5.sp(context)),
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
                right: 10,
                child: IconButton(
                  style: ButtonStyle(
                    shadowColor: WidgetStatePropertyAll(Colors.black),
                    elevation: WidgetStatePropertyAll(5),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
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

              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Align(
                  alignment: Alignment.topCenter,

                  child: CustomTextInputField(
                    controller: _searchController,
                    maxLines: 1,
                    onChanged: (input) {
                      context.read<GetUsersCubit>().getUsers(userName: input);
                    },
                    label: "ابحث بالاسم",
                  ),
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
