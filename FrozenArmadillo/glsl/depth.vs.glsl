#version 300 es


out vec4 shadowCoord;



void main() {
      gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}