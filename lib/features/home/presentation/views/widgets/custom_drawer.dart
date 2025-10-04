import 'package:ahmed_karam/core/utils/app_navigate.dart';
import 'package:ahmed_karam/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:ahmed_karam/features/home/presentation/views/widgets/menu_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 200),
              MenuListTile(
                icon: Icons.book_outlined,
                title: "Add Course",
                onTap: () {
                  context.push(AppNavigate.kAddCourseView);
                },
              ),
              MenuListTile(
                icon: Icons.logout_outlined,
                title: "Logout",
                onTap: () {
                  BlocProvider.of<HomeCubit>(context).logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
