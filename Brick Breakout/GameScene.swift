import SpriteKit

let BallCategoryName = "ball"
let PaddleCategoryName = "paddle"
let BlockCategoryName = "block"
let BlockNodeCategoryName = "blockNode"
let BallCategory   : UInt32 = 0x1 << 0 // 00000000000000000000000000000001
let BottomCategory : UInt32 = 0x1 << 1 // 00000000000000000000000000000010
let BlockCategory  : UInt32 = 0x1 << 2 // 00000000000000000000000000000100
let PaddleCategory : UInt32 = 0x1 << 3 // 00000000000000000000000000001000




class GameScene: SKScene, SKPhysicsContactDelegate {
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        //make it so the ball doesn't fall
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //set friction for this equal to zero, don't want ball to slow
        borderBody.friction = 0
        self.physicsBody = borderBody
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        let bottomRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 1)
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFromRect: bottomRect)
        addChild(bottom)
        let paddle = childNodeWithName(PaddleCategoryName) as SKSpriteNode!
        
        let ball = childNodeWithName(BallCategoryName) as SKSpriteNode!
        bottom.physicsBody!.categoryBitMask = BottomCategory
        ball.physicsBody!.categoryBitMask = BallCategory
        paddle.physicsBody!.categoryBitMask = PaddleCategory
        ball.physicsBody!.contactTestBitMask = BottomCategory
        ball.physicsBody!.applyImpulse(CGVectorMake(10, -10))}
        var isFingerOnPaddle = false
        override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch!
        var touchLocation = touch.locationInNode(self)
        if let body = physicsWorld.bodyAtPoint(touchLocation) {
            if body.node!.name == PaddleCategoryName {
                println("Began touch on paddle")
                isFingerOnPaddle = true
                
                }
            }
        }

override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
    // Has use touched
    if isFingerOnPaddle {
        // Where did the fucker touch
        var touch = touches.anyObject() as UITouch!
        var touchLocation = touch.locationInNode(self)
        var previousLocation = touch.previousLocationInNode(self)
        
        // What finna be the node
        var paddle = childNodeWithName(PaddleCategoryName) as SKSpriteNode!
        
        // What is new position on the finna x axis
        var paddleX = paddle.position.x + (touchLocation.x - previousLocation.x)
        
        // make it so it is limited
        paddleX = max(paddleX, paddle.size.width/2)
        paddleX = min(paddleX, size.width - paddle.size.width/2)
        
        // make it so that the position is updated
    paddle.position = CGPointMake(paddleX, paddle.position.y)
    }
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        isFingerOnPaddle = false
        }
    func didBeginContact(contact: SKPhysicsContact) {
        // Make variables for the two physics bodies
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        // Store bodies in a lower category
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA

        }

            }
        }


        



