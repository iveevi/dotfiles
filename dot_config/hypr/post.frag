precision mediump float;

varying vec2 v_texcoord;

uniform sampler2D tex;

void main()
{
	// blue-light filter
	vec4 pixColor = texture2D(tex, v_texcoord);
	pixColor[1] *= 0.855;
	pixColor[2] *= 0.725;

	gl_FragColor = pixColor;
}
