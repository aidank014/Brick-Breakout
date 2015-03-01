import SpriteKit

let GameOverLabelCategoryName = "gameOverLabel"

class GameOverScene: SKScene {
    var gameWon : Bool = false {
        // 1.
        didSet {
            let gameOverLabel = childNodeWithName(GameOverLabelCategoryName) as SKLabelNode!
            gameOverLabel.text = "Game Over"
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if let view = view {
            // 2.
            let gameScene = GameScene.unarchiveFromFile("GameScene") as GameScene!
            view.presentScene(gameScene)
        }
    }
}