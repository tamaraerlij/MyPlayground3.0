import Foundation
import PlaygroundSupport
import SpriteKit


public class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode!
    private var spinnyNode : SKShapeNode!
    var Personagem : SKNode!
    var Anjo : SKNode!
    var Inimigo : SKNode!
    var vida1 : SKNode!
    var vida2 : SKNode!
    var vida3 : SKNode!
    var vidas : Int = 3
    var gameOver : SKNode!
    var start : SKNode!
    
    var pontos : Int = 0
    var pontosImagem : SKLabelNode!
    var pontosFinais : SKLabelNode!

    var foiBatidoPeloAnjo = false
    
    var jaComecouOJogo = false


    
    public override func sceneDidLoad() {
        
        vida1 = childNode(withName: "//vida1")
        vida2 = childNode(withName: "//vida2")
        vida3 = childNode(withName: "//vida3")
        
        pontosImagem = childNode(withName: "//pontos") as! SKLabelNode
        pontosFinais = childNode(withName: "//pontosFinais") as! SKLabelNode

        Personagem = childNode(withName: "//Personagem")
        Personagem.physicsBody?.categoryBitMask = 0x1
        Personagem.physicsBody?.collisionBitMask = 0x1 << 2
        Personagem.physicsBody?.contactTestBitMask = 0x1 << 1 + 0x1 << 2
        
        
        
        Anjo = childNode(withName: "//Anjo")
        Anjo.position = CGPoint(x: 0, y: size.height / 2)
        
        
        Inimigo = childNode(withName: "//Inimigo")
        Inimigo.position = CGPoint(x: 200, y: size.height / 2)
        
        
        
        gameOver = childNode(withName: "//gameOver")
        gameOver.alpha = 0
        
        start = childNode(withName: "//start")
        
        self.physicsWorld.contactDelegate = self
        
    }
    public override func didMove(to view: SKView) {
        
        
         

    }
    
    @objc static public override var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        jaComecouOJogo = true

    }
    
    func touchMoved(toPoint pos : CGPoint) {
        Personagem.position = pos
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    public func didBegin(_ contact: SKPhysicsContact) {
//        print(contact.bodyB.node?.name)
        
        
        let contatoFoiBatido:String! = contact.bodyB.node?.name as! String
        
        
        if(contatoFoiBatido == "Inimigo"){
            vidas -= 1
            print(vidas)
        }
        
        if(contatoFoiBatido == "Anjo"){
            pontos += 1
            foiBatidoPeloAnjo = true
            
        }
        
        
//        print("Here")
    }

    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        if(jaComecouOJogo){
            // Called before each frame is rendered
            Anjo.position.y -= 10
            Inimigo.position.y -= 12
            var metadeDaTela = size.width / 2
            let range: ClosedRange<CGFloat> = -metadeDaTela...metadeDaTela

            //queda anjo
            if (Anjo.position.y <= (size.height / -2)){
                Anjo.position = CGPoint(x: CGFloat.random(in: range) , y: size.height / 2)
            }
            
            if (Inimigo.position.y <= (size.height / -2)){
                Inimigo.position = CGPoint(x: CGFloat.random(in: range), y: size.height / 2)
            }
            
            
            
            
            //vidas
            if(vidas == 2 && !vida3.isHidden){
                Inimigo.position = CGPoint(x: CGFloat.random(in: range), y: size.height / 2)
                vida3.isHidden = true
                
            }
            
            if(vidas == 1 && !vida2.isHidden){
                Inimigo.position = CGPoint(x: CGFloat.random(in: range), y: size.height / 2)
                vida2.isHidden = true
            }
            
            if(vidas == 0 && !vida1.isHidden){
                Inimigo.position = CGPoint(x: CGFloat.random(in: range), y: size.height / 2)
                vida1.isHidden = true
                
                gameOver.run(SKAction.fadeAlpha(by: 1, duration: 1))
                pontosFinais.text = String(pontos)
                pontosFinais.isHidden = false

                
    //            gameOver.isHidden = false
                
            }
            
            if(pontos) > 10 {
                
                Inimigo.position.y -= 10
            }
            
            
            if(foiBatidoPeloAnjo){
                Anjo.position = CGPoint(x: CGFloat.random(in: range) , y: size.height / 2)
                
                foiBatidoPeloAnjo = false
            }
            
        
            start.alpha = 0
            
//            start.run(SKAction.fadeAlpha(by: 0, duration: 0))
//            start.run(SKAction.fadeAlpha(by: 0, duration: 1))
        }
        pontosImagem.text = String(pontos)
        
        
    }
}
