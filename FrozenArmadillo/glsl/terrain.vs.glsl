#version 300 es

out vec3 vcsNormal;
out vec3 vcsPosition;
out vec2 vcsTexcoord;
out vec4 shadowCoordinate;

uniform mat4 lightViewMatrixUniform;
uniform mat4 lightProjectMatrixUniform;



void main() {
	// viewing coordinate system
	vcsNormal = normalMatrix * normal;
	vcsPosition = vec3(modelViewMatrix * vec4(position, 1.0));
	vcsTexcoord = uv;

	mat4 biasMatrix = mat4(0.5, 0.0, 0.0, 0.0, 
					       				0.0, 0.5, 0.0, 0.0, 
					       				0.0, 0.0, 0.5, 0.0,
					      			  0.5, 0.5, 0.5, 1.0);
	
	shadowCoordinate = biasMatrix * lightProjectMatrixUniform * lightViewMatrixUniform * modelMatrix * vec4(position, 1.0);

  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
