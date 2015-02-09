<snippet>
<content>
# AwfulBinding

This is a terribly simplistic "binding framework" written in Swift. There's nothing super special about it...it's just glorified object wrappers that call listener functions when the values change.

## Installation

1. Carthage
  * Add `github "zacharyclaysmith/AwfulBinding"` to your Cartfile
  * Run `carthage update`
2. CocoaPods
*Not yet supported*
3. Manual Installation
Just pull down the repo and build it, then include the framework in your project.

## Usage

### BindableValue<T>

`BindableValue<T>` has a generic property called `value` and a function called `addListener`. Any listeners added through the `addListener` function are called whenever `value` is changed.

```
func addListener_example(){
    let someBindableString = BindableValue<String>(initialValue:"test")

    someBindableString.addListener(self, listener: someListener)

    someBindableString.value = "newValue" //EFFECT: someListener is called with a value of "newValue"
}

func someListener(value:String){
    //DO SOMETHING
}
```

```
func alertNow_example(){
    let someBindableString = BindableValue<String>(initialValue:"test")

    someBindableString.addListener(self, listener: someListener, alertNow:true) //EFFECT: someListener is called with a value of "test"

    someBindableString.value = "newValue" //EFFECT: someListener is called with a value of "newValue"
}

func someListener(value:String){
    //DO SOMETHING
}
```

```
func removeListener_example(){
    let someBindableString = BindableValue<String>(initialValue:"test")

    someBindableString.addListener(self, listener: someListener, alertNow:true) //EFFECT: someListener is called with a value of "test"

    someBindableString.value = "newValue" //EFFECT: someListener is called with a value of "newValue"

    someBindableString.removeListener(self)

    someBindableString.value = "anotherValue"  //EFFECT: someListener is NOT called.
}

func someListener(value:String){
    //DO SOMETHING
}
```

### BindableArray<T>

```
func addIndexChangedListener_example(){
    let bindableArray = BindableArray<String>(initialArray:[])

    bindableArray.addIndexChangedListener(self, listener:someListener)

    bindableArray.append("someString") //EFFECT: someListener is called
}

func someListener(index:Int){
    //DO SOMETHING
}

```

## History

I wanted a simple binding framework for iOS/Swift, so I started this. It's proven itself pretty useful. I've used several binding frameworks over the year and have learned that basic value and array support are really all you need, plus some UI sugar on top (see https://github.com/zacharyclaysmith/AwfulBindingUI for that mess).

I don't consider this library complete or well tested, yet, but it's functional and a good starting point. I'd like to keep it as simple as possible, however, and build other libraries around it.

## Credits

Viewers like you.

## License

TODO: Write license
]]></content>
<tabTrigger>readme</tabTrigger>
</snippet>