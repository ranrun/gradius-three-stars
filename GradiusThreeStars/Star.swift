import ScreenSaver

class Star: NSObject {
  var point: NSPoint
  var direction: NSPoint
  var color: NSColor
  var count: Int = 0
  var visible: Bool = true

  init(point:NSPoint, direction:NSPoint, color:NSColor, count:Int) {
    self.point = point
    self.direction = direction
    self.color = color
    self.count = count
  }

  func update() {
    count += 1
    let newPoint = NSMakePoint(point.x + direction.x, point.y + direction.y)
    point = newPoint
  }

  func isAlive(_ rect: NSRect) -> Bool {
    let radius:CGFloat = 5
    if rect.minX - radius <= point.x && point.x <= rect.maxX + radius {
      if rect.minY - radius <= point.y && point.y <= rect.maxY + radius {
        return true
      }
    }
    return false
  }

}
