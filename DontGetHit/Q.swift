//
//  Q.swift
//  DontGetHit
//
//  Created by Smith, Michael D. on 10/28/14.
//  Copyright (c) 2014 Smith, Michael D. All rights reserved.
//

import Foundation

class Q: Monster {
    var player:CGPoint = CGPoint(x:0,y:0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        precedence = 3
        label = "Q"
        println("Spawned new \(super.label) at (\(self.position.x), \(self.position.y))")
    }
    
    override func changePosition(playerPosition:CGPoint) {
        print("Move Q: ")
        player = playerPosition
        move()
    }
    
    override func doMoveRight() -> Bool {
        var chance = arc4random_uniform(100)
            
        if self.position.x > player.x {
            // right of player
            // 10% chance of going right
            return chance <= 10 ? true : false
        } else {
            // left of player or in same column as player
            // 80% chance of going right
            return chance <= 80 ? true : false
        }
    }
    
    override func doMoveUp() -> Bool {
        var chance = arc4random_uniform(100)
        
        if self.position.y > player.y {
            // above player
            // 15% chance of going up
            return chance <= 15 ? true : false
        } else {
            // below player
            // 90% chance of going up
            return chance < 90 ? true : false
        }
    }
    
    func move() {
        var newX:CGFloat, newY:CGFloat
        
        if doMoveRight() {
            newX = addToXPosition(
                {(x:CGFloat) -> CGFloat in return x + (GameConstants.charWidth + GameConstants.charMargin) * 2 },
                x: self.position.x)
        } else {
            newX = addToXPosition(
                {(x:CGFloat) -> CGFloat in return x - (GameConstants.charWidth + GameConstants.charMargin) * 2 },
                x: self.position.x)
        }
        
        if doMoveUp() {
            newY = addToYPosition(
                {(y:CGFloat) -> CGFloat in return y + (GameConstants.charHeight + GameConstants.charMargin) * 2 },
                y: self.position.y)
        } else {
            newY = addToYPosition(
                {(y:CGFloat) -> CGFloat in return y - (GameConstants.charHeight + GameConstants.charMargin) * 2 },
                y: self.position.y)
        }
        
        if GameFunctions.newPositionIsOnScreen(self.position.x, oldY: self.position.y, newX: newX, newY: newY, frame: self.frame) {
            self.position.x = newX
            self.position.y = newY
        }
    }
}