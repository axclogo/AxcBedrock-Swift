//
//  AxcConstraintMakerExtendable.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit


public class AxcConstraintMakerExtendable: AxcConstraintMakerRelatable {
    public var left: AxcConstraintMakerExtendable {
        description.attributes += .left
        return self
    }
    
    public var top: AxcConstraintMakerExtendable {
        description.attributes += .top
        return self
    }
    
    public var bottom: AxcConstraintMakerExtendable {
        description.attributes += .bottom
        return self
    }
    
    public var right: AxcConstraintMakerExtendable {
        description.attributes += .right
        return self
    }
    
    public var leading: AxcConstraintMakerExtendable {
        description.attributes += .leading
        return self
    }
    
    public var trailing: AxcConstraintMakerExtendable {
        description.attributes += .trailing
        return self
    }
    
    public var width: AxcConstraintMakerExtendable {
        description.attributes += .width
        return self
    }
    
    public var height: AxcConstraintMakerExtendable {
        description.attributes += .height
        return self
    }
    
    public var centerX: AxcConstraintMakerExtendable {
        description.attributes += .centerX
        return self
    }
    
    public var centerY: AxcConstraintMakerExtendable {
        description.attributes += .centerY
        return self
    }
    
    public var lastBaseline: AxcConstraintMakerExtendable {
        description.attributes += .lastBaseline
        return self
    }
    public var firstBaseline: AxcConstraintMakerExtendable {
        description.attributes += .firstBaseline
        return self
    }
    public var leftMargin: AxcConstraintMakerExtendable {
        description.attributes += .leftMargin
        return self
    }
    public var rightMargin: AxcConstraintMakerExtendable {
        description.attributes += .rightMargin
        return self
    }
    public var topMargin: AxcConstraintMakerExtendable {
        description.attributes += .topMargin
        return self
    }
    public var bottomMargin: AxcConstraintMakerExtendable {
        description.attributes += .bottomMargin
        return self
    }
    public var leadingMargin: AxcConstraintMakerExtendable {
        description.attributes += .leadingMargin
        return self
    }
    public var trailingMargin: AxcConstraintMakerExtendable {
        description.attributes += .trailingMargin
        return self
    }
    public var centerXWithinMargins: AxcConstraintMakerExtendable {
        description.attributes += .centerXWithinMargins
        return self
    }
    public var centerYWithinMargins: AxcConstraintMakerExtendable {
        description.attributes += .centerYWithinMargins
        return self
    }
    
    public var edges: AxcConstraintMakerExtendable {
        description.attributes += .edges
        return self
    }
    public var horizontalEdges: AxcConstraintMakerExtendable {
        description.attributes += .horizontalEdges
        return self
    }
    public var verticalEdges: AxcConstraintMakerExtendable {
        description.attributes += .verticalEdges
        return self
    }
    public var directionalEdges: AxcConstraintMakerExtendable {
        description.attributes += .directionalEdges
        return self
    }
    public var directionalHorizontalEdges: AxcConstraintMakerExtendable {
        description.attributes += .directionalHorizontalEdges
        return self
    }
    public var directionalVerticalEdges: AxcConstraintMakerExtendable {
        description.attributes += .directionalVerticalEdges
        return self
    }
    public var size: AxcConstraintMakerExtendable {
        description.attributes += .size
        return self
    }
    public var margins: AxcConstraintMakerExtendable {
        description.attributes += .margins
        return self
    }
    public var directionalMargins: AxcConstraintMakerExtendable {
        description.attributes += .directionalMargins
        return self
    }
    public var centerWithinMargins: AxcConstraintMakerExtendable {
        description.attributes += .centerWithinMargins
        return self
    }
    
}
