# WallCraft by UrbanCompany

## MVP: https://youtu.be/HywXOYlQGvA
## Introduction
This Technical Requirements Document (TRD) outlines the proposed technical approach for developing a wall panel visualiser application. The application enables UrbanCompany customers to visualize and select wall panel designs within their homes using augmented reality (AR) and mixed reality (MR). The solution will leverage the VisionOS SDK for core AR functionalities, including wall detection, panel placement, and real-world occlusion.

## System Overview
The proposed system will function as a standalone application for Apple Vision Pro. Key components include:

### Apple Vision Pro Application (Swift)
- Manages all aspects of the visualisation experience.

### VisionOS SDK
- Provides capabilities for spatial understanding, wall plane detection, surface mapping, and anchoring of virtual content.

### Apple RealityKit
- Renders and overlays selected wall panel designs onto detected surfaces.

### SwiftUI
- Develops the visual interface elements of the visualiser.

### Computer Vision Library (e.g., OpenCV)
- Enhances visual realism if VisionOS SDK capabilities are insufficient.

### The Cloud Backend (Optional)
- Provides real-time pricing, updates customer details, and allows remote specialists to assist with complex visualizations.

## Technical Requirements

### Functional Requirements

#### Focus Area: Wall Detection
- **FR1**: Detect vertical wall surfaces within the user's environment with a minimum accuracy of +/- 5cm.
- **FR2**: Detect walls composed of common materials (drywall, plaster, brick, wood panelling).
- **FR3**: Function under various indoor lighting conditions.
- **FR4**: Identify and exclude windows, doorways, and large openings from wall detection.
- **FR5**: Optionally detect mounted objects on walls to enhance occlusion accuracy.

#### Focus Area: Panel Catalog
- **FR6**: Access a wall panel catalog containing 3D models, high-resolution textures, and associated metadata.
- **FR7**: Searchable catalog with filters for style, material composition, color, and price range.
- **FR8**: Enable staff to select and preview different panel designs on detected walls.

#### Focus Area: AR Visualization
- **FR9**: Render selected panel design onto detected walls with accurate scaling and perspective.
- **FR10**: Adjust the virtual panel's appearance to match the room's ambient lighting.
- **FR11**: Permit staff to reposition or resize the panel overlay for customization.
- **FR12**: Enable viewing a selected panel design from multiple angles and distances.

#### Focus Area: Object Occlusion
- **FR13**: Create the illusion that virtual wall panels exist behind physical objects.
- **FR14**: Prioritize realistic occlusion for large, common furniture items.
- **FR15**: Optionally incorporate advanced detection and occlusion for smaller objects.

### Non-Functional Requirements

#### Focus Area: Performance
- **NFR1**: Initial scene setup within 8-10 seconds.
- **NFR2**: Maintain a minimum frame rate of 30 FPS during AR visualization.
- **NFR3**: Response time for user gestures or UI interactions to be less than 0.5 seconds.

#### Focus Area: Compatibility
- **NFR4**: Explicitly designed for Apple Vision Pro.
- **NFR5**: Tested for compatibility with future VisionOS updates.

#### Focus Area: Battery Impact
- **NFR6**: Minimize battery drain, with estimated continuous usage time of at least 1.5 hours.

#### Focus Area: Security
- **NFR7**: Encrypt any temporarily stored customer data.
- **NFR8**: Use secure protocols for communication between the application and the cloud backend.

## Technology Stack

### Programming Languages
- **Swift**: Primary language for building user interfaces, application logic, and leveraging VisionOS and ARKit.

### Frameworks
- **SwiftUI**: Constructs the Staff UI of the application.
- **RealityKit**: Handles 3D content rendering, scene composition, and AR experience management.
- **VisionOS (ARKit, Scene Reconstruction)**: Provides plane detection, anchoring, and scene reconstruction.

### Development Tools
- **Xcode**: IDE for building and debugging applications for Apple platforms.
- **VisionOS SDK**: Provides necessary APIs, simulators, and tools for developing AR experiences.

## Algorithm Design (Pseudocode)

### Setup
1. **Project Creation and Dependencies**
   - Create a new Xcode project targeting the VisionOS platform.
   - Include the VisionOS SDK.

2. **ARKit Session Configuration**
   - Initialize ARKitSession.
   - Enable world tracking if necessary.

3. **Plane Detection Setup**
   - Instantiate a PlaneDetectionProvider.
   - Configure to detect vertical planes.

4. **Scene Reconstruction Setup (Optional)**
   - Initialize a SceneReconstructionProvider for advanced occlusion.

### Wall Detection and Plane Overlay
1. **Continuous Detection Loop**
   - Process updates from PlaneDetectionProvider.

2. **New Plane Handling**
   - Extract plane data and create panel material and model.
   - Position and orient the panel.

3. **Plane Update Handling**
   - Track and modify panel-plane associations.

4. **Plane Removal Handling**
   - Remove corresponding panel entity from the scene.

### Occlusion
1. **Initialize SceneReconstructionProvider**
   - Create and add the provider to ARKit session.

2. **Handling Updates**
   - Process updates from sceneReconstructionProvider.

3. **Occlusion Analysis**
   - Compare panel positions with mesh vertices for occlusion.

4. **Visual Adjustment**
   - Use simple masking or advanced shaders for occlusion.

## Testing and Evaluation

### Areas to Address
- **Accuracy**: Wall detection reliability, panel placement precision, occlusion effectiveness.
- **Performance**: Frame rate, loading times, battery impact.
- **Edge Cases**: Complex wall shapes, moving objects, extreme lighting.

### Testing Methodology
- **Unit Tests**: For isolated logic components.
- **Automated UI Tests**: Simulate user interaction.
- **Manual Testing**: Thorough real-world testing.

## Challenges and Potential Risks
- **Occlusion Accuracy**: Managing stakeholder expectations.
- **Real-World Lighting**: Testing in various environments.
- **Performance vs. Features**: Balancing visual fidelity with smooth performance.
- **Hardware Limitations**: Understanding device capabilities and limitations.
