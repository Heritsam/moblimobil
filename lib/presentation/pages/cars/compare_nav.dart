import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/buttons/rounded_button.dart';
import 'viewmodels/car_compare_viewmodel.dart';

class CompareNav extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(carCompareViewModel);
    final size = MediaQuery.of(context).size;
    final boxWidth = size.width / 4 - 18;

    return Styled.widget(
      child: <Widget>[
        ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            if (vm.selectedCars.asMap().containsKey(index)) {
              return _selectedBox(vm.selectedCars[index], boxWidth).gestures(
                onTap: () {
                  context
                      .read(carCompareViewModel)
                      .removeCar(vm.selectedCars[index]);
                },
              ).padding(right: 12);
            }

            return _unselectedBox(boxWidth).padding(right: 12);
          },
        ).constrained(height: boxWidth),
        SizedBox(height: 16),
        RoundedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/compare-detail');
          },
          label: S.of(context).compare,
          verticalPadding: 12,
          enabled: vm.selectedCars.length > 1,
        ).constrained(width: size.width),
      ]
          .toColumn(mainAxisSize: MainAxisSize.min)
          .parent(({required child}) => SafeArea(child: child)),
    )
        .padding(all: 16)
        .decorated(
          color: Colors.white,
        )
        .elevation(10, shadowColor: Colors.black38);
  }

  Widget _unselectedBox(double width) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Styled.widget()
            .decorated(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            )
            .constrained(height: width, width: width),
        Icon(Icons.add_circle_outline, size: 38, color: mediumGreyColor)
      ],
    );
  }

  Widget _selectedBox(Car car, double width) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Styled.widget()
            .decorated(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              image: DecorationImage(
                image: NetworkImage(car.imageUrl),
                fit: BoxFit.cover,
              ),
            )
            .constrained(height: width, width: width),
        Icon(Icons.close)
            .padding(all: 8)
            .decorated(color: Colors.white38, shape: BoxShape.circle)
            .backgroundBlur(20)
            .clipOval(),
      ],
    );
  }
}
