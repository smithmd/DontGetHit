//
//  GameScene.swift
//  DontGetHit
//
//  Created by Smith, Michael D. on 10/24/14.
//  Copyright (c) 2014 Smith, Michael D. All rights reserved.
//

import SpriteKit

let _charLabel = SKLabelNode(fontNamed: "Courier")
let _lblGameTitle = SKLabelNode(fontNamed:"Courier")

// counters and game state
var _monsterArray:[Monster] = []
var _monsterLabelArray:[SKLabelNode] = []

var _constants = GameConstants()

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        _lblGameTitle.text = "Don't Get Hit!";
        _lblGameTitle.fontSize = GameConstants.charHeight * 2;
        _lblGameTitle.position = CGPoint(x: CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) + GameConstants.charMargin - (GameConstants.charHeight * 2))
        
        self.addChild(_lblGameTitle)
        
        _charLabel.fontSize = GameConstants.charHeight;
        _charLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        _charLabel.text = "@"
        _charLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        _charLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Bottom
        self.addChild(_charLabel)
    }
    
    override func keyDown(theEvent: NSEvent) {
        if !_lblGameTitle.hidden {
//            _lblGameTitle.hidden = true
        }
       
        switch Int(theEvent.keyCode) {
        case 49:
            //space
            triggerGameEvents()
            break
        case 123:
            // left
            triggerGameEvents()
            _charLabel.position.x = _charLabel.position.x - GameConstants.charMargin - GameConstants.charWidth
            break
        case 124:
            // right
            triggerGameEvents()
            _charLabel.position.x = _charLabel.position.x + GameConstants.charMargin + GameConstants.charWidth
            break
        case 125:
            // down
            triggerGameEvents()
            _charLabel.position.y = _charLabel.position.y - GameConstants.charMargin - GameConstants.charHeight
            break
        case 126:
            // up
            triggerGameEvents()
            _charLabel.position.y = _charLabel.position.y + GameConstants.charMargin + GameConstants.charHeight
            break
        default:
            _lblGameTitle.text = "keycode = \(theEvent.keyCode)"
            break
        }
    }
    
    func triggerGameEvents() {
        moveMonsters()
        spawnMonster()
    }
    
    func spawnMonster() {
        let monster:Monster = Monster(type:Int(arc4random_uniform(3)), frame: self.frame)
        _monsterArray.append(monster)
        
        let lbl:SKLabelNode = SKLabelNode(fontNamed: "Courier")
        lbl.fontSize = GameConstants.charHeight
        lbl.text = monster.type
        lbl.position = monster.position
        lbl.fontColor = NSColor(
            red: GameFunctions.getRandomCGFloat(),
            green: GameFunctions.getRandomCGFloat(),
            blue: 1,
            alpha: 1)
        lbl.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        lbl.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Bottom
        self.addChild(lbl)
        
        _monsterLabelArray.append(lbl)
        _lblGameTitle.text = "\(lbl.text) @ \(lbl.position)"
        println()
    }
    
    func moveMonsters() {
        for (index:Int, m:Monster) in enumerate(_monsterArray) {
            m.changePosition()
            _monsterLabelArray[index].position = m.position
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
