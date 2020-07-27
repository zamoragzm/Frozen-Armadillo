#version 300 es

out vec4 out_FragColor;

in vec3 vcsNormal;
in vec3 vcsPosition;
in vec2 vcsTexcoord;
in vec4 shadowCoordinate;


uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightDirection;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

uniform sampler2D colorMap;
uniform sampler2D normalMap;
uniform sampler2D aoMap;
uniform sampler2D shadowMap;

void main() {
	// TANGENT SPACE NORMAL
	vec3 Nt = normalize(texture(normalMap, vcsTexcoord).xyz * 2.0 - 1.0);
	vec3 cM = (texture(colorMap, vcsTexcoord).xyz);
	vec3 aO = normalize(texture(aoMap, vcsTexcoord).xyz);
	



	// PRE-CALCS
	vec3 Ni = normalize(vcsNormal);
	vec3 L = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0)));
	vec3 V = normalize(-vcsPosition);
	vec3 H = normalize((V + L) * 0.5);
	vec3 upVector = vec3(0.0,1.0,0.0);
	vec3 tangent = normalize(cross(Ni,upVector));
	vec3 biTangent = normalize(cross(Ni,tangent));
	mat3 TBN = mat3(tangent,biTangent,Ni);
	vec3 Lt = normalize(L*TBN);
	vec3 Vt = normalize(V*TBN);
	vec3 Ht = normalize(Vt+Lt);

	//AMBIENT
	vec3 light_AMB = ambientColor * kAmbient*aO;

	//DIFFUSE
	vec3 diffuse = kDiffuse * lightColor;
	vec3 light_DFF = diffuse * max(0.0, dot(Nt, Lt))*cM;

	//SPECULAR
	vec3 specular = kSpecular * lightColor;
	vec3 light_SPC = specular * pow(max(0.0, dot(Ht, Nt)), shininess);

	//SHADOW
	/*float shadow =  texture(shadowMap, shadowCoordinate.xy).r;
	float error = 0.00005;
	float visibility = 1.0;
	if (shadow < shadowCoordinate.z/shadowCoordinate.w - error) {
		visibility = 0.2;
	}*/


	//TOTAL
	vec3 TOTAL = light_AMB+light_DFF+light_SPC;


	out_FragColor = vec4(TOTAL.x+0.4,TOTAL.y+0.4,TOTAL.z+0.5, 1.0);
}
