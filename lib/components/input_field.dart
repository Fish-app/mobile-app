//Taken from https://github.com/recipe-heaven/App

import 'dart:math';

import 'package:App/components/form/form_validators.dart';
import 'package:App/data_classes/recipe.dart';
import 'package:App/theme/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Secondary input field has a different color scheme then the primary.
Container secondaryInputField(BuildContext context,
    {String label,
      FormFieldSetter<String> onSave,
      FormFieldValidator<String> validator,
      String initialValue,
      bool obscureInput = false,
      String hint = ""}) {
  return Container(
    child: Column(
      children: [
        Padding(
          child: Text(
            label,
            style: Theme.of(context).textTheme.headline2,
          ),
          padding: const EdgeInsets.only(bottom: 4),
        ),
        inputFealdShadowWrapper(
          child: TextFormField(
            cursorColor: Colors.white,
            validator: validator,
            onSaved: onSave,
            initialValue: initialValue,
            obscureText: obscureInput,
            decoration: const InputDecoration()
                .applyDefaults(secondaryInputDecorationTheme)
                .copyWith(
              hintText: hint,
            ),
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
    padding: const EdgeInsets.symmetric(vertical: 10),
  );
}

Widget inputField(BuildContext context,
    {String label,
      FormFieldSetter<String> onSaved,
      FormFieldValidator<String> validator,
      bool obscureInput = false,
      TextInputAction inputAction = TextInputAction.none,
      Function(String) onFieldSubmitted,
      String initialValue,
      String hint = "",
      Key key}) {
  return inputFealdShadowWrapper(
      child: TextFormField(
          initialValue: initialValue,
          key: key,
          style: TextStyle(color: primaryTextColor),
          validator: validator,
          onSaved: onSaved,
          obscureText: obscureInput,
          textInputAction: inputAction,
          onFieldSubmitted: onFieldSubmitted,
          decoration: const InputDecoration()
              .applyDefaults(primaryInputDecorationTheme)
              .copyWith(
            hintText: hint,
          )));
}

Container newMealInputBox(BuildContext context,
    {String label,
      String initVal,
      FormFieldSetter<String> onSave,
      FormFieldValidator<String> validator,
      bool obscureInput = false,
      String hint = ""}) {
  return Container(
    child: Column(
      children: [
        Padding(
          child: Text(
            label,
            style: Theme.of(context).textTheme.headline2,
          ),
          padding: const EdgeInsets.only(bottom: 4),
        ),
        inputFealdShadowWrapper(
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyText1,
            validator: validator,
            initialValue: initVal,
            onSaved: onSave,
            obscureText: obscureInput,
            decoration: const InputDecoration().copyWith(
              hintText: hint,
            ),
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
    padding: const EdgeInsets.symmetric(vertical: 10),
  );
}

Container newTimeInputBox(BuildContext context,
    {String hedValue,
      FormFieldSetter<String> onSaveHour,
      FormFieldSetter<String> onSaveMin,
      FormFieldValidator<String> validator,
      int initTime,
      bool obscureInput = false,
      String hint = ""}) {
  return Container(
    child: Column(
      children: [
        Padding(
          child: Text(
            hedValue,
            style: Theme.of(context).textTheme.headline2,
          ),
          padding: const EdgeInsets.only(bottom: 4),
        ),
        Row(
          children: [
            Container(
              child: inputFealdShadowWrapper(
                  child: TextFormField(
                      style: TextStyle(color: primaryTextColor),
                      keyboardType: TextInputType.number,
                      validator: validator,
                      onSaved: onSaveHour,
                      initialValue: (initTime != null)
                          ? (initTime / 60).floor().toString()
                          : "",
                      obscureText: obscureInput)),
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Hours",
                style: Theme.of(context).accentTextTheme.headline3,
              ),
            ),
            Container(
              child: inputFealdShadowWrapper(
                child: TextFormField(
                  style: TextStyle(color: primaryTextColor),
                  keyboardType: TextInputType.number,
                  initialValue:
                  (initTime != null) ? (initTime % 60).toString() : "",
                  validator: validator,
                  onSaved: onSaveMin,
                  obscureText: obscureInput,
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Minutes",
                style: Theme.of(context).accentTextTheme.headline3,
              ),
            ),
          ],
        )
      ],
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
    padding: const EdgeInsets.symmetric(vertical: 10),
  );
}

Container newMealIngredientInputBlock(
    BuildContext context, //int ingredient_idx,
        {Ingredient ingredient,
      FormFieldSetter<String> onSavedAmmount,
      FormFieldSetter<IngredientUnit> onSavedType,
      FormFieldSetter<String> onSavedComment,
      ValueChanged<IngredientUnit> onDropdownChanged,
      VoidCallback onPressdBack,
      FormFieldValidator<String> validator,
      bool obscureInput = false,
      String hint = ""}) {
  return Container(
    child: Column(
      children: [
        Row(
          children: [
            Container(
              child: inputFealdShadowWrapper(
                child: TextFormField(
                    style: TextStyle(color: primaryTextColor),
                    keyboardType: TextInputType.number,
                    initialValue: (ingredient.amount != 0)
                        ? ingredient.amount.toString()
                        : "",
                    validator: validateFloatInput,
                    onSaved: onSavedAmmount,
                    obscureText: obscureInput,
                    decoration: const InputDecoration().applyDefaults(
                        Theme.of(context).inputDecorationTheme.copyWith(
                            fillColor:
                            Theme.of(context).dialogBackgroundColor))),
              ),
              width: MediaQuery.of(context).size.width * 0.2,
              //decoration: shadowBoxDecoration,
              padding: const EdgeInsets.only(right: 10),
            ),
            Container(
              child: inputFealdShadowWrapper(
                child: DropdownButtonFormField<IngredientUnit>(
                    style: TextStyle(color: primaryTextColor),
                    value: ingredient.unitType,
                    dropdownColor: elementBackgroundColor,
                    onSaved: onSavedType,
                    onChanged: onDropdownChanged,
                    isDense: true,
                    items: [
                      for (IngredientUnit unit in IngredientUnit.values)
                        DropdownMenuItem(
                          value: unit,
                          child: Text(describeEnum(unit)),
                        ),
                    ],
                    decoration: const InputDecoration().applyDefaults(
                        Theme.of(context).inputDecorationTheme.copyWith(
                            fillColor:
                            Theme.of(context).dialogBackgroundColor))),
              ),
              width: MediaQuery.of(context).size.width * 0.3,
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.cancel_outlined),
              onPressed: onPressdBack,
              color: Theme.of(context).errorColor,
            )
          ],
        ),
        Container(
          child: inputFealdShadowWrapper(
            child: TextFormField(
                style: TextStyle(color: primaryTextColor),
                initialValue: ingredient.comment,
                validator: validateNotEmptyInput,
                onSaved: onSavedComment,
                obscureText: false,
                decoration: const InputDecoration().applyDefaults(
                    Theme.of(context).inputDecorationTheme.copyWith(
                        fillColor: Theme.of(context).dialogBackgroundColor))),
          ),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(right: 10),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
    padding: const EdgeInsets.symmetric(vertical: 10),
  );
}

Container newMealStepInputBlock(BuildContext context, //int ingredient_idx,
        {RecipeStep step,
      bool first = false,
      bool last = false,
      String hedValue,
      FormFieldSetter<String> onSavedStepp,
      VoidCallback onPressdBack,
      VoidCallback onPressdUp,
      VoidCallback onPressdDown,
      FormFieldValidator<String> validator,
      String hint = ""}) {
  return Container(
    child: Column(
      children: [
        Stack(
          children: [
            if (!first)
              Center(
                child: IconButton(
                  onPressed: onPressdUp,
                  icon: Icon(Icons.arrow_upward),
                ),
              ),
            Row(
              children: [
                Spacer(),
                IconButton(
                  icon: Icon(Icons.cancel_outlined),
                  onPressed: onPressdBack,
                  color: Theme.of(context).errorColor,
                ),
              ],
            )
          ],
        ),
        Container(
          child: inputFealdShadowWrapper(
            child: TextFormField(
                style: TextStyle(color: primaryTextColor),
                initialValue: step.step,
                validator: validateNotEmptyInput,
                maxLines: null,
                onSaved: onSavedStepp,
                decoration: const InputDecoration().applyDefaults(
                    Theme.of(context).inputDecorationTheme.copyWith(
                        fillColor: Theme.of(context).dialogBackgroundColor))),
          ),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(right: 10),
        ),
        if (!last)
          Center(
            child: IconButton(
              onPressed: onPressdDown,
              icon: Icon(Icons.arrow_downward),
            ),
          ),
      ],
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
    padding: const EdgeInsets.symmetric(vertical: 10),
  );
}

class DrinksSelector extends StatefulWidget {
  final List<RecipeDrink> _drinks;

  DrinksSelector(this._drinks, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrinksSelectorState();
}

class _DrinksSelectorState extends State<DrinksSelector> {
  Row _drinkRow(String value, int index, BuildContext context) {
    return Row(
      key: widget._drinks[index].key,
      children: [
        Expanded(
          child: inputField(
            context,
            initialValue: value,
            onSaved: (newValue) =>
                setState(() => widget._drinks[index].drink = newValue),
          ),
        ),
        IconButton(
          icon: Icon(Icons.cancel_outlined),
          onPressed: () => setState(() => widget._drinks.removeAt(index)),
          color: Theme.of(context).errorColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...[
          for (MapEntry<int, RecipeDrink> entry
          in widget._drinks.asMap().entries)
            _drinkRow(entry.value.drink, entry.key, context)
        ],
        Container(
          width: double.infinity,
          child: RawMaterialButton(
            onPressed: () => setState(() => widget._drinks.add(RecipeDrink())),
            elevation: 2.0,
            fillColor: elementBackgroundColor,
            child: Icon(Icons.add),
            padding: EdgeInsets.all(5.0),
            shape: CircleBorder(),
          ),
        ),
        Text("Add another", style: Theme.of(context).textTheme.headline4)
      ],
    );
  }
}
