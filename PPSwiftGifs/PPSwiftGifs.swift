//
//  PPSwiftGifs.swift
//  PPSwiftGifsExample
//
//  Created by Peter Prokop on 08/11/14.
//  Copyright (c) 2014 Peter Prokop. All rights reserved.
//

import CoreFoundation
import Foundation
import ImageIO
import UIKit

public class PPSwiftGifs {
    // MARK: Public

    public class func animatedImageWithGIF(named name: String!) -> UIImage? {
        let screenScale = Int(UIScreen.main.scale)
        let possibleScales = [1, 2, 3]
        let orderedScales = [screenScale] + possibleScales.filter { $0 != screenScale }

        let suffixes = orderedScales.map { ["@\($0)x", "@\($0)X"] }
        let orderedSuffixes = suffixes.flatMap { $0 } + [""]

        for suffix in orderedSuffixes {
            if let url = Bundle.main.url(forResource: name + suffix, withExtension: "gif"),
               let source = CGImageSourceCreateWithURL(url as CFURL, nil)
            {
                return animatedImageWithImageSource(source: source)
            }
        }

        return nil
    }

    public class func animatedImageWithGIF(data: Data) -> UIImage? {
        if let source = CGImageSourceCreateWithData(data as NSData, nil) {
            return animatedImageWithImageSource(source: source)
        }

        return nil
    }

    // MARK: Private

    private class func animatedImageWithImageSource(source: CGImageSource) -> UIImage? {
        let (images, delays) = createImagesAndDelays(source: source)
        let totalDuration = delays.reduce(0, +)
        let frames = frameArray(
            images: images,
            delays: delays,
            totalDuration: totalDuration
        )

        // All durations in GIF are in 1/100th of second
        let duration = TimeInterval(Double(totalDuration) / 100.0)
        let animation = UIImage.animatedImage(with: frames, duration: duration)

        return animation
    }

    private class func createImagesAndDelays(source: CGImageSource) -> ([CGImage], [Int]) {
        let count = Int(CGImageSourceGetCount(source))

        var images = [CGImage]()
        var delays = [Int]()

        for i in 0..<count {
            images.append(CGImageSourceCreateImageAtIndex(source, i, nil)!)
            delays.append(delayForImage(source: source, at: i))
        }

        return (images, delays)
    }

    private class func delayForImage(source: CGImageSource, at i: Int) -> Int {
        var delay = 1

        let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil)

        if properties != nil {
            let gifDictionaryProperty = unsafeBitCast(kCGImagePropertyGIFDictionary, to: UnsafeRawPointer.self)
            let gifProperties = CFDictionaryGetValue(properties, gifDictionaryProperty)

            if gifProperties != nil {
                let gifPropertiesCFD = unsafeBitCast(gifProperties, to: CFDictionary.self)

                let unclampedDelayTimeProperty = unsafeBitCast(
                    kCGImagePropertyGIFUnclampedDelayTime,
                    to: UnsafeRawPointer.self
                )
                var number = unsafeBitCast(
                    CFDictionaryGetValue(gifPropertiesCFD, unclampedDelayTimeProperty),
                    to: NSNumber.self
                )

                if number.doubleValue == 0 {
                    let delayTimeProperty = unsafeBitCast(kCGImagePropertyGIFDelayTime, to: UnsafeRawPointer.self)
                    number = unsafeBitCast(CFDictionaryGetValue(gifPropertiesCFD, delayTimeProperty), to: NSNumber.self)
                }

                if number.doubleValue > 0 {
                    delay = lrint(number.doubleValue * 100)
                }
            }
        }

        return delay
    }

    private class func frameArray(images: [CGImage], delays: [Int], totalDuration: Int) -> [UIImage] {
        let delayGCD = gcd(values: delays)
        var frames = [UIImage]()
        frames.reserveCapacity(images.count)

        for i in 0..<images.count {
            let frame = UIImage(cgImage: images[i], scale: UIScreen.main.scale, orientation: .up)
            for _ in 0..<delays[i] / delayGCD {
                frames.append(frame)
            }
        }

        return frames
    }

    private class func gcd(values: [Int]) -> Int {
        return values.reduce(1, gcd)
    }

    private class func gcd(_ num1: Int, _ num2: Int) -> Int {
        var a = num1
        var b = num2

        while true {
            let r = a % b
            if r == 0 {
                return b
            }
            a = b
            b = r
        }
    }
}
