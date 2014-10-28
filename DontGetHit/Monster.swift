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
    var type:NSString = ""
    var position:CGPoint
    var frame:CGRect
    
    init(type: Int, frame:CGRect) {
        self.frame = frame
        self.type = GameConstants.monsterCodes[type]
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
        
        println("Spawned new \(self.type) at (\(self.position.x), \(self.position.y))")
    }
    
    func changePosition() {
        switch self.type {
        case GameConstants.monsterCodes[0]:
            print("Move \\: ")
            moveSlash()
            break
            
        case GameConstants.monsterCodes[1]:
            print("Move L: ")
            moveL()
            break
            
        case GameConstants.monsterCodes[2]:
            print("Move Q: ")
            moveQ()
            break
            
        default:
            print("Default: ")
            break
        }
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
    
    func moveSlash() {
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
    
    func moveL() {
        var newX:CGFloat, newY:CGFloat
        
        if doMoveRight() {
            newX = addToXPosition(
                {(x:CGFloat) -> CGFloat in return x + (GameConstants.charWidth + GameConstants.charMargin) * 3 },
                x: self.position.x)
        } else {
            newX = addToXPosition(
                {(x:CGFloat) -> CGFloat in return x - (GameConstants.charWidth + GameConstants.charMargin) * 3 },
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
    
    func moveQ() {
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