import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weider/core/shared/widget/custom_text_input_field.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/features/user/data/models/user_model.dart';
import 'package:weider/features/user/presentation/controllers/get_all_users/get_all_users_cubit.dart';
import 'package:weider/features/user/presentation/widgets/display_users_widgets/dismissible_user_card.dart';

import '../../../../../core/routes.dart';
import '../../../../../main.dart';

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
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 64.0),
                child: BlocBuilder<GetUsersCubit, GetUsersState>(
                  buildWhen: (previous, current) =>
                      previous != current && current is GetUsersSuccess,
                  builder: (context, state) {
                    if (state is GetUsersSuccess) {
                      return DataListView(users: state.users);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),

              Positioned(
                bottom: 40,
                right: 40,
                child: IconButton(
                  style: ButtonStyle(
                    shadowColor: WidgetStatePropertyAll(Colors.black),
                    elevation: WidgetStatePropertyAll(5),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.secondaryColor,
                    ),
                  ),
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, Screens.addEditUser);
                  },
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: CustomTextInputField(
                  controller: _searchController,
                  onChanged: (input) {
                    context.read<GetUsersCubit>().getUsers(userName: input);
                  },
                  label: "ابحث بالاسم",
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
    //     userModel: UserModel(
    //       id: "123",
    //       name: "محمود سعيد سالم",
    //       startDate: DateTime.now(),
    //       endDate: DateTime.now().add(Duration(days: 30)),
    //       phone: "01552483586",
    //       intervalTime: Intervals.month,
    //     ),
    //   ),
    // );
  }
}

class DataListView extends StatelessWidget {
  const DataListView({super.key, required this.users});
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Gap(8),
      itemCount: users.length,
      itemBuilder: (context, index) =>
          DismissibleUserCard(users: users, index: index),
    );
  }
}
