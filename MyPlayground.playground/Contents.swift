import Foundation
import UIKit

let data = try! JSONEncoder().encode(Date())
let encodedString = String(data: data, encoding: .utf8)
