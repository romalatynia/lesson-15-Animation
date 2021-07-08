//
//  ViewController.swift
//  Animation
//
//  Created by Harbros47 on 12.01.21.
//

import UIKit

class ViewController: UIViewController {
    
    private let view1 = UIView(frame: CGRect(x: 5, y: 200, width: 50, height: 50))
    private let view2 = UIView(frame: CGRect(x: 5, y: 300, width: 50, height: 50))
    private let view3 = UIView(frame: CGRect(x: 5, y: 400, width: 50, height: 50))
    private let view4 = UIView(frame: CGRect(x: 5, y: 500, width: 50, height: 50))
    private let view5 = UIView(frame: CGRect(x: 0, y: 50, width: 50, height: 50))
    private let view6 = UIView(frame: CGRect(x: 365, y: 50, width: 50, height: 50))
    private let view7 = UIView(frame: CGRect(x: 0, y: 750, width: 50, height: 50))
    private let view8 = UIView(frame: CGRect(x: 380, y: 750, width: 50, height: 50))
    private let dotX: CGFloat = 25.0
    private let dotY: CGFloat = 75.0
    private var arrayImage: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view1.backgroundColor = .black
        self.view.addSubview(view1)
        
        view2.backgroundColor = .black
        self.view.addSubview(view2)
        
        view3.backgroundColor = .black
        self.view.addSubview(view3)
        
        view4.backgroundColor = .black
        self.view.addSubview(view4)
        
        view5.backgroundColor = .red
        self.view.addSubview(view5)
        
        view6.backgroundColor = .yellow
        self.view.addSubview(view6)
        
        view7.backgroundColor = .green
        self.view.addSubview(view7)
        
        view8.backgroundColor = .blue
        self.view.addSubview(view8)
         
    }
    
    private let color: [UIColor] = [.red, .yellow, .green, .gray, .blue, .brown, .link]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for index in 1...8 {
            let image = UIImage(named: String(format: "hum %ld", index))
            
            guard let newImage = image else { continue }
            arrayImage.append(newImage)
        }
        
        let arrayView = [view1, view2, view3, view4]
        
        for index in 0..<4 {
            var option = UIView.AnimationOptions.curveEaseOut
            
            switch index {
            case 0:
                option = .curveLinear
            case 1:
                option = .curveEaseIn
            case 2:
                option = .curveEaseInOut
            default:
                break
            }
            self.movement(view: arrayView[index], option: option)
        }
        cycle()
        
        makeImageView(
            rect: CGRect(x: 25, y: 75, width: 100, height: 100),
            superView: self.view,
            arrayImage: arrayImage
        )
    }
    
    private func cycle() {
        for index in 0...4 {
            switch index {
            case 0:
                animated(
                    view: view5,
                    floatX: self.view.bounds.size.width - self.view5.frame.size.width / 2,
                    floatY: self.view5.frame.origin.y + (self.view5.bounds.size.width / 2),
                    color: .yellow,
                    transform: CGAffineTransform(rotationAngle: .pi)
                )
            case 1:
                animated(
                    view: self.view6,
                    floatX: self.view.bounds.size.width - self.view6.frame.size.width / 2,
                    floatY: self.view8.frame.origin.y + (self.view8.bounds.size.width / 2),
                    color: .blue,
                    transform: CGAffineTransform(rotationAngle: .pi/(-2))
                )
            case 2:
                animated(
                    view: self.view7,
                    floatX: self.dotX,
                    floatY: self.dotY,
                    color: .red,
                    transform: CGAffineTransform(rotationAngle: .pi/2)
                )
            case 3:
                animated(
                    view: self.view8,
                    floatX: self.view.bounds.size.width - self.view8.frame.size.width / 2,
                    floatY: self.view8.frame.origin.y + (self.view8.bounds.size.width / 2),
                    color: .green,
                    transform: CGAffineTransform(rotationAngle: .pi/(-2))
                )
            case 4:
                animated(
                    view: self.view8,
                    floatX: self.dotX,
                    floatY: self.view8.frame.origin.y + (self.view8.bounds.size.width / 2),
                    color: .green,
                    transform: CGAffineTransform(rotationAngle: .pi)
                )
            default:
                return
            }
        }
    }
    
    private func movement(view: UIView, option: UIView.AnimationOptions) {
        UIView.animate(withDuration: 2,
                       delay: 1,
                       options: [
                        option,
                        .repeat,
                        .autoreverse
                       ]) {
            view.center = CGPoint(
                x: self.view.bounds.size.width - (view.bounds.size.width / 2),
                y: view.frame.origin.y + (view.bounds.size.width / 2)
            )
            view.backgroundColor = self.color.randomElement() ?? .black
        }
    }
    
    private func animated(view: UIView, floatX: CGFloat, floatY: CGFloat, color: UIColor, transform: CGAffineTransform) {
        UIView.animate(
            withDuration: 2,
            delay: 1,
            options: [
                .curveEaseInOut,
                .repeat
            ]
        ) {
            view.center = CGPoint(
                x: floatX,
                y: floatY
            )
            view.backgroundColor = color
            view.transform = transform
        }
    }
    
    private func makeImageView(rect: CGRect, superView: UIView, arrayImage: [UIImage]) {
        let view = UIImageView(frame: rect)
        view.backgroundColor = .clear
        superView.addSubview(view)
        
        view.animationImages = arrayImage
        view.startAnimating()
        self.movement(view: view, option: .curveLinear)
    }
}
