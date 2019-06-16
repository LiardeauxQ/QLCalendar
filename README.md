# QLCalendar 📅 

## Presentation

This framework is in beta.
Its aim is to give you the possibility to add Calendar views and manage date in your iOS Swift project.

## How to install

You can add source files directly in your project or use cocapods, see below:

```
pod init
```

In podfile, insert:
```
platform :ios, '12.0'

source "https://gitlab.com/qLiardeaux/Specs.git" # Repository to get QLCalendar

target 'NameOfYourProject' do
   use_frameworks!

    pod 'QLCalendar'

end
```

```
pod install
```
## Example

<p align="center">
  <img src=".resources/iPhone_example_screen.png" width="350" title="hover text">
</p>

## License

MIT
