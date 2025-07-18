// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String NoteValueKey = 'note';

final Map<String, TextEditingController> _NoteViewTextEditingControllers = {};

final Map<String, FocusNode> _NoteViewFocusNodes = {};

final Map<String, String? Function(String?)?> _NoteViewTextValidations = {
  NoteValueKey: null,
};

mixin $NoteView {
  TextEditingController get noteController =>
      _getFormTextEditingController(NoteValueKey);

  FocusNode get noteFocusNode => _getFormFocusNode(NoteValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_NoteViewTextEditingControllers.containsKey(key)) {
      return _NoteViewTextEditingControllers[key]!;
    }

    _NoteViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _NoteViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_NoteViewFocusNodes.containsKey(key)) {
      return _NoteViewFocusNodes[key]!;
    }
    _NoteViewFocusNodes[key] = FocusNode();
    return _NoteViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    noteController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    noteController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          NoteValueKey: noteController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _NoteViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _NoteViewFocusNodes.values) {
      focusNode.dispose();
    }

    _NoteViewTextEditingControllers.clear();
    _NoteViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get noteValue => this.formValueMap[NoteValueKey] as String?;

  set noteValue(String? value) {
    this.setData(
      this.formValueMap..addAll({NoteValueKey: value}),
    );

    if (_NoteViewTextEditingControllers.containsKey(NoteValueKey)) {
      _NoteViewTextEditingControllers[NoteValueKey]?.text = value ?? '';
    }
  }

  bool get hasNote =>
      this.formValueMap.containsKey(NoteValueKey) &&
      (noteValue?.isNotEmpty ?? false);

  bool get hasNoteValidationMessage =>
      this.fieldsValidationMessages[NoteValueKey]?.isNotEmpty ?? false;

  String? get noteValidationMessage =>
      this.fieldsValidationMessages[NoteValueKey];
}

extension Methods on FormStateHelper {
  setNoteValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NoteValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    noteValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      NoteValueKey: getValidationMessage(NoteValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _NoteViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _NoteViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      NoteValueKey: getValidationMessage(NoteValueKey),
    });
