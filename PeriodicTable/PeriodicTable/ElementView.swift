//
//  ElementView.swift
//  PeriodicTable
//
//  Created by Victor Zhong on 12/21/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import UIKit

class ElementView: UIView {

    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var bgColor: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let view = Bundle.main.loadNibNamed("ElementView", owner: self, options: nil)?.first as? UIView {
            self.addSubview(view)
            view.frame = self.bounds
        }
    }
}
