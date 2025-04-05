### Communication
Reliable communication is critical to enable the user to configure and adjust operations via app, but more importantly the transferring of data between the mower and the station to ensure real-time analys and diagnostic.
The most reliable solution is using a hybrid approach using Wifi and Lora communicating using mqtt protocol.

#### Wifi
The Wifi communication is best for firmware updates, detailed diagnostics, and high-data transfers.
However it can presents connectivity issues if used when the mower is far away from the router, therefore its function is limited for user-station comunication and when the mower is charging inside the station.

#### LoRa
The LoRa technology is best for long range and battery efficiency communication.  
It is needed due to the dimensions of the garden and possible interference with the obstacles.  
It provides low data rate, but it sufficient for the real-time communication between the station and the mower.

#### Mqtt
It is a lightweight protocol of communication that also supports a publish/subscribe model and offers Quality of Service (QoS) levels to ensure message reliability.

### Orientation and Navigation
Effective navigation is key to ensuring complete and efficient lawn coverage. Several approaches were considered:

Wheel Encoders: Measure rotations to estimate distance traveled.
IMU: Provides data on acceleration and angular velocity to determine orientation.
GPS: Offers absolute positioning but can be unreliable in obstructed environments.
LiDAR and Computer Vision: Enable dynamic mapping and obstacle detection but require significant processing power.
SLAM (Simultaneous Localization and Mapping): Uses sensor fusion to build a map and track position, though at higher complexity and cost.
6.2 Chosen Method: Dead Reckoning with Wheel Encoders and IMU
Strategy:
The primary navigation method employs dead reckoning by fusing data from wheel encoders and an IMU.

Advantages:

Cost-Effective: Utilizes affordable and readily available components.
Self-Contained: Operates independently without reliance on external signals.
Simplicity: Easier integration with the existing control system.
Challenges:

Accumulated Drift: Small measurement errors may compound over time.
Wheel Slippage: Can result in inaccurate distance estimation.
Mitigation: Periodic recalibration or supplemental sensor inputs may be required to maintain accuracy.
6.3 Path Planning: Random vs. Structured Approaches
Random Movement:

Pros: Simplicity and minimal processing overhead.
Cons: Can lead to redundant passes and inefficient energy use.
Structured Coverage (Preferred):

Pros: Follows predetermined patterns (e.g., grid, spiral, parallel lines) to ensure full coverage with minimal redundancy and optimized energy consumption.
Cons: Requires precise positioning and more advanced path-planning algorithms.
6.4 Future Enhancements: AI-Assisted Navigation
To further boost navigation efficiency, future iterations may incorporate:

Computer Vision: For real-time terrain analysis and dynamic obstacle detection.
SLAM Algorithms: To build and update an internal map for more accurate localization.
Machine Learning: To refine path planning based on historical data and environmental conditions.
Challenges with AI Integration:

Increased computational load may require offloading processing to the station.
Higher hardware costs and greater system complexity.
More sophisticated data management and software development.