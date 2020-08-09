//
//  BorderedButton.swift
//  Shengji
//
//  Created by Kevin Peng on 2020-08-09.
//

import UIKit

final class BorderedButton: UIButton {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.defaultGray.setStroke()
        path.stroke()
        let contentRect = rect.insetBy(dx: 8, dy: 8)
        super.draw(contentRect)
    }
}
