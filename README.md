[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# PPSwiftGifs

PPSwiftGifs provides a convenient way to show animated GIF images as a part of iOS GUI.

## Installation

### Carthage
* `> Cartfile`
* `nano Cartfile`
* put `github "peterprokop/PPSwiftGifs"` into Cartfile
* Save it: `ctrl-x`, `y`, `enter`
* Run `carthage update`
* Copy `PPSwiftGifs.framework` from `Carthage/Build/iOS` to your project
* Make sure that `PPSwiftGifs` is added in `Embedded Binaries` section of your target (or else you will get `dyld library not loaded referenced from ... reason image not found` error)
* Add `import PPSwiftGifs` on top of your view controller's code

### Manual

* Just clone this repo and add ```PPSwiftGifs.swift``` to your project.
* Add ImageIO.framework to your project.
* Add ```#import <ImageIO/ImageIO.h>``` to bridging header.

## Requirements

Swift 5. For older Swift versions please check previous releases. 

## Usage

```swift
imageView.image = PPSwiftGifs.animatedImageWithGIF(named: "gif_name")
```

(File named "gif_name.gif" should be present in your project and copied as a bundle resource.
Currently  you can't add GIFs to asset catalogs.)

Alternatively, you can construct animated image from data:
```swift
imageView.image = PPSwiftGifs.animatedImageWithGIF(data: data)
```


## Author(s)

PPSwiftGifs is written by Peter Prokop but borrows heavily from 
[uiimage-from-animated-gif](https://github.com/mayoff/uiimage-from-animated-gif)
project by Rob Mayoff.

## Contribution

You are welcome to fork and submit pull requests
