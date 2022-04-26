//
//  ContentView.swift
//  FinalPro
//
//  Created by Christy Ye on 4/12/22.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
	
	var preloadContents: [String] = ["", ""]
	var title: [String] = ["Welcome to Luft!", ""]
	var description: [String] = ["Luft is a mobile AR experience that invites you to make your own music, through interacting with virtual balloons, each containing a unique sound.\n\nThe goal of this project is to encourage a user-system interaction by engaging users in a mobile-driven tour of a soundspace. This project also hopes to encourage user-user interactions that explore different possibilities of music-making."]
	
    var body: some View {
		NavigationView{
			TabView{
				ForEach(Array(zip(preloadContents.indices, preloadContents)), id: \.0){ index, contentName in
					VStack{
						
						Text(title[index]).font(.title)
						Text(description[index])
					}
					Spacer().frame( height: 40)
					
				}.padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
				
			}
			NavigationLink(destination:{ ARViewContainer().edgesIgnoringSafeArea(.all) }, label: { Text("START")}).font(.title)
		}
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
		Luftwithsound.loadSceneAsync(completion: { (result) in
			do{
				let boxAnchor = try Luftwithsound.loadScene()

				arView.scene.anchors.append(boxAnchor)
			}
			catch{
				print("Error! Cannot load")
			}
		})
        
		arView.addCoaching()
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

extension ARView: ARCoachingOverlayViewDelegate {
  func addCoaching() {
	// Create a ARCoachingOverlayView object
	let coachingOverlay = ARCoachingOverlayView()
	// Make sure it rescales if the device orientation changes
	coachingOverlay.autoresizingMask = [
	  .flexibleWidth, .flexibleHeight
	]
	self.addSubview(coachingOverlay)
	// Set the Augmented Reality goal
	coachingOverlay.goal = .horizontalPlane
	// Set the ARSession
	coachingOverlay.session = self.session
	// Set the delegate for any callbacks
	coachingOverlay.delegate = self
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
