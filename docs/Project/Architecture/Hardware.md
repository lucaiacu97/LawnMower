# **Autonomous Mower Project Documentation - Architecture**

## **🛠️ Hardware**
The hardware section outlines the physical components that make up the autonomous lawn mower system.  
This system is designed to autonomously navigate the mowing area, cut grass, detect obstacles, and communicate with a central station for charging and diagnostics.  
The hardware is divided into three key categories: **System Components**, **Sensors**, and **Mechanical Parts**.  

### **🤖 System Components**
This section provides a comprehensive overview of all the key hardware components that make up the mower and station.  
These elements are central to the system's functionality and interact seamlessly to provide the desired performance.  

#### **Mower**
The mower is the mobile unit of the system, tasked with the primary functions of navigating the lawn, detecting obstacles, and performing the grass cutting operation.  
The mower must work under varying conditions, from different terrains to obstacles, while ensuring safety and efficiency in operation.  

- **Embedded Controller**:  
  The **STM32F407** microcontroller is chosen for its excellent balance between processing power and energy efficiency.  
This controller is capable of handling complex tasks, from sensor data processing to motor control, and it supports multiple communication interfaces.  
It is a 32-bit ARM Cortex-M4 processor that runs at a speed of 168 MHz, providing the necessary power for real-time operations, while also being energy-efficient to prolong battery life.  

- **Motors and Actuators**:  
  The motors are essential for the movement and cutting ability of the mower.

  - **Drive Motors**: The mower is equipped with two independent **Brushless DC (BLDC)** motors, which allow for differential steering.  
This means each motor drives one of the wheels independently, enabling the mower to make sharp turns and precise maneuvers.  
BLDC motors are preferred due to their higher efficiency, longer lifespan, and better torque-to-weight ratio compared to brushed motors.  
They provide smooth and responsive movement, which is crucial for precise navigation.  

  - **Cutting Motor**: 
The cutting system is powered by a high-torque motor that drives the blades for effective grass cutting.  
This motor is designed to operate at variable speeds, adjusting power based on the thickness and density of the grass.  
The cutting motor is integrated with safety mechanisms such as an **emergency stop** function, which immediately halts the motor if an obstacle is detected or if the mower is lifted.  

- **Power System**:  
  The power system ensures that the mower operates continuously and efficiently. Power management is critical for both performance and safety.  

  - **Battery**: 
The mower is powered by a **LiFePO4** (Lithium Iron Phosphate) battery, which is chosen for its **long lifespan**, **safety**, and **thermal stability**.  
LiFePO4 batteries are more resistant to overheating and overcharging compared to other lithium batteries.  
They also offer a more consistent discharge rate, which is ideal for providing steady power to the mower during its operation.  
As an alternative, a **Li-ion** (Lithium-ion) battery can be used for cost-effective solutions, but it may have a slightly shorter lifespan.  

  - **Battery Management System (BMS)**: 
The BMS ensures that the battery operates efficiently by monitoring charge levels, preventing overcharging, and managing power distribution between components.  
It also protects the battery from excessive discharge and thermal issues, optimizing the overall system’s longevity.  

#### **Station**
The charging station serves as the base of operations for the mower.  
It is responsible for recharging the mower, handling communication, and processing data when the mower is docked.  
The station's design is focused on ease of use, reliability, and effective management of the mower's energy needs.  

- **Computing Unit**:  
  The central **computing unit** of the charging station is typically a **single-board computer** (such as a Raspberry Pi) or a dedicated **microcontroller**.  
This unit is responsible for real-time data logging, system diagnostics, and controlling the docking mechanism.  
It also handles communication between the mower and the mobile app via the MQTT protocol.  
This allows the station to send data on the mower’s status, battery levels, and performance to the user’s app.

- **Docking Mechanism**:  
  The charging station features an automated docking system that ensures the mower is accurately aligned for charging.  
The mechanism uses **sensors** (such as infrared or proximity sensors) to guide the mower into the docking station, ensuring that the charging contacts are properly connected.  
Once docked, the mower can recharge its battery efficiently, and the station can communicate with the mower to update its status.  

- **Charging System**:  
  The charging system is designed to efficiently recharge the mower’s battery while safeguarding it against overcharging.  
The system uses **smart charging algorithms** that monitor the battery’s voltage and temperature, adjusting the charging rate to prevent overheating and extend the life of the battery.  
Overcharging protection is implemented to stop charging once the battery reaches full capacity, while a **trickle charge** may be used to keep the battery at optimal levels.  

---

### **📡 Sensors**
Sensors are critical for the mower’s operation, enabling it to navigate autonomously, avoid obstacles, localize itself, and communicate effectively.  
The following sensors are used in the mower system:  

- **IMU (Inertial Measurement Unit)**:  
  The IMU is used to measure the orientation and tilt of the mower in real time.  
It helps the mower understand its position relative to the ground and ensures accurate navigation.  
The IMU is essential for detecting inclines and adjusting the mower’s path to maintain stability and prevent tipping.  

- **Wheel Encoders**:  
  Wheel encoders measure the rotation of the mower's wheels and estimate the distance traveled.  
By tracking the rotation of the wheels, the mower can estimate its position within a given space.  
This data is used in combination with other sensors to provide feedback on the mower’s trajectory and ensure it stays on track.  

- **Ultrasonic Sensors**:  
  These sensors are used for detecting objects and obstacles in the mower’s path.  
Ultrasonic waves are emitted, and the sensor measures the time it takes for the waves to bounce back after hitting an object.  
This data is used to identify obstacles in real-time and trigger adjustments to the mower’s movement to avoid collisions.  

- **LiDAR (Light Detection and Ranging)**:  
  LiDAR is an optional sensor that provides high-resolution, 360-degree scanning of the environment.  
It uses laser pulses to measure distances and creates detailed 3D maps of the surroundings.   
This sensor is particularly useful for precise obstacle detection and mapping the mower's environment, ensuring the mower can avoid obstacles and navigate complex terrain efficiently.  

- **GPS (Global Positioning System)**:  
  The GPS sensor provides the mower with location data, enabling it to localize itself on a map and navigate more accurately.  
This is especially important for larger areas where precision in navigation is required.  
GPS helps in outdoor navigation and can be used in conjunction with other sensors to enhance the mower’s localization capabilities.

- **Bumper Sensors**:  
  Bumper sensors serve as additional safety features.  
These sensors detect any physical contact with obstacles and can trigger an immediate stop in the mower’s operation.  
This safety measure prevents damage to both the mower and objects in its path.

---

## 📶 **Communication modules**

Communication is a crucial component of the mower and charging station system, enabling real-time data exchange, remote diagnostics, and seamless integration with the user app.  

### LoRa Module
- **Long-Range Communication**:  
  The **LoRa (Long Range)** module is employed for low-power, long-range communication between the mower and the charging station.  
LoRa’s ability to cover large distances makes it ideal for outdoor applications like autonomous lawn mowing.  
It ensures the mower can transmit telemetry data even when it is far from the charging station.  

- **Low Power Consumption**:  
  LoRa is designed to be energy-efficient, making it suitable for battery-powered devices like the mower.  
It uses very little power when idle, which helps extend the mower’s operating time and reduce the frequency of charging cycles.  

### Wi-Fi Module
- **High-Speed Data Transfer**:  
  The Wi-Fi module enables high-speed communication between the mower, charging station, and the user app when the mower is docked.  
Wi-Fi is used to transfer large amounts of data, such as system diagnostics, software updates, and performance logs.  

- **Mower-to-App Interaction**:  
  The Wi-Fi connection facilitates the transfer of real-time status information from the mower to the user app.  
It allows users to monitor the mower's battery level, task progress, and environmental data. Users can also send commands to the mower, such as initiating mowing or scheduling tasks.  

---

### **🔩 Mechanical Parts**
The mechanical parts are responsible for the physical movement and structure of the mower.  
These parts ensure that the mower operates smoothly on various terrains, can handle obstacles, and is robust enough for regular outdoor use.  

- **Chassis**:  
  The chassis is the main body of the mower and provides structural integrity to the entire system.  
It is typically made of lightweight but durable materials, such as **aluminum**, **steel**, or **reinforced plastic**.  
The chassis houses all the critical components, including the motor, battery, controller, and sensors.   
It is designed to be sturdy enough to withstand outdoor conditions while being light enough to allow for efficient movement.  

- **Wheels and Suspension**:  
  The mower’s wheels are designed to provide maximum traction on various surfaces, including grass, dirt, and gravel.  
**All-terrain wheels** are used to ensure that the mower can navigate different terrains without getting stuck.  
The wheels may be fitted with **pneumatic tires** for better grip or **solid rubber tires** for durability.  
The mower also features a basic suspension system to absorb shocks and impacts from uneven terrain, ensuring a smoother ride.  

- **Drive System**:  
  The mower uses a **differential drive system**, which allows the left and right wheels to be driven independently.  
This system gives the mower the ability to turn on the spot and make sharp turns, which is especially useful in tight spaces and for navigating around obstacles.  

- **Cutting Mechanism**:  
  The cutting system consists of a high-torque motor that powers a set of blades designed to cut grass efficiently.  
The cutting mechanism is adjustable to allow for different cutting heights.  
The blades are designed to handle various grass types and thicknesses, ensuring a clean and even cut every time.  
The cutting system is also equipped with safety features, such as a **blade lift sensor** that prevents the blades from spinning when the mower is lifted off the ground.  

- **Docking Mechanism**:  
  The docking mechanism ensures that the mower can return to the station and dock automatically for charging.  
The system is equipped with alignment sensors that guide the mower into the docking station with precision.  
Once aligned, the mower connects to the charging system and begins the recharging process.

---

## **Conclusions**
The hardware architecture of the autonomous mower system has been designed with reliability, efficiency, and safety in mind.  
Each component, from the sensors and actuators to the power system and communication modules, has been carefully selected to provide seamless operation.  
The integration of advanced sensors and communication systems ensures that the mower can navigate and operate autonomously in various environments, while the robust mechanical design provides the durability needed for outdoor use.  
The charging station, with its automated docking and intelligent charging system, ensures that the mower remains operational with minimal user intervention.  
This well-integrated system provides a solid foundation for future advancements in autonomous lawn care.  
