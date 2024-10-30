import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../../model/note_model.dart';
import '../../../common/db_helper.dart';
import 'note_view.form.dart';

class NoteViewModel extends FormViewModel{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  BuildContext? context;
  NoteViewModel(this.context);

  Future<void> save(selectedDate) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      final newNote = Note(
        date: formattedDate,
        content: noteValue.toString(),
      );
      await dbHelper.insertNote(newNote);
      Navigator.of(context!).pop(true);
    }
  }
}