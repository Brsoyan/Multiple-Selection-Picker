# Multiple-Selection-Picker

PickerViewHandler,DatePickerViewHandler and MultipleSelectionPickerViewHandler easy to use.
Create picker handeler `private var pickerHandler = PickerViewHandler(data: [])`

![](https://github.com/Brsoyan/Multiple-Selection-Picker/blob/master/Info/git1.gif)

When should show picker call `config` function and pass parent View Controller, data if you don't pass in initializer and onSelectedTitle closure if we need to update our view dynamically.

Create PickerEventsDelegate listener if we need to listen show and close actions.

`protocol PickerEventsDelegate: class {`
    `func pickerWillShow(height: CGFloat)`
    `func pickerDidHide(height: CGFloat)`
`}`

![](https://github.com/Brsoyan/Multiple-Selection-Picker/blob/master/Info/gif2.gif)
In MultipleSelectionPickerViewHandler picker view is a custom view, you can override `SelectionView`

Confirm to protocol MultiplePickerEventsDelegate and handle events. <br />

`protocol MultiplePickerEventsDelegate: class {`
    `func pickerDidHide(text: String, owner: UIView?)`
    `func warningTextIsEmpty(owner: UIView?)`
`}`
