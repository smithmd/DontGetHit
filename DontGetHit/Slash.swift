//
//  slash.swift
//  DontGetHit
//
//  Created by Smith, Michael D. on 10/28/14.
//  Copyright (c) 2014 Smith, Michael D. All rights reserved.
//

import Foundation

class Slash: Monster {
    var player:CGPoint = CGPoint(x:0,y:0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label = "\\"
        precedence = 1
        println("Spawned new \(super.label) at (\(self.position.x), \(self.position.y))")
    }
    
    override func changePosition(playerPosition:CGPoint) {
        player = playerPosition
        
        print("Move \\: ")
        move()
    }
    
    override func doMoveRight() -> Bool {
        let chance = arc4random_uniform(100)
        
        if self.position.x > player.x {
            // right of player
            if chance <= 10 {
                // 25% chance monster moves right
                return true
            } else {
                return false
            }
        } else {
            // left of player or in same column as player
            if chance < 90 {
                // 65% chance to move right
                return true
            } else {
                return false
            }
        }
    }
    
    override func doMoveUp() -> Bool {
        var chance = arc4random_uniform(100)
        
        if self.position.y > player.y {
            // above player
            if chance <= 10 {
                return true // move up
            } else {
                return false // move down
            }
        } else {
            // below player
            if chance < 90 {
                return true
            } else {
                return false
            }
        }
    }
    
    func move() {
        var newX:CGFloat, newY:CGFloat
        if doMoveRight() {
            newX = addToXPosition(
                {(x:CGFloat) -> CGFloat in return x + (GameConstants.charWidth + GameConstants.charMargin) * 1},
                x: self.position.x)
        } else {
            newX = addToXPosition(
                {(x:CGFloat) -> CGFloat in return x - (GameConstants.charWidth + GameConstants.charMargin) * 1},
                x: self.position.x)
        }
        
        if doMoveUp() {
            newY = addToYPosition(
                {(y:CGFloat) -> CGFloat in return y + (GameConstants.charHeight + GameConstants.charMargin) * 1 },
                y: self.position.y)
        } else {
            newY = addToYPosition(
                {(y:CGFloat) -> CGFloat in return y - (GameConstants.charHeight + GameConstants.charMargin) * 1 },
                y: self.position.y)
        }
        
        if GameFunctions.newPositionIsOnScreen(self.position.x, oldY: self.position.y, newX: newX, newY: newY, frame: self.frame) {
            self.position.x = newX
            self.position.y = newY
        }
    }
}