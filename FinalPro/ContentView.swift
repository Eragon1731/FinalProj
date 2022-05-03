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
	
	var images: [String] = ["icon","4.jpg", "5.jpg", "6.jpg"]
	
	var title: [String] = ["Welcome to Luft!", "STEP 1.", "STEP 5.","STEP 6."]
	var description: [String] = ["Luft is a mobile AR experience that invites you to make your own music, through interacting with virtual balloons, each containing a unique sound.\n\nThe goal of this project is to encourage a user-system interaction by engaging users in a mobile-driven tour of a soundspace. This project also hopes to encourage user-user interactions that explore different possibilities of music-making.", "Read the instructions before the actual experience.", "Tap on the balloons to start making your music.", "Surround yourself with other users, and your devices will come together in a symphony!"]
	
    var body: some View {
		NavigationView{
			VStack{
				TabView{
					ForEach(Array(zip(images.indices, images)), id: \.0){ index, image in
						ScrollView{
						VStack{
							Image(uiImage: UIImage(named: image)!)
								.resizable()
								.scaledToFit()
								
							Spacer().frame( height: 40)
							Text(title[index]).font(.title)
							Text(description[index])
							Spacer().frame( height: 40)
						}
						}
					}
				}
				.padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
				.tabViewStyle(.page)
				.indexViewStyle(.page(backgroundDisplayMode: .always))
				Spacer()
				NavigationLink(destination:{ ARViewContainer().edgesIgnoringSafeArea(.all) }, label: { Text("START")}).font(.title)
				Spacer()
			}
			
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
