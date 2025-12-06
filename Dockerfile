# Use an official Rust nightly compiler as a parent image
FROM archlinux:base

RUN pacman -Sy --noconfirm rustup cmake gcc make intel-tbb python; 

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Build flow cutter
RUN mkdir -p build/ && cd build/ && cmake -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DUSE_KAHIP=OFF .. && make console

# Run server when the container launches
ENTRYPOINT ["python", "/app/inertialflowcutter_order.py"]
