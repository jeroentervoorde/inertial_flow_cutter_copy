# Use an official Rust nightly compiler as a parent image
FROM archlinux:base

RUN pacman -Sy --noconfirm rustup cmake gcc make intel-tbb python openmpi; 

ADD tool /app/tool

# Set the working directory to /app
WORKDIR /app

# Build flow cutter
RUN mkdir -p tool/build/ && cd tool/build/ && cmake -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DUSE_KAHIP=ON .. && make console

ADD *.py /app
# Copy the current directory contents into the container at /app
RUN chmod +x *.py

# Run server when the container launches
ENTRYPOINT ["python", "/app/inertialflowcutter_order.py"]
