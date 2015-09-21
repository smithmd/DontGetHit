//
//  GameFunctions.swift
//  DontGetHit
//
//  Created by Smith, Michael D. on 10/27/14.
//  Copyright (c) 2014 Smith, Michael D. All rights reserved.
//

import Foundation

struct GameFunctions {
    
    static func getPointInGrid(point: CGPoint, f:CGRect) -> CGPoint {
        let centerPoint = CGPoint(x: CGRectGetMidX(f), y: CGRectGetMidY(f))
        
        let tmpX = point.x - getXDiff(point.x) + getXDiff(centerPoint.x)
        let tmpY = point.y - getYDiff(point.y) + getYDiff(centerPoint.y)
        
        var alignedX:CGFloat
        var alignedY:CGFloat
        
        if tmpX < getClosestXToLeftEdge(CGRectGetMinX(f), midX: centerPoint.x) {
            alignedX = getClosestXToLeftEdge(CGRectGetMinX(f), midX: centerPoint.x)
        } else if tmpX > getClosestXToRightEdge(CGRectGetMaxX(f), midX: centerPoint.x) {
            alignedX = getClosestXToRightEdge(CGRectGetMaxX(f), midX: centerPoint.x)
        } else {
            alignedX = tmpX
        }
        
        
        if tmpY < getClosestYToBottomEdge(CGRectGetMinY(f), midY: centerPoint.y) {
            alignedY = getClosestYToBottomEdge(CGRectGetMinY(f), midY: centerPoint.y)
        } else if tmpY > getClosestYToTopEdge(CGRectGetMaxY(f), midY: centerPoint.y) {
            alignedY = getClosestYToTopEdge(CGRectGetMaxY(f), midY: centerPoint.y)
        } else {
            alignedY = tmpY
        }
        
        return CGPoint(x:alignedX, y:alignedY)
    }
    
    static func getXDiff(x:CGFloat) -> CGFloat {
        return x % (GameConstants.charWidth + GameConstants.charMargin)
    }
    
    static func getYDiff(y:CGFloat) -> CGFloat {
        return y % (GameConstants.charHeight + GameConstants.charMargin)
    }
    
    // effectively should return 0 + the adjustment for the midpoint
    static func getClosestXToLeftEdge(minX:CGFloat, midX:CGFloat) -> CGFloat {
        return minX + getXDiff(midX)
    }
    
    // returns the maximum X value nudged back onto the grid
    static func getClosestXToRightEdge(maxX:CGFloat, midX:CGFloat) -> CGFloat {
        return maxX - getXDiff(maxX) + getXDiff(midX) - GameConstants.charWidth - GameConstants.charMargin
    }
    
    // effectively should return 0 + the adjustment for the midpoint
    static func getClosestYToBottomEdge(minY:CGFloat, midY:CGFloat) -> CGFloat {
        return minY + getYDiff(midY)
    }
    
    static func getClosestYToTopEdge(maxY:CGFloat, midY:CGFloat) -> CGFloat {
        return maxY - getYDiff(maxY) + getYDiff(midY) - GameConstants.charHeight - GameConstants.charMargin
    }
    
    static func getClosestXToGrid(x:CGFloat, midX:CGFloat) -> CGFloat {
        let midPointAdjustment = getXDiff(midX)
        
        return midPointAdjustment + (x - getXDiff(x))
    }
    
    static func getClosestYToGrid(y:CGFloat, midY:CGFloat) -> CGFloat {
        let midPointAdjustment = getYDiff(midY)
        return midPointAdjustment + (y - getYDiff(y))
    }
    
    static func getRandomCGFloat() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }

    static func newPositionIsOnScreen(oldX:CGFloat, oldY:CGFloat, newX:CGFloat, newY:CGFloat, frame:CGRect) -> Bool {
        if newX > GameFunctions.getClosestXToLeftEdge(CGRectGetMinX(frame), midX: CGRectGetMidX(frame)) &&
            newX < GameFunctions.getClosestXToRightEdge(CGRectGetMaxX(frame), midX: CGRectGetMidX(frame)) &&
            newY > GameFunctions.getClosestYToBottomEdge(CGRectGetMinY(frame), midY: CGRectGetMidY(frame)) &&
            newY < GameFunctions.getClosestYToTopEdge(CGRectGetMaxX(frame), midY: CGRectGetMidY(frame)) {
                
                print("(\(oldX), \(oldY)), (\(newX), \(newY))")
                return true
        } else {
            print("didn't move: (\(oldX), \(oldY))")
            return false
        }
    }
}

struct GameConstants {
    static let charHeight:CGFloat   = 25
    static let charMargin:CGFloat   = 5
    static let charWidth:CGFloat    = 25
}