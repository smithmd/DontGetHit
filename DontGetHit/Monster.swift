//
//  Monster.swift
//  DontGetHit
//
//  Created by Smith, Michael D. on 10/24/14.
//  Copyright (c) 2014 Smith, Michael D. All rights reserved.
//

import Foundation
import SpriteKit

class Monster {
    var position:CGPoint
    var frame:CGRect
    var precedence:Int
    
    var label:NSString
    
    var uuid:NSUUID = NSUUID()
    
    init(frame:CGRect) {
        self.frame = frame
        self.label = ""
        
        let maxX = CGRectGetMaxX(frame)
        let maxY = CGRectGetMaxY(frame)
        let spawnOnXAxis = Int(arc4random_uniform(2))
        var x:CGFloat = 0
        var y:CGFloat = 0
        
        if spawnOnXAxis == 1 {
            x = CGFloat(arc4random()) % maxX
            y = arc4random_uniform(2) == 0 ? 0 : maxY
        } else {
            x = arc4random_uniform(2) == 0 ? 0 : maxX
            y = CGFloat(arc4random()) % maxY
        }
        self.position = GameFunctions.getPointInGrid(CGPoint(x: x, y: y), f:frame)
        
        precedence = -1
    }
    
    func changePosition(playerPosition:CGPoint) {
        fatalError("Monster has not overridden this function")
    }
    
    // false == left, true == right
    func doMoveRight() -> Bool {
        return arc4random_uniform(2) == 0 ? true : false
    }
    
    // false == down, true == right
    func doMoveUp() -> Bool {
        return arc4random_uniform(2) == 0 ? true : false
    }
    
    func addToXPosition(move:CGFloat -> CGFloat, x:CGFloat) -> CGFloat {
        return move(x)
    }
    
    func addToYPosition(move:CGFloat -> CGFloat, y:CGFloat) -> CGFloat {
        return move(y)
    }
}