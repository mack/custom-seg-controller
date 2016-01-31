# EVSCustomSegmentedController
A customizable UIControl 

Very easy set up...
Define what items you'd like to have in the controller
```swift 
EVSCustomSegmentedController.items = ["ITEM1", "ITEM2", "ITEM3"]
```

Then simply add a IBAction for value changed (like you would with a normal segmented controller), check what the selectedIndex is and voila! 
```swift
    @IBAction func update(sender: EVSCustomSegmentedController) {
        if sender.selectedIndex == 0 {
        // Do something
        } else {
        // Do something else 
        }
    }
```

## Preview
[[http://s7.postimg.org/bp4ckppu3/Simulator_Screen_Shot_Jan_31_2016_4_28_06_AM.png|alt=preview]]

