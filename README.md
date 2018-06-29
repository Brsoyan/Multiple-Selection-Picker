# Multiple-Selection-Picker

PickerViewHandler,DatePickerViewHandler and MultipleSelectionPickerViewHandler easy to use.
Create picker handeler `private var pickerHandler = PickerViewHandler(data: [])`

https://github.com/Brsoyan/Multiple-Selection-Picker/blob/master/Info/gif1.gif

When should show call `config` function and pass parent View Controller, data if needed and onSelectedTitle closure if needed update dynamic.

Create PickerEventsDelegate listener if we need to listen show and close actions.
`
protocol PickerEventsDelegate: class {
    func pickerWillShow(height: CGFloat)
    func pickerDidHide(height: CGFloat)
}
` 

https://github.com/Brsoyan/Multiple-Selection-Picker/blob/master/Info/gif2.gif
In MultipleSelectionPickerViewHandler picker view is a custom view, you can override `SelectionView`
