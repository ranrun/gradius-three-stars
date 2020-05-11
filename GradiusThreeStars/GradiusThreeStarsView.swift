//
//  GradiusThreeStarsView.swift
//  GradiusThreeStars
//
//  Created by ran on 5/3/20.
//  Copyright © 2020 ran. All rights reserved.
//

import ScreenSaver

class GradiusStarsView : ScreenSaverView {
  let myModuleName = "com.ranrun.GradiusThreeStars"

  override var hasConfigureSheet: Bool { return false }
  override var configureSheet: NSWindow? { return nil }

  var viewBounds: NSRect
  var maxX: CGFloat
  var maxY: CGFloat
  var previewFlag: Bool
  var stars: [Star] = []
  var starGroups: [StarGroup] = []
  var starGroupSize = CGFloat(23)
  var squareSize = CGFloat(5)
  var globalCounter = 0
  var lastAddedPoint: NSPoint = NSMakePoint(0, 0)
  let debug = false
  var setBounds = true

  override init?(frame: NSRect, isPreview: Bool) {
    viewBounds = frame
    maxX = frame.maxX
    maxY = frame.maxY
    previewFlag = maxY < 500
    super.init(frame: frame, isPreview: isPreview)
    animationTimeInterval = (1.0 / 30.0)
    setSizes(frame)
  }

  required init?(coder: NSCoder) {
    viewBounds = NSMakeRect(0, 0, 100, 100)
    maxX = 100
    maxY = 100
    previewFlag = true
    super.init(coder: coder)
    setSizes(frame)
  }

  override func animateOneFrame() {
    NSAnimationContext.runAnimationGroup({(context) -> Void in

      if globalCounter % 30 == 0 {
        addStarGroup(rect:viewBounds)
      }

      for starGroup in starGroups {
        starGroup.update()
      }

      starGroups = starGroups.filter {
        let starGroup = ($0 as StarGroup)
        return starGroup.isAlive(viewBounds)
      }

      globalCounter += 1
    }) {
      // all done
      self.needsDisplay = true
    }
  }

  override func draw(_ rect: NSRect) {

    if setBounds {
      viewBounds = rect
      maxX = frame.maxX
      maxY = frame.maxY
      setBounds = false
      setSizes(frame)
    }

    NSColor.black.set()
    NSBezierPath.fill(rect)

    drawSquares(rect)
    drawStarGroups(rect)
  }

  func addStarGroup(rect: NSRect) {
    let newY = SSRandomFloatBetween(rect.minY, rect.maxY)
    let point = NSMakePoint(rect.maxX, newY)
    let direction = NSMakePoint(-1, 0)
    let newStarGroup = StarGroup(point:point, size:starGroupSize, direction:direction)
    starGroups.append(newStarGroup)
  }

  func drawSquares(_ rect: NSRect) {
    if debug {
      drawSquare(point:NSMakePoint(rect.minX + 50, rect.minY + 50), color:NSColor.systemRed, size:10, fill: false)
      drawSquare(point:NSMakePoint(rect.maxX - 50, rect.minY + 50), color:NSColor.systemGreen, size:10, fill: false)
      drawSquare(point:NSMakePoint(rect.minX + 50, rect.maxY - 50), color:NSColor.systemBlue, size:10, fill: false)
      drawSquare(point:NSMakePoint(rect.maxX - 50, rect.maxY - 50), color:NSColor.systemOrange, size:10, fill: false)
    }
  }

  func drawStarGroups(_ rect: NSRect) {
    for starGroup in starGroups {
      for star in starGroup.stars {
        if star.visible {
          let point = NSMakePoint(starGroup.point.x + star.point.x, starGroup.point.y + star.point.y)
          drawSquare(point: point, color: star.color, size:squareSize, fill: true)
        }
      }
    }
  }

  func drawSquare(point: NSPoint, color: NSColor, size: CGFloat, fill: Bool) {
    let ctx: CGContext = currentContext()
    ctx.saveGState()
    ctx.translateBy(x:point.x, y:point.y)
    color.set()
    let bPath = NSBezierPath.init()
    bPath.move(to: NSPoint.init(x:0, y:0))
    bPath.line(to: NSPoint.init(x:size + 1, y:0))
    bPath.line(to: NSPoint.init(x:size + 1, y:size))
    bPath.line(to:NSPoint.init(x:0, y:size))
    bPath.close()
    bPath.lineWidth = 2
    if fill {
      bPath.fill()
    } else {
      bPath.stroke()
    }
    ctx.restoreGState()
  }

  func setSizes(_ rect: NSRect) {
    if previewFlag {
      squareSize = maxY * 0.02
    } else {
      squareSize = maxY * 0.005
    }
    starGroupSize = squareSize * 5
  }

  override func viewDidMoveToWindow() {
    setBounds = true;
  }

  override func startAnimation() {
    super.startAnimation()
  }

  override func stopAnimation() {
    super.stopAnimation()
  }

  func currentContext() -> CGContext {
    return NSGraphicsContext.current!.cgContext
  }

}
