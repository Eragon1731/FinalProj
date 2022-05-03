//
//  OnboardingView.swift
//  FinalPro
//
//  Created by Christy Ye on 5/2/22.
//

import Foundation
import SwiftUI

struct OnboardingView: View{
	var images: [String] = ["1", "2", "3"]
	var descriptions: [String] = ["","",""]
	
	var body: some View{
		
			TabView{
				ForEach(Array(zip(images, descriptions)), id: \.0){ image, description in
					VStack{
						Image(uiImage: UIImage(named: image)!)
						Spacer().frame(height:20)
						Text(description)
					}
				}
				
			}
			
		
		
	}
}
