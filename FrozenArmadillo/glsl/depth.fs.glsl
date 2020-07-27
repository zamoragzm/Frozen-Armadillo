#version 300 es

out vec4 out_FragColor;
in vec4 shadowCoord;


vec4 encodeDepthToRGBA(float depth) {
	// Packing single float in RGBA
	const vec4 bitShift = vec4(
		1.0, 
		256.0, 
		256.0 * 256.0, 
		256.0 * 256.0 * 256.0);
    const vec4 bitMask = vec4(
    	1.0/256.0, 
    	1.0/256.0, 
    	1.0/256.0, 
    	0.0);
    vec4 rgbaDepth = fract(depth * bitShift);
    rgbaDepth -= rgbaDepth.gbaa * bitMask;
    return rgbaDepth;
}

void main() {


	out_FragColor = encodeDepthToRGBA(gl_FragCoord.z);
}