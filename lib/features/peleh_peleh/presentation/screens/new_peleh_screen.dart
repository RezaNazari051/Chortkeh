import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/arguments.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class NewPelehScreen extends StatefulWidget {
  static const String routeName = '/peleh-peleh/new-eleh-screen';

  const NewPelehScreen({super.key});

  @override
  State<NewPelehScreen> createState() => _NewPelehScreenState();
}

class _NewPelehScreenState extends State<NewPelehScreen> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _countController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _amountController = TextEditingController();
    _countController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NewPelehArgument args =
        ModalRoute.of(context)!.settings.arguments as NewPelehArgument;
    debugPrint(ModalRoute.of(context)!.settings.name.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('پله‌پله ${args.name}'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: constraints.maxWidth * 0.3,
                          height: constraints.maxWidth * 0.3,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 23),
                          child: SvgPicture.asset(
                            '$targetIcon/${args.image}',
                            fit: BoxFit.cover,
                          )),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.05),
                    child: Column(
                      children: [
                        if (args.id == 0) ...[
                          PTextFormField(
                              title: 'نام',
                              hintText: 'نام پله‌پله',
                              controller: _nameController),
                          const Gap(16)
                        ],
                        PTextFormField(
                            title: 'مبلغ',
                            hintText: 'مبلغ پله‌پله',
                            controller: _amountController,
                            keyboardType: TextInputType.number),
                        const Gap(16),
                        PTextFormField(
                          title: 'تعداد پله',
                          hintText:
                              'تعداد پله‌هایی که نیاز داری تا به هدفت برسی...',
                          controller: _countController,
                          keyboardType: TextInputType.number,
                        ),
                        const Gap(24),
                        FillElevatedButton(
                            onPressed: () {},
                            title: args.id == 0 ? 'ثبت' : 'ثبت پله‌پله')
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
