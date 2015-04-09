<snippet>
<content>
# AwfulBinding

This is a terribly simplistic "binding framework" written in Swift. There's nothing super special about it...it's just glorified object wrappers that call listener functions when the values change.

This is meant to be a stand-alone library, but to see the companion UI stuff I built on top, check out https://github.com/zacharyclaysmith/AwfulBindingUI.

If you want something with way more stars and more code, please check out https://github.com/SwiftBond/Bond. It's scarily similar to this project (unintentional), but it looks to have a number of neat additions and more robust documentation. I don't like the coupling of the View and Binding code in a single project, but whatevs.

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

#### Examples

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
### `CalculatedValue<T>`

The `CalculatedValue<T>` is where the real power of this framework starts to shine through. These are essentially `BindableValue<T>`'s that actively listen to other `BindableValue<T>`'s and perform a claculation (via the `calculator` property) and to produce a new value. `CalculatedValue<T>`'s can listen to any number of `PUpdateable` protocol implementing classes (fun side-note, this is why that protocol was created in the first place).

For ease of interoperability (and because the Swift Laws of Protocols and Generics can be pretty frustrating, `CalculatedValue<T>`'s are just subtypes of `BindableValue<T>`. This means, though the `value` and `v` property setters are exposed publicly, they should not be used, or expect DIRE consequences (or at least unintended behavior...whatevs, you've been warned).

#### `calculator`
This is just a function that produces a value of the given `T` value for the `CalculatedValue<T>` object. This method takes no parameters...bound values should be referenced from a larger scope. If none of this makes sense, look at the examples.

#### Examples
```
func example_basicCalculatedValueUsage(){
  let bindableInteger = BindableValue<Int>(value: 0)

  let calculatedCurrencyString = CalculatedValue<String>([bindableInteger], {() -> String in
    return "$" + toString(bindableInteger.value) + ".00"
  })

  //EFFECT: calculatedCurrencyString.v == "$0.00"

  bindableInteger.value = 15

  //EFFECT: calculatedCurrencyString.v == "$15.00"
}
```

Keep in mind that you can created CalculatedValues from other CalculatedValues (Just be careful not to recursively bind a value to itself...black holes will form ;) ).

### `BindableValue<T>` -> `CalculatedValue<T>` Extensions

To make things more syntactically/semantically appealing, I wrote the following extension methods which really clean up some common use cases. These methods are `transform` and `combine`.

`transform` allows you to easily convert 1 BindableValue into another

#### Examples
```
func example_transform(){
  let bindableInteger = BindableValue<Int>(value: 0)

  let calculatedCurrencyString = bindableInteger.transform("$" + toString(bindableInteger.value) + ".00") //EFFECT: calculatedCurrencyString.v == "$0.00"

  bindableInteger.value = 15 //EFFECT: calculatedCurrencyString.v == "$15.00"
}
```

```
func example_combineSingle(){
  let bindableInteger = BindableValue<Int>(value: 1)
  let bindableInteger2 = BindableValue<Float>(value: 5.0)

  let sumCurrencyString = bindableInteger.combine(bindableInteger2, calculator: "$" + toString((bindableInteger.value + bindableFloat.value)) + ".00") //EFFECT: calculatedCurrencyString.v == "$6.00"

  bindableInteger.value = 15 //EFFECT: calculatedCurrencyString.v == "$20.00"
}

func example_combineMultiple(){
  let bindableInteger = BindableValue<Int>(value: 1)
  let bindableInteger2 = BindableValue<Int>(value: 5.0)
  let bindableInteger3 = BindableValue<Int>(value: 10.0)

  let sumDollarString = bindableInteger.combine([bindableInteger2, bindableInteger3], 
    calculator: "$" + toString((bindableInteger.value + bindableFloat.value + bindableFloat2.value)) + ".00") 
    //EFFECT: calculatedCurrencyString.v == "$16.00"

  bindableInteger.value = 15 //EFFECT: calculatedCurrencyString.v == "$31.00"
}
```

NOTE: although the above examples are all integers for simplicity (and because I'm a lazy example writer), keep in mind that you can combine any and all value types into a single calculated value. 

### BindableArray<T>
Bindable values are fun, but bindable arrays are where binding frameworks make the cheese (or whatever idiom you want to insert). I've tried to keep `BindableArray<T>` simple; you have the ability to listen to array and detect when an index has changed or when the structure of the array has changed.

`BindableArray<T>` is a wrapper for the Swift `Array` class, meaning `BindableArray<T>` reimplements many of the methods and functionality of the Swift `Array` class, but inserts some binding triggers into them where they make sense. For example, subarray access is wrapped so that `someStringArray[5] = "newValue"` triggers indexChanged listeners. 1-1 Wrapping is still a work in progress, so a public property `internalArray` and public `notifyIndexChangedListeners` and `notifyChangedListeners` functions are exposed so that manual changes and triggers can be made.

#### Index Changed Listener
In general, this is called whenever a single index has been affected by an operation. Such operations include: subscript assignment/modification and `append`. 

NOTE: I would recommend, in the case of bulk updates to many array values, to modify the values on the `internalArray` property, and then call `notifyChangedListeners` at the end to conserve execution cycles.

#### Changed Listeners
Change listeners are called whenever a change is made to the overall array, such as in deletes, splices, or bulk changes.

#### Room for Improvement
I tend to take the "optimize it when it's broken" approach to development, so I haven't spent too much time fine-tuning array operations, as they haven't caused me any headaches yet. Feel free to contact me if you need something in `BindableArray<T>` or `CalculatedArray<T>` made betterer, or if you want to contribute yourself :).

#### Examples

```
func example_append(){
    let bindableArray = BindableArray<String>(initialArray:[])

    bindableArray.addIndexChangedListener(self, listener:someListener)

    bindableArray.append("someString") //EFFECT: someListener is called with index == bindableArray.length - 1
}

func someListener(index:Int){
    //DO SOMETHING
}

```

### `CalculatedArray<T>`

TODO...It's actually pretty awesome, but I can only write so much documentation in a day.

## History

I wanted a simple binding framework for iOS/Swift, so I started this. It's proven itself pretty useful. I've used several binding frameworks over the year and have learned that basic value and array support are really all you need, plus some UI sugar on top (see https://github.com/zacharyclaysmith/AwfulBindingUI for that mess).

I don't consider this library complete or well tested, yet, but it's functional and a good starting point. I'd like to keep it as simple as possible, however, and build other libraries around it.

## Credits

Viewers like you. And my absolute hatred for managing UI data in iOS.

## License

MIT
</content>
</snippet>