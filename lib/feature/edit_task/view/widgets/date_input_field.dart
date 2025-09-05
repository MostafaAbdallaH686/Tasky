import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/core/function/app_svg_image.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/utils/app_icon.dart';
import 'package:to_do_app/core/widgets/default_text_form_filed.dart';

class DateField extends StatelessWidget {
  final String? dateText;
  final void Function(String) onDateSelected;

  const DateField({
    super.key,
    this.dateText,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextFormFiled(
      hint: "End date",
      controller: TextEditingController(text: dateText),
      passwordSuffixIcon: InkWell(
        onTap: () => _showDatePickerDialog(context, onDateSelected),
        child: AppSvgImage.showSvgImage(
          path: AppIcon.tdate,
          width: AppWidthHeight.persantageOfWidth(24 / 375 * 100),
          height: AppWidthHeight.persantageOfHeight(24 / 812 * 100),
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  void _showDatePickerDialog(
      BuildContext context, void Function(String) onSelect) async {
    DateTime? selectedDate;
    DateTime focusedDay = DateTime.now();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.all(16.0),
        content: SizedBox(
          height: AppWidthHeight.persantageOfHeight(450 / 812 * 100),
          width: double.minPositive,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TableCalendar(
                daysOfWeekHeight: 32,
                firstDay: DateTime.utc(2010, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: focusedDay,
                selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                onDaySelected: (selected, focused) {
                  onSelect(DateFormat('dd MMM yyyy').format(selected));
                  Navigator.pop(context);
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  headerPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
