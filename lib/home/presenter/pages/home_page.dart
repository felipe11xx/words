import 'pages.dart';
import '../cubit/cubits.dart';
import 'package:flutter/material.dart';
import '../../../../shared/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../shared/navigation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/resources/resources.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:words/user_favorites/presenter/cubit/cubits.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: AppColors.secondary_light[600],
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.email_outlined,
                  color: AppColors.white,
                ),
                title: Text(
                  context.read<HomeCubit>().getUserEmail() ?? '',
                  style: AppTextStyles.labelSmall.copyWith(color: AppColors.white),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app,color: AppColors.white,),
                title: Text(
                  Strings.signOut,
                  style: AppTextStyles.labelSmall.copyWith(color: AppColors.white),
                ),
                trailing: const Icon(Icons.arrow_forward, color: AppColors.white,),
                onTap: () {
                  context.read<HomeCubit>().signOut();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme:const IconThemeData(color: AppColors.white),
          title: Text(
            Strings.dictionary,
            style: AppTextStyles.headH6.copyWith(color: AppColors.white),
          ),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                Strings.wordsApp,
                style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
              ),
            ),
            Tab(
              child: Text(
                Strings.historic,
                style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
              ),
            ),
            Tab(
              child: Text(
                Strings.favorites,
                style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
              ),
            ),
          ]),
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is UserSignOutErrorState) {
              showSnackBar(context, state.exception.message);
            }
            if (state is UserSignOutSuccessState) {
              Modular.to.pushReplacementNamed(Routes.signIn);
            }
          },
          builder: (context, state) {

            if(state is HomeLoadingState){
              return Center(
                child: AppProgressIndicator(
                  color: AppColors.secondary_light,
                  width: 100.w,
                  height: 100.w,
                ),
              );
            }
            if(state is HomeInitialState){
              return TabBarView(
                children: [
                  BlocProvider.value(
                    value: Modular.get<AllWordsCubit>(),
                    child: const AllWordsTab(),
                  ),
                  BlocProvider.value(
                      value: Modular.get<HistoryCubit>(),
                      child: const HistoryTab()),
                  BlocProvider.value(
                      value: Modular.get<FavoritesCubit>(),
                      child: const FavoritesTab()),
                ],
              );
            }

            return AppErrorScreen( onPressed: (){Modular.to.pushReplacementNamed(Routes.signIn,);});

          },
        ),
      ),
    );
  }
}
