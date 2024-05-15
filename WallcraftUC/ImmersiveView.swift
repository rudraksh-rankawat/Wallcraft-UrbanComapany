//
//  ImmersiveView.swift
//  WallcraftUC
//
//  Created by Rudraksh Rankawat on 13/05/24.
//

import SwiftUI
import RealityKit
import RealityKitContent
import ARKit

struct ImmersiveView: View {
    
    let session = ARKitSession()
    let planeData = PlaneDetectionProvider(alignments: [.horizontal, .vertical])
    
    @State private var rootEntity = Entity()
    @State private var planeAnchors: [UUID: PlaneAnchor] = [:]
    @State private var entityMap: [UUID: Entity] = [:]
    
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(scene)
                
                Task {
                    try await session.run([planeData])
                    
                    for await update in planeData.anchorUpdates {
                        if update.anchor.classification == .window {
                            // Skip planes that are windows.
                            continue
                        }
                        switch update.event {
                        case .added, .updated:
                            await updatePlane(update.anchor)
                        case .removed:
                            await removePlane(update.anchor)
                        }
                        
                    }
                }
            }
        }
        
        

        
    }
    
    @MainActor
    func updatePlane(_ anchor: PlaneAnchor) async {
        if planeAnchors[anchor.id] == nil {
            // Add a new entity to represent this plane.
            let entity = ModelEntity(mesh: .generateText(anchor.classification.description))
            entityMap[anchor.id] = entity
            rootEntity.addChild(entity)
        }
        
        entityMap[anchor.id]?.transform = Transform(matrix: anchor.originFromAnchorTransform)
        planeAnchors[anchor.id] = anchor
    }
    
    @MainActor
    func removePlane(_ anchor: PlaneAnchor) async {
        entityMap[anchor.id]?.removeFromParent()
        entityMap.removeValue(forKey: anchor.id)
        planeAnchors.removeValue(forKey: anchor.id)
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}


//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//struct ImmersiveView: View {
//    var body: some View {
//        RealityView { content in
//            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
//                content.add(immersiveContentEntity)
//                
//                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
//                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
//                immersiveContentEntity.components.set(iblComponent)
//                immersiveContentEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: immersiveContentEntity))
//            }
//        }
//    }
//}
//
//#Preview {
//    ImmersiveView()
//        .previewLayout(.sizeThatFits)
//}
