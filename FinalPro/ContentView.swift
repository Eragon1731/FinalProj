//
//  ContentView.swift
//  FinalPro
//
//  Created by Christy Ye on 4/12/22.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
		NavigationView{
		VStack{
			Text("Welcome").font(.title)
			Spacer().frame(height: 40)
			Text("Instructions")
			Text("Add description and steps here")
			
			NavigationLink(destination:{ ARViewContainer().edgesIgnoringSafeArea(.all) }, label: { Text("Go to ARView")})
			}
		}
    }
}






struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
		let boxAnchor = try! BalloonSizeTest250.loadScene()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
