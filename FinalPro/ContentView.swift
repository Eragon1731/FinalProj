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
    var body: some View {
		NavigationView{
			ScrollView{
				VStack{
					Text("Welcome to Luft!").font(.title)
					Spacer().frame(height: 40)
					Text("Project Description").font(.title2)
					Text("Luft is a mobile AR experience that invites you to make your own music, through interacting with virtual balloons, each containing a unique sound.\n\nThe goal of this project is to encourage a user-system interaction by engaging users in a mobile-driven tour of a soundspace. This project also hopes to encourage user-user interactions that explore different possibilities of music-making.")
					Spacer().frame(height: 40)
					Text("Instructions").font(.title2)
					Text("To enjoy this experience, ")
					+ Text("please turn off Silent Mode on your phone and turn up the volume.").fontWeight(.bold)
					Text("\n\nMake sure you are standing in a brightly lit area. Move your phone slowly and point at a flat horizontal surface. When the virtual objects appear, tap them on your phone screen to play with a sound.\n\nTry moving to an area where you can be surrounded by at least 4 people, and enjoy the symphony composed by the different sounds from different devices!")
					
				}.padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
				NavigationLink(destination:{ ARViewContainer().edgesIgnoringSafeArea(.all) }, label: { Text("START")}).font(.title)
			}.padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
			
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
//  // Example callback for the delegate object
//	public func coachingOverlayViewDidDeactivate(
//	_ coachingOverlayView: ARCoachingOverlayView
//  ) {
//	self.addObjectsToScene()
//  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
