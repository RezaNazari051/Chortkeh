import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/features/home/presentation/bloc/manage_cards_bloc/card_cubit.dart';
import 'package:chortkeh/features/home/presentation/widgets/recent_activities_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/json_data.dart';
import '../widgets/balance_indicator_widget.dart';
import '../widgets/channel_list_bottom_sheet.dart';
import '../widgets/features_cards_list.dart';
import '../widgets/tranaction_detail_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // final CardHelper dbHelper=locator<CardHelper>();
    // final dbHelper = locator<CardsDataHelper>();
    // cardList = dbHelper.getCards();

  WidgetsBinding.instance.addPostFrameCallback((_){
    context.read<CardCubit>().loadCards();
  });
    // _cardsFuture=dbHelper.getCards();
    super.initState();
  }

void _showCardListModal(BuildContext context)  {
     showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: context.read<CardCubit>(),
          child: const ChannelListBottomSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final List<RecentActivities> recentActivities = [
      RecentActivities(
          category: 'ماشین',
          bankCard: 'کارت پاسارگاد',
          color: const Color(0xffFCF8D2),
          date: DateTime.now(),
          price: 3750000,
          value: 25,
          icon: '$categoryIcon/ic_car.svg'),
      RecentActivities(
          category: 'سلامتی',
          bankCard: 'کارت پاسارگاد',
          color: const Color(0xffDCF1DB),
          date: DateTime.now(),
          price: 650000,
          value: 10,
          icon: '$categoryIcon/ic_hospital.svg'),
      RecentActivities(
          category: 'خوردنی',
          bankCard: 'کارت پاسارگاد',
          color: const Color(0xffFCE6D4),
          date: DateTime.now(),
          price: 900000,
          value: 13,
          icon: '$categoryIcon/ic_cake.svg'),
      RecentActivities(
          category: 'خریدنی',
          bankCard: 'کارت پاسارگاد',
          color: const Color(0xffDAE2F0),
          date: DateTime.now(),
          price: 550000,
          value: 11,
          icon: '$categoryIcon/ic_bag.svg'),
      RecentActivities(
          category: 'خوش گذرونی',
          bankCard: 'کارت پاسارگاد',
          color: const Color(0xffECDEED),
          date: DateTime.now(),
          price: 3250000,
          value: 45,
          icon: '$categoryIcon/ic_headphone.svg'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // final CardHelper cardHelper = locator<CardHelper>();
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 16,
                ),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'حساب‌کتاب مهرماه',
                        style: textTheme.labelMedium,
                      ),
                      OutlinedButton(
                        onPressed: () => _showCardListModal(context),
            
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('همه حساب‌ها',
                                style: textTheme.labelMedium!
                                    .apply(color: AppColor.primaryColor)),
                            const Gap(8),
                            Transform.rotate(
                              angle: 1.5,
                              child: const Icon(
                                size: 20,
                                Icons.arrow_back_ios_new_rounded,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SliverGap(0),
              SliverToBoxAdapter(
                child: BalanceWidget(
                  deposit: 50000000,
                  withdrawal: 4900000,
                  constraints: constraints,
                ),
              ),
              const SliverGap(24),
              const FeaturesCardsList(),
              const SliverGap(24),

              ///Recent activities in month Widget
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text('فعالیت‌های اخیر مهرماه',
                        style: textTheme.labelMedium),
                    const Spacer(),
                    InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          '$iconUrl/ic_sort.svg',
                          fit: BoxFit.cover,
                          width: constraints.maxWidth * 0.045,
                        )),
                    const Gap(20),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        '$iconUrl/ic_filter.svg',
                        fit: BoxFit.cover,
                        width: constraints.maxWidth * 0.045,
                      ),
                    ),
                  ],
                ),
              ),

              const SliverGap(20),

              RecentActivitiesChartWidget(constraints: constraints),

              const SliverGap(12),
              SliverList.builder(
                itemCount: recentActivities.length,
                itemBuilder: (context, index) {
                  return TransactionDetailWidget(
                      recentActivities: recentActivities, index: index);
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class ManageChannelsBottomSheet extends StatelessWidget {
  const ManageChannelsBottomSheet({
    super.key,
    // required this.cardHelper,
    required this.textTheme,
  });

  // final CardHelper cardHelper;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: 60,
          height: 5,
          decoration: BoxDecoration(
              color: AppColor.cardBorderGrayColor,
              borderRadius: BorderRadius.circular(28)),
        ),
        const Gap(52),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {},
              child: Text(
                'کانال‌های ورودی',
                style: textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const Gap(8),
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              SvgPicture.asset('$iconUrl/ic_add_square.svg'),
              const Gap(5),
              Text('اضافه کردن کانال جدید', style: textTheme.labelSmall)
            ],
          ),
        ),
        const Gap(16),
      ],
    );
  }
}
enum FormantMode{
  withTime,
  withDayName,
  withMonthAndDayName,
  withMonthName,
}
String formatJalali(DateTime dateTime ,{FormantMode mode=FormantMode.withDayName}) {
  final Jalali jalali = Jalali.fromDateTime(dateTime);

  final date = jalali.formatter;
  // if(showTime){
  return '${date.wN}، ${date.d}${date.mN}، ${date.y}، ${jalali.hour}:${jalali.minute}';

  // }
  // return '${date.wN}، ${date.d}${date.mN}، ${date.y}';

}

Jalali gregorianToJalali(DateTime gregorianDate){
  final Jalali jalaliDate=gregorianDate.toJalali();
  return Jalali(jalaliDate.year,jalaliDate.month,jalaliDate.day);
}

DateTime jalaliToDateTime(Jalali jalaliDate) {
  final Gregorian gregorianDate = jalaliDate.toGregorian();
  return DateTime(gregorianDate.year, gregorianDate.month, gregorianDate.day);
}



void a() {
  // List<CardModel> cards = snapshot.data ?? [];
}
