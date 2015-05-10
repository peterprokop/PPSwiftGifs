# PPSwiftGifs

PPSwiftGifs provides a convenient way to show animated GIF images as a part of iOS GUI.

## Installation

* Just clone this repo and add ```PPSwiftGifs.swift``` to your project.
* Add ImageIO.framework to your project.
* Add ```#import <ImageIO/ImageIO.h>``` to bridging header.

## Requirements

Swift 1.2:
- iOS 7.0+
- Xcode 6.3+

Swift 1.1:
Use [swift-1.1 branch](https://github.com/peterprokop/PPSwiftGifs/tree/swift-1.1)
- iOS 7.0+
- Xcode 6.1-6.2

## Usage

```
imageView.image = PPSwiftGifs.animatedImageWithGIFNamed("gif_name")
```

(File named "gif_name.gif" should be present in your project and copied as a bundle resource.
As far as I know, you can't add GIFs to asset catalogs.)

## Author(s)

PPSwiftGifs is written by Peter Prokop but borrows heavily from 
[uiimage-from-animated-gif](https://github.com/mayoff/uiimage-from-animated-gif)
project by Rob Mayoff.

## Contribution

You are welcome to fork and submit pull requests
