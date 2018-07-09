# Multiple-Selection-Picker

![](https://github.com/Brsoyan/Multiple-Selection-Picker/blob/master/Info/gif0.gif)

Download example project.
Run ```pod install```  in a terminal in the folder ~/Multiple-Selection-Picker/Example  of project. 


PickerViewHandler,DatePickerViewHandler and MultipleSelectionPickerViewHandler easy to use.
Create picker handeler `private var pickerHandler = PickerViewHandler(data: PickerData())`

Data confirm to protocol  `PickerData`

```
protocol PickerData: class {
    func id(for row: Int) -> Int
    func long(for row: Int) -> String
    func short(for row: Int) -> String
    func count() -> Int
}
```

![](https://github.com/Brsoyan/Multiple-Selection-Picker/blob/master/Info/git1.gif)

When should show picker call `config` function and pass parent View Controller, data if you don't pass in initializer and onSelectedTitle closure if we need to update our view dynamically.

Create PickerDelegate listener if we need to listen show and close actions.

```
protocol PickerDelegate: class {
    func pickerDidHide(text: String, owner: UIView?, ids:[Int])
    func pickerTextIsEmpty(owner: UIView?)
}
```

![](https://github.com/Brsoyan/Multiple-Selection-Picker/blob/master/Info/gif2.gif)


In MultipleSelectionPickerViewHandler picker view is a custom view, you can override `SelectionView`


