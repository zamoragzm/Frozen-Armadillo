#version 300 es

out vec3 vcsNormal;
out vec3 vcsPosition;

uniform vec3 armadilloPosition;

void main() {
	// viewing coordinate system
	vcsNormal = normalMatrix * normal;
	vcsPosition = vec3(modelViewMatrix * vec4(position, 1.0));

	// world coordicate system
	vec3 wcsPosition = vec3(modelMatrix * vec4(position, 1.0)).xyz;
  wcsPosition += armadilloPosition;

	gl_Position = projectionMatrix * viewMatrix * vec4(wcsPosition, 1.0);
}
