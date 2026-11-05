# Image decisions

## Base image
We selected `node:24-slim` as the base image. It provides a minimal Debian-based Linux environment with Node.js pre-installed, offering an optimal balance between a small security attack surface, reduced image size, and full compatibility with standard Linux system dependencies compared to larger standard images or standard Alpine alternatives.

## Before and after
- **Before adding `.dockerignore`:** The Docker build context included unnecessary local files and dependencies (such as local `node_modules`, temporary build artifacts, and development configuration files), increasing context transfer time and risk of caching unneeded layers.
- **After adding `.dockerignore`:** Excluded non-essential files from the build context, ensuring a clean, minimal production build, faster build times, and preventing sensitive or redundant files from entering the image layers.
- **Key Change:** Created `.dockerignore` to explicitly filter out `node_modules`, `.git`, logs, and temporary environment files, optimizing both the build context transfer speed and overall layer efficiency.

