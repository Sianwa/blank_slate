import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../themes/main_theme.dart';

class RedirectCard extends StatelessWidget {
  final String cardTitle;
  final String cardDescription;
  final String redirectsTo;
  final String? iconName;
  final String? transactionType;

  const RedirectCard(
      {super.key,
      required this.cardTitle,
      required this.cardDescription,
      required this.redirectsTo,
      this.iconName,
      this.transactionType});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: ()
        {
         //todo: navigate to the screen you want
        },
        child: Card(
          color: isDark ? MainTheme.appColors.darkModeBlue100 : MainTheme.appColors.neutral200,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          (iconName != null)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: SvgPicture.asset(iconName!),
                                )
                              : const SizedBox(),
                          Text(
                            cardTitle,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(cardDescription),
                      )
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
