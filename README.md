<snippet>
<content>
# AwfulBinding

This is a terribly simplistic "binding framework" written in Swift. There's nothing super special about it...it's just glorified object wrappers that call listener functions when the values change.

## Installation

1. Carthage
  * Add `github "zacharyclaysmith/AwfulBinding"` to your Cartfile
  * Run `carthage update`
2. CocoaPods
  * *Not yet supported*
3. Manual Installation
  * Clone the repo
  * Build
  * Include the framework in your project.

## Usage

### BindableValue<T>

`BindableValue<T>` is the heart of this bindable library. `BindableValue<T>`'s are pretty simple...they have a `value`, `changeListeners`, `anyUpdateListeners`.

#### `value` property
The value property is the heart of the BindableValue library. The under-the-hood implementation is fairly simple...just a setter and getter, where the setter calls some listener functions.

There is a shorthand `v` property that can be used to access the value property.

#### Change Listeners
Change listeners are called whenever the `value` setter is called (i.e. whenever the value property is changed). Use the `addChangeListener` method to add a change listener (that sounds pretty obvious, but now you know it's obvious ;) ).

Use the `alertNow` parameter of `addChangeListener` when you want the listener called immediately upon binding.

Call `removeChangeListener` to clean up...typically in a deinit method. This isn't super-important for values whose lives are tied to that of their listener, but for long-lived values, not cleaning up could seriously impact performance and stability.

#### Any Update Listeners
Update listeners are a protocol-friendly version of change listeners. This is typically used when you need to bind to something generically, e.g. detect modifications over a heterogenous collection of PUpdateable objects. Use the `addAnyUpdateListener` method similarly to the `addChangeListener`.

```
func example_addChangeListener(){
    let someBindableString = BindableValue<String>(initialValue:"test")

    someBindableString.addListener(self, listener: someListener)

    someBindableString.value = "newValue" //EFFECT: someListener is called with a value of "newValue"
}

func someListener(value:String){
    //DO SOMETHING
}
```

```
func example_alertNow(){
    let someBindableString = BindableValue<String>(initialValue:"test")

    someBindableString.addListener(self, listener: someListener, alertNow:true) //EFFECT: someListener is called with a value of "test"

    someBindableString.value = "newValue" //EFFECT: someListener is called with a value of "newValue"
}

func someListener(value:String){
    //DO SOMETHING
}
```

```
func example_removeChangeListener(){
    let someBindableString = BindableValue<String>(initialValue:"test")

    someBindableString.addChangeListener(self, listener: someListener, alertNow:true) //EFFECT: someListener is called with a value of "test"

    someBindableString.value = "newValue" //EFFECT: someListener is called with a value of "newValue"

    someBindableString.removeChangeListener(self)

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

MIT
</content>
</snippet>