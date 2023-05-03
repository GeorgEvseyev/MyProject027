//
//  ViewController.swift
//  MyProject027
//
//  Created by Георгий Евсеев on 24.11.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!

    var currentDrawType = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        drawRectangle()
    }

    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1

        if currentDrawType > 7 {
            currentDrawType = 0
        }

        switch currentDrawType {
        case 0:
            drawRectangle()

        case 1:
            drawCircle()

        case 2:
            drawChekerboard()

        case 3:
            drawRotatedSquares()

        case 4:
            drawLines()

        case 5:
            drawImagesAndText()

        case 6:
            drawEmoji()

        case 7:
            drawWord()

        default:
            break
        }
    }

    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)

            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = image
    }

    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502).insetBy(dx: 5, dy: 5)

            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = image
    }

    func drawChekerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)

            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col).isMultiple(of: 2) {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }

        imageView.image = image
    }

    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)

            let rotations = 16
            let amount = Double.pi / Double(rotations)

            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }

        imageView.image = image
    }

    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)

            var first = true
            var lenght: CGFloat = 256

            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)

                if first {
                    ctx.cgContext.move(to: CGPoint(x: lenght, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: lenght, y: 50))
                }

                lenght *= 0.99
            }

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }

        imageView.image = image
    }

    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { _ in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 36), .paragraphStyle: paragraphStyle,
            ]

            let string = "The best-laid schemes o'\nmice an' men gang aft agley"

            let attributedString = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)

            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }

        imageView.image = image
    }

    func drawEmoji() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502).insetBy(dx: 5, dy: 5)
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(5)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.addEllipse(in: CGRect(x: 130, y: 150, width: 50, height: 50))
            ctx.cgContext.addEllipse(in: CGRect(x: 320, y: 150, width: 50, height: 50))
            ctx.cgContext.move(to: CGPoint(x: 400, y: 400))

            ctx.cgContext.addArc(center: CGPoint(x: 256, y: 256), radius: 200, startAngle: 3 * .pi / 4, endAngle: .pi / 4, clockwise: true)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = image
    }

    func drawWord() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in

//            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            ctx.cgContext.move(to: CGPoint(x: 0, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 50, y: 50))
            ctx.cgContext.move(to: CGPoint(x: 25, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 25, y: 100))
            ctx.cgContext.move(to: CGPoint(x: 55, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 65, y: 100))
            ctx.cgContext.move(to: CGPoint(x: 65, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 75, y: 50))
            ctx.cgContext.move(to: CGPoint(x: 75, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 85, y: 100))
            ctx.cgContext.move(to: CGPoint(x: 85, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 95, y: 50))
            ctx.cgContext.move(to: CGPoint(x: 100, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 100, y: 100))
            ctx.cgContext.move(to: CGPoint(x: 105, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 105, y: 100))
            ctx.cgContext.move(to: CGPoint(x: 105, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 135, y: 100))
            ctx.cgContext.move(to: CGPoint(x: 135, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 135, y: 100))

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }

        imageView.image = image
    }
}
