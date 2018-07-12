# MultiPickerView


## Integration

1. You can use [CocoaPods](https://www.google.com) to install MultiPickerView by adding it to your Podfile.
2. Add this line to your Podfile
        ``` pod 'MultiPickerView' ```

3. Run the following command:
        ``` pod install ```

4. Don't forget to use the `.xcworkspace` file to open your project in Xcode, instead of the `.xcodeproj` file, from here on out.

5. In the future, to update to the latest version of the SDK, just run:
        ``` pod update MultiPickerView ```


## Examples

There are 1 example app included in the repository:
- [Example](https://github.com/Brsoyan/Multiple-Selection-Picker/tree/master/Example)

    Example app is a great place to start if you're evaluating whether you want to use our Standard Integration (Swift) or build your own Custom Integration (ObjC).

    Open ./Stripe.xcworkspace (not ./MultipleSelectionPickerView.xcworkspace) with Xcode
    run `pod install` in terminal.

    Build and run the "MultipleSelectionPickerView" scheme

    ![](https://github.com/Brsoyan/Multiple-Selection-Picker/blob/master/Info/gif0.gif)

## Contributing

We welcome contributions of any kind including new features, bug fixes, and documentation improvements. Please first open an issue describing what you want to build if it is a major change so that we can discuss how to move forward. Otherwise, go ahead and open a pull request for minor changes such as typo fixes and one liners.

## Migrating from Older Versions

See `MIGRATING.md`

### Features
PickerViewHandler,DatePickerViewHandler and MultipleSelectionPickerViewHandler easy to use.
Create data let data = DataObj() 
DataObj will need to confitm to protocol `PickerData`

Create picker handeler `private var pickerHandler = PickerViewHandler(data: data)`

```
protocol PickerData: class {
    func id(for row: Int) -> Int
    func long(for row: Int) -> String
    func short(for row: Int) -> String
    func count() -> Int
}
```

When should show picker call `config` function and pass parent View Controller, data if you don't pass in initializer and onSelectedTitle closure if we need to update our view dynamically.

Create PickerDelegate listener if we need to listen show and close actions.

```
protocol PickerDelegate: class {
    func pickerDidHide(text: String, owner: UIView?, ids:[Int])
    func pickerTextIsEmpty(owner: UIView?)
}
```

In MultipleSelectionPickerViewHandler picker view is a custom view, you can override `SelectionView`


