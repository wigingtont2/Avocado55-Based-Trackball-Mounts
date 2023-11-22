# Avocado55 Based Trackball Mounts

3D design files for trackball mounts based on the Avocado 55 project, a self-made trackball. It is released under MIT license, including STL SCAD. Feel free to use them for your own projects.

# Needed Material
- FDM 3D printer (for mounts)
- Case
- Filament
- Magnets (Example: https://www.amazon.com/dp/B09TQQHQLP)
- Something to add grip to the feet<br />
This is necessary to prevent lateral motion, as the magnets don't do a great job at that. I use a thin layer of silicone caulk.
- Metal plates (Example: https://www.amazon.com/dp/B093DQH88J)
- PMW33XX with PCB https://www.tindie.com/products/citizenjoe/pmw3389-motion-sensor/
- Ball transfer bearing (8mm)<br />

The original project supported 2 BTUs, with adjustments to the depth of the bearing mounts to maintain the distance of the ball above the sensor. I did not use either of the original BTUs, so this project supports a third version. The original 2 BTUs should still work, if you set the bearing version, but I have not tested either. The base project does not link bearing version 1, but indicates that it's sold by uxcell. The bearings I used were made by uxcell, so it may be that changes to manufacturing have invalidated version 1 as an option.

US Amazon<br />
Bearing Version 2<br />
https://www.amazon.com/gp/product/B07BVLWK7Q<br />

Bearing Version 3<br />
https://www.amazon.com/gp/product/B08LCX8SDV<br />

### 3D Design
- OpenSCAD 
https://www.openscad.org<br />
You can adjust the design from the SCAD files. You need OpenSCAD to create STLs for printing. There is currently one example STL and 3MF included, with the settings I'm using on my Sovol SV06. I haven't done a lot of experimentation, but I would recommend against organic supports. Using them always resulted in the sensor mount being messy, and requiring clean-up to mount the sensor. I have not tested prints of all the variants currently possible, so some trial and error may be needed. If you do find an issue, please open a PR to correct it.
- PrusaSlicer or any other 3D print slicer
https://www.prusa3d.com/page/prusaslicer_424/
