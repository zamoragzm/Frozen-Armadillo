#version 300 es

uniform vec3 cameraPositionUniform;

out vec3 texCoord;
void main() {
	texCoord = vec3(modelMatrix * vec4(position, 1.0));

	gl_Position = projectionMatrix * viewMatrix * vec4(texCoord+cameraPositionUniform, 1.0);
	//gl_Position.z = gl_Position.w;
}