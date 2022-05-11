//
//  ContentView.swift
//  FinalPro
//
//  Created by Christy Ye on 4/12/22.
//

import SwiftUI
import RealityKit
import ARKit
import SDWebImageSwiftUI

struct ContentView : View {
	
	var images: [String] = ["icon","4.jpg", "5.jpg", "6.jpg"]
	
	var title: [String] = ["Welcome to Luft!", "STEP 1.", "STEP 2.","STEP 3."]
	var description: [String] = ["Luft is a mobile AR sound installation that invites users to create a collaborative, spatial sound experience.  Groups as small as three can create their own musical experience by interacting with virtual balloons that each contain musical material. Done in a group, this creates a spatialized piece of music that is unique each time you perform it.",
								 "Participants should spread out and start 4-6 feet apart. Make sure that the volume is turned up all the way on your phone.",
								 "Move through the installation and tap on the balloons to start making music.",
								 "The experience lasts until all players find the “Easter egg” balloon."]
	
    var body: some View {
		NavigationView{
			VStack{
				TabView{
					ForEach(Array(zip(images.indices, images)), id: \.0){ index, image in
						ScrollView{
						VStack{
							if (index == 0){
								 AnimatedImage(url: Bundle.main.url(forResource: "AnimatedLogo", withExtension: "gif")!)
									.playbackMode(.normal)
															.resizable()
															.scaledToFit()
							}
							else{
							Image(uiImage: UIImage(named: image)!)
								.resizable()
								.scaledToFit()
							}
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
		let text = UILabel(frame: CGRect(x: UIScreen.main.bounds.width, y: 0, width: 400, height: 150))
		let message = "Please wait for experience to load"
		text.text = message
		arView.addSubview(text)
		
		Luftwithsoundandeasteregg.loadSceneAsync(completion: { (result) in
			do{
				let boxAnchor = try Luftwithsoundandeasteregg.loadScene()
				arView.scene.anchors.append(boxAnchor)
				
				switch result{
					case.success(_):
						text.text = ""
				case.failure(let error):
					print(error)
				}
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
