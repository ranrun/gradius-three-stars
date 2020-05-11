import ScreenSaver

class StarGroup: NSObject {

  var point: NSPoint
  var size: CGFloat
  var direction: NSPoint
  var stars: [Star] = []
  var visible = true
  var count = 0

  init(point: NSPoint, size: CGFloat, direction: NSPoint) {
    self.point = point
    self.size = size
    self.direction = StarGroup.speedUpDirection(direction)
    let randomStar = SSRandomIntBetween(0, 12)
    let halfSize = size/2.0
    let thirdSize = size/3.0
    let quarterSize = size/4.0

    switch randomStar {
    case 0: // single
      let orange = NSColor.init(calibratedRed: 1.0, green: 190.0/255.0, blue: 1.0/255.0, alpha: 1.0)
      stars.append(Star(point:NSMakePoint(0, 0), direction:self.direction, color:orange, count:count))
    case 1:
      let green = NSColor.init(calibratedRed: 0, green: 144.0/255.0, blue: 0, alpha: 1.0)
      stars.append(Star(point:NSMakePoint(0, 0), direction:self.direction, color:green, count:count))
    case 2, 3: // blue pair
      let lightBlue = NSColor.init(calibratedRed: 137.0/255.0, green: 190.0/255.0, blue: 1.0, alpha: 1.0)
      let darkBlue = NSColor.init(calibratedRed: 0, green: 64.0/255.0, blue: 159.0/255.0, alpha: 1.0)
      let upperLeft = NSMakePoint(0, size)
      let bottomRight = NSMakePoint(size, 0)
      stars.append(Star(point:upperLeft, direction:self.direction, color:lightBlue, count:count))
      stars.append(Star(point: bottomRight, direction:self.direction, color:darkBlue, count:count))
    case 4: // green pair
      let green = NSColor.init(calibratedRed: 0, green: 144.0/255.0, blue: 0, alpha: 1.0)
      let white = NSColor.init(calibratedRed: 226.0/255.0, green: 266.0/255.0, blue: 266.0/266.0, alpha: 1.0)
      let bottomLeft = NSMakePoint(0, 0)
      let topRight = NSMakePoint(size, size)
      stars.append(Star(point:bottomLeft, direction:self.direction, color:green, count:count))
      stars.append(Star(point:topRight, direction:self.direction, color:white, count:count))
    case 5: // green pair vertical
      let green = NSColor.init(calibratedRed: 0, green: 144.0/255.0, blue: 0, alpha: 1.0)
      let white = NSColor.init(calibratedRed: 226.0/255.0, green: 266.0/255.0, blue: 266.0/266.0, alpha: 1.0)
      let top = NSMakePoint(0, size)
      let bottom = NSMakePoint(7, 0)
      stars.append(Star(point: top, direction:self.direction, color:green, count:count))
      stars.append(Star(point: bottom, direction:self.direction, color:white, count:count))
    case 6: // green pair vertical reversed
      let white = NSColor.init(calibratedRed: 226.0/255.0, green: 266.0/255.0, blue: 266.0/266.0, alpha: 1.0)
      let green = NSColor.init(calibratedRed: 0, green: 144.0/255.0, blue: 0, alpha: 1.0)
      let top = NSMakePoint(7, size)
      let bottom = NSMakePoint(0, 0)
      stars.append(Star(point:top, direction:self.direction, color:white, count:count))
      stars.append(Star(point:bottom, direction:self.direction, color:green, count:count))
    case 7: // orange close pair
      let orange = NSColor.init(calibratedRed: 184.0/255.0, green: 40.0/255.0, blue: 0, alpha: 1.0)
      let white = NSColor.init(calibratedRed: 166/255.0, green: 167.0/255.0, blue: 211/266.0, alpha: 1.0)
      let topLeft = NSMakePoint(0, size)
      let downRight = NSMakePoint(halfSize, halfSize)
      stars.append(Star(point:topLeft, direction:self.direction, color:orange, count:count))
      stars.append(Star(point:downRight, direction:self.direction, color:white, count:count))
    case 8, 9: // orange triange
      let orange = NSColor.init(calibratedRed: 180.0/255.0, green: 102.0/255.0, blue: 0, alpha: 1.0)
      let green = NSColor.init(calibratedRed: 48.0/255.0, green: 93.0/255.0, blue: 80.0/255.0, alpha: 1.0)
      let white = NSColor.init(calibratedRed: 171.0/255.0, green: 216.0/255.0, blue: 201.0/255.0, alpha: 1.0)
      let upperLeft = NSMakePoint(0, size)
      let middleRight = NSMakePoint(size, halfSize)
      let bottomMiddle = NSMakePoint(thirdSize, 0)
      stars.append(Star(point:upperLeft, direction:direction, color:orange, count:count))
      stars.append(Star(point:middleRight, direction:direction, color:green, count:count))
      stars.append(Star(point:bottomMiddle, direction:direction, color:white, count:count))
    case 10: // orange triange hypotenuse up and to the right
      let orange = NSColor.init(calibratedRed: 189.0/255.0, green: 40.0/255.0, blue: 0, alpha: 1.0)
      let white = NSColor.init(calibratedRed: 171.0/255.0, green: 216.0/255.0, blue: 201.0/255.0, alpha: 1.0)
      let upperLeft = NSMakePoint(0, size)
      let bottomLeft = NSMakePoint(quarterSize, quarterSize)
      let bottomRight = NSMakePoint(size, 0)
      stars.append(Star(point:upperLeft, direction:direction, color:white, count:count))
      stars.append(Star(point:bottomLeft, direction:direction, color:orange, count:count))
      stars.append(Star(point:bottomRight, direction:direction, color:white, count:count))
     case 11: // orange triange hypotenuse down and to the right
        let orange = NSColor.init(calibratedRed: 189.0/255.0, green: 40.0/255.0, blue: 0, alpha: 1.0)
        let white = NSColor.init(calibratedRed: 171.0/255.0, green: 216.0/255.0, blue: 201.0/255.0, alpha: 1.0)
        let upperLeft = NSMakePoint(0, 0)
        let bottomLeft = NSMakePoint(quarterSize, size - quarterSize)
        let bottomRight = NSMakePoint(size, size)
        stars.append(Star(point:upperLeft, direction:direction, color:white, count:count))
        stars.append(Star(point:bottomLeft, direction:direction, color:orange, count:count))
        stars.append(Star(point:bottomRight, direction:direction, color:white, count:count))
    default:
      stars.append(Star(point:NSMakePoint(0, 0), direction:direction, color:NSColor.white, count:count))
    }
  }

  func update() {
    count += 1
    point = NSMakePoint(point.x + direction.x, point.y + direction.y)
  }

  func isAlive(_ rect: NSRect) -> Bool {
    let alive = stars.filter {
      let star = ($0 as Star)
      return star.isAlive(rect)
    }
    return !alive.isEmpty
  }

  class func speedUpDirection(_ direction: NSPoint) -> NSPoint {
    let speedMultiple = SSRandomIntBetween(0, 13)
    switch speedMultiple {
    case 1:
      return NSMakePoint(direction.x * 0.5, direction.y * 0.5)
    case 2, 3, 4, 5:
      return NSMakePoint(direction.x * 2, direction.y * 2)
    case 6, 7, 8:
      return NSMakePoint(direction.x * 3, direction.y * 3)
    case 12:
      return NSMakePoint(direction.x * 4, direction.y * 4)
    default:
      return direction
    }
  }

}
