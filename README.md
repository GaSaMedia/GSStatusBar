# GSStatusBar

GSStatusBar is a simple UIStatusBar overlay view for displaying a loading indicator and text above the iPhone statusbar. 

![Screenshot](https://dl.dropboxusercontent.com/u/7865025/github/GSStatusView/Screen%20Shot%202014-02-18%20at%2012.10.20.png)

## Get started

- [Download GSStatusBar](https://github.com/GaSaMedia/GSStatusBar/archive/master.zip)

```ruby
platform :ios
pod "GSStatusBar"
```

## Requirements

GSProgressHUD requires Xcode 4/5, targeting iOS 5.0 and above.

## Basic usage

#### Display loading indicator over UIStatusBar
```objective-c
[GSStatusBar show];
```

#### Hide loading indicator over UIStatusBar
```objective-c
if ([GSStatusBar isVisible]) {
  [GSStatusBar hide];
}
```


## Credits

GSStatusBar is partly based upon [SVProgressHUD](https://github.com/samvermette/SVProgressHUD)

## Contact

Follow GaSa Media on Twitter [@gasamedia](https://twitter.com/gasamedia)

## License

GSProgressHUD is available under the MIT license. See the LICENSE file for more info.
