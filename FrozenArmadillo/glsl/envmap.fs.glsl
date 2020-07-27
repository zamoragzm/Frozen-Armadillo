#version 300 es

out vec4 out_FragColor;

in vec3 vcsNormal;
in vec3 vcsPosition;
in vec3 camaraPos;
in mat4 IviewMat;

uniform vec3 lightDirection;
uniform samplerCube skybox;

void main( void ) {
      //vec3 L = normalize(vec3(viewMat * vec4(lightDirection, 0.0)));

      /*vec3 vcsNormal = normalize(vcsNormal);
      vec3 I = normalize(vcsPosition-camaraPos);
      vec3 R = (reflect(I,vcsNormal));*/


      vec3 vcsNormal = normalize(vcsNormal);
      vec3 I = normalize(-vcsPosition);
      vec3 R = -vec3(vec4(refract(I,vcsNormal,0.657 ),1.0)*IviewMat);

      vec4 texColor = textureCube(skybox,R);
      out_FragColor = vec4(texColor.x,texColor.y,texColor.z,0.75);
}
