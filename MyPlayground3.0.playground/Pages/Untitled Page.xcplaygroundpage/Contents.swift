//: A SpriteKit based Playground
/*:
 
Haverao várias acoes e situações de maldade que voce presencia e continuará presenciando na tua vida. Felizmente, também haverão várias situações e gestos de bondade que passam por nós, e que muitas vezes acabam sendo ignoradas.
 
Cabe a nós ""desviar" da maldade e capturar as coisas boas que acontecem em nossas vidas, portanto, filtrar as informacoes conforme nos convém.

 Tentando mostrar essa ideia de uma maneira ludica, foi criado esse Playground. Assim, o teu objetivo é capturar os anjinhos e desviar dos diabinhos.
 
 Os anjinhos representam a bondade e os diabinhos representam a maldade.
 Assim, voce tem que capturar os 😇 e correr dos 😈.
 
 */



import PlaygroundSupport
import SpriteKit



// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
