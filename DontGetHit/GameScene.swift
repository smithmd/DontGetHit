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

var scoreCounter:Int = 0
var gameOver:Bool = false

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
        _charLabel.alpha = 0.5
        _charLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        _charLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Bottom
        self.addChild(_charLabel)
    }
    
    override func keyDown(theEvent: NSEvent) {
        if !gameOver {
            if !_lblGameTitle.hidden {
                _lblGameTitle.hidden = true
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
                // _lblGameTitle.text = "keycode = \(theEvent.keyCode)"
                break
            }
        }
    }
    
    func triggerGameEvents() {
        moveMonsters()
        spawnMonster()
        checkForCollisions()
        incrementScore()
    }
    
    func spawnMonster() {
        let monster:Monster = getRandomMonster()
        
        _monsterArray.append(monster)
        
        let lbl:SKLabelNode = SKLabelNode(fontNamed: "Courier")
        lbl.fontSize = GameConstants.charHeight
        lbl.text = monster.label as String
        lbl.position = monster.position
        lbl.fontColor = NSColor(
            red: GameFunctions.getRandomCGFloat(),
            green: GameFunctions.getRandomCGFloat(),
            blue: GameFunctions.getRandomCGFloat(),
            alpha: 1)
        lbl.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        lbl.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Bottom
        self.addChild(lbl)
        
        _monsterLabelArray.append(lbl)
        _lblGameTitle.text = "\(lbl.text) @ \(lbl.position)"
        print("")
    }
    
    func getRandomMonster() -> Monster {
        let rand = Int(arc4random_uniform(3))
        
        if rand == 0 {
            return L(frame: self.frame) as Monster
        } else if rand == 1 {
            return Slash(frame: self.frame) as Monster
        } else {
            return Q(frame: self.frame) as Monster
        }
    }
    
    func moveMonsters() {
        for (index, m): (Int, Monster) in _monsterArray.enumerate() {
            m.changePosition(_charLabel.position)
            _monsterLabelArray[index].position = m.position
        }
    }
    
    func checkForCollisions() {
        
        for (i, m): (Int, Monster) in _monsterArray.enumerate() {
            print("@:\(_charLabel.position) \(m.label):\(m.position)")
            if (_charLabel.position == m.position) {
                print("********")
            }
            if _charLabel.position == m.position {
                gameOver = true
                _lblGameTitle.text = "You Got Hit! Your score was \(scoreCounter)"
                _lblGameTitle.hidden = false
            }
            for (j, n): (Int, Monster) in _monsterArray.enumerate() {
                // check to make sure monsters are different objects
                if m.uuid.UUIDString != n.uuid.UUIDString
                    && m.position == n.position
                {
                    if m.precedence > n.precedence {
                        print("\tMonsters collide… Removing a \(n.label)")
                        _monsterArray.removeAtIndex(j)
                    } else {
                        print("\tMonsters collide… Removing a \(m.label)")
                        _monsterArray.removeAtIndex(i)
                        break
                    }
                }
//                println("i: \(i) j: \(j)")
            }
        }
        print("\tMonsters remaining: \(_monsterArray.count)\n")
    }
    func incrementScore() {
        if !gameOver {
            ++scoreCounter
        } else {
            print("\tGame Over")
            print("** Score: \(scoreCounter) **");
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
