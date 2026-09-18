# Guardian Rover: Autonomous Control System

An advanced autonomous navigation and control architecture engineered for the Guardian Rover using **MATLAB** and **Simulink**.

---

## 📋 Project Objectives

* **Robust Sensor Processing:** Translates raw analog voltages from three ultrasonic sensors (Front, Left, Right) into physical distance metrics and binary collision flags using 1-D Lookup Tables and saturation limits.
* **Noise-Resilient Filtering:** Employs a continuous-execution debounce filter to stabilize raw obstacle flags against transient noise before triggering state changes.
* **Autonomous Decision Matrix:** Evaluates spatial clearance via an Enabled Subsystem and custom MATLAB functions to dynamically dictate rover maneuvers (`IDLE`, `FORWARD`, `TURN_LEFT`, `TURN_RIGHT`, `STOP`).
* **Fail-Safe Emergency Latch:** Features a triggered emergency override protocol to force an immediate system stop under critical conditions.
* **Modular Architecture:** Utilizes structured Bus objects (`EmergencyStateBus`, `SensorDataBus`) for clean signal routing across subsystems.
* **Automated Telemetry & Diagnostics:** Managed entirely by a master initialization script that executes the simulation and outputs synchronized `Timeseries` diagnostic plots.

---

## 🗂️ Repository Structure

```text
├── run_MAIN.m             # Master initialization and execution script
├── Sensor_Process.slx     # Core Simulink control and simulation model
├── DebounceFilter.m       # Filter logic for obstacle stabilization
├── EmergencyState.m       # Programmatic definition for emergency bus objects
├── SensorDataBus.m        # Programmatic definition for sensor data bus objects
├── LICENSE                # MIT License
└── README.md              # Project documentation
