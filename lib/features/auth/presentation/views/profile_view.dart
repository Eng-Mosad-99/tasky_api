import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasky_api/core/di/di.dart';
import 'package:tasky_api/core/utils/app_assets.dart';
import 'package:tasky_api/core/utils/app_colors.dart';
import 'package:tasky_api/core/utils/app_styles.dart';
import 'package:tasky_api/features/auth/presentation/cubit/auth_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late AuthCubit authCubit;
  @override
  void initState() {
    authCubit = getIt<AuthCubit>();
    authCubit.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authCubit,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 125.w,
          leading: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(AppIcons.arrowLeftIcon),
                ),
                SizedBox(width: 8),
                Text(
                  'Profile',
                  style: AppStyles.bold(color: AppColors.blackColor),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is ProfileSuccessState) {
              return Column(
                children: [
                  CustomProfileCard(
                    title: 'NAME',
                    value: state.profileResponse.displayName ?? '',
                  ),
                  CustomProfileCard(
                    title: 'PHONE',
                    value: state.profileResponse.username ?? '',
                    trailingWidget: SvgPicture.asset(AppIcons.copyIcon),
                  ),
                  CustomProfileCard(
                    title: 'LEVEL',
                    value: state.profileResponse.level ?? '',
                  ),
                  CustomProfileCard(
                    title: 'YEARS OF EXPERIENCE',
                    value:
                        '${state.profileResponse.experienceYears ?? 0} years',
                  ),
                  CustomProfileCard(
                    title: 'LOCATION',
                    value: state.profileResponse.address ?? '',
                  ),
                ],
              );
            } else if (state is ProfileFailureState) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class CustomProfileCard extends StatelessWidget {
  const CustomProfileCard({
    super.key,
    required this.title,
    required this.value,
    this.trailingWidget,
  });
  final String title;
  final String value;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10.r),
      ),
      child: ListTile(
        trailing: trailingWidget,
        title: Text(
          title,
          style: AppStyles.medium(
            color: AppColors.darkColor.withValues(alpha: 0.4),
          ),
        ),
        subtitle: Text(
          value, // 'Islam Sayed',
          style: AppStyles.bold(
            fontSize: 18.sp,
            color: AppColors.darkColor.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}
