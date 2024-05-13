////
////  ImmersiveView.swift
////  WallcraftUC
////
////  Created by Rudraksh Rankawat on 13/05/24.
////
//
//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//struct ImmersiveView: View {
//    var body: some View {
//        RealityView { content in
//            // Add the initial RealityKit content
//            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
//                content.add(scene)
//            }
//        }
//    }
//}
//
//#Preview {
//    ImmersiveView()
//        .previewLayout(.sizeThatFits)
//}


import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)
                
                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                immersiveContentEntity.components.set(iblComponent)
                immersiveContentEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: immersiveContentEntity))
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
