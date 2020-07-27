#version 300 es

out vec3 vcsNormal;
out vec3 vcsPosition;
out vec3 camaraPos;
out mat4 IviewMat;

uniform vec3 cameraPositionUniform;

void main() {
	// viewing coordinate system

	/*vcsNormal = vec3(vec4(normal,1.0)*mat4((inverse(modelMatrix))));
	vcsPosition = vec3(modelMatrix * vec4(position, 1.0));
	camaraPos = vec3(vec4(cameraPositionUniform,1.0));*/

	vcsNormal = vec3(normalMatrix*normal);
	vcsPosition = vec3(modelViewMatrix * vec4(position, 1.0));
	//camaraPos = vec3(viewMatrix*vec4(cameraPositionUniform,1.0));
	IviewMat = mat4((inverse(viewMatrix)));


	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
