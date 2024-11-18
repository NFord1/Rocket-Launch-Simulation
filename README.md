# Rocket Launch into Low Earth Orbit

## Project Overview
This project models the dynamics of a rocket launch into low Earth orbit (~400 km altitude) using a **variable mass system**. The simulation is implemented in MATLAB and provides numerical insights into the rocket's behavior, including acceleration, velocity, position, and angle during its ascent. The project also includes detailed analysis of forces like thrust, drag, and weight.

---

## Features
1. **Variable Mass System**:
   - Models the dynamic behavior of a rocket with changing mass due to fuel consumption.
   - Incorporates conservation of momentum to compute forces and accelerations.

2. **Force Analysis**:
   - Considers thrust, drag, and gravitational forces acting on the rocket.
   - Uses realistic parameters such as air density, drag coefficient, and relative exhaust velocity.

3. **Numerical Simulation**:
   - Simulates the rocket's motion from launch to low Earth orbit.
   - Outputs time-dependent data for various parameters like position, velocity, and forces.

4. **Visualization**:
   - Generates plots to illustrate key variables such as:
     - Horizontal and vertical acceleration.
     - Rocket trajectory.
     - Mass changes over time.
     - Drag force and angular displacement.

---

## Results
The simulation results closely match expected values, with the rocket reaching:
- **Altitude**: ~500 km.
- **Horizontal Velocity**: ~10,000 m/s.
- **Burn Time**: ~8 minutes 30 seconds.

These results align with typical low Earth orbit parameters, albeit with some deviations due to approximations in the model.

---

## Requirements
- MATLAB (R2020 or later recommended).

---

## Usage
1. Clone the repository
2. Open 'Rocket_Launch_Simulation.m' in MATLAB.
3. Run the script to simulate the rocket's launch and generate plots.

## Documentation
The detailed project report, including methodology, equations, and results, is available as a PDF file:

- [Rocket Launch Simulation Report (PDF)]([./Rocket Launch Simulation Report.pdf](https://github.com/NFord1/Rocket-Launch-Simulation/blob/5e4bd70559ea5dcf31d65bb6dd91498b2a14d0ff/Rocket%20Launch%20Simulation%20Report.pdf))

The report includes:
1. **Introduction**: Overview of the rocket launch simulation and the physics of variable mass systems.
2. **System Details**: Equations of motion, force analysis, and assumptions.
3. **Results**: Numerical simulation outputs with graphs and analysis.
4. **Discussion**: Comparison with real-world expectations and limitations of the model.

Refer to the report for an in-depth explanation of the simulation.
