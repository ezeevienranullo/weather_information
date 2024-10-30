import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:weather_info/ui/common/opensans_text.dart';

import '../../../common/app_strings.dart';
import '../../../common/validator.dart';
import 'note_view.form.dart';
import 'note_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'note', initialValue: '',),
])

class NoteView extends StatelessWidget with $NoteView{
  final DateTime selectedDate;
  const NoteView({Key? key, required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NoteViewModel>.reactive(
        viewModelBuilder: () => NoteViewModel(context),
        onViewModelReady: (viewModel) {
          noteController.clear();
          syncFormWithViewModel(viewModel);
        },
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
              child:ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
                  child: Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,left: 20.0, right: 20.0, top: 30),
                      color: Colors.white,
                      child:Form(
                        key: viewModel.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            OpenSansText.medium('Add Note for ${DateFormat('MMM dd, yyyy').format(selectedDate)}', Colors.black, 16),
                            TextFormField(
                              controller: noteController,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration(hintText: str_enter_note),
                              validator: (value) {
                                if (FormValidators.isFieldValid(value.toString())) {
                                  return null;
                                } else {
                                  return str_required_field;
                                }
                              }
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () =>viewModel.save(selectedDate),
                                child: OpenSansText.regular(str_save, Colors.white, 14),
                              ),
                            ),
                            const SizedBox(height: kToolbarHeight,),
                          ],
                        ),
                      )
                  )
              )
          );
        }
    );
  }

}