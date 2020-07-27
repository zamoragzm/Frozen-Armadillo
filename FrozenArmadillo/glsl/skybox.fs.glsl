#version 300 es

out vec4 out_FragColor;

uniform samplerCube skybox;


in vec3 texCoord;


void main() {
	vec4 clr = textureCube(skybox, texCoord);
	out_FragColor = clr;
}