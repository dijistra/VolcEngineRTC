precision highp float;
varying vec2 texCoord;
varying vec2 sucaiTexCoord;
varying float varOpacity;

uniform sampler2D inputImageTexture;
uniform sampler2D videoImageTexture;
uniform sampler2D sucaiImageTexture;

uniform float intensity;
#ifdef USE_SEG
 varying vec2 segCoord;
 uniform sampler2D segMaskTexture;
#endif

vec3 blendMultiply(vec3 base, vec3 blend) {
    return base * blend;
}

vec3 blendMultiply(vec3 base, vec3 blend, float opacity) {
    return (blendMultiply(base, blend) * opacity + blend * (1.0 - opacity));
}

void main(void)
{
    vec4 src = texture2D(videoImageTexture, texCoord);
    vec4 sucai = texture2D(sucaiImageTexture, sucaiTexCoord);
    vec4 inputimage = texture2D(inputImageTexture, texCoord);

    // PIcc
    vec3 color = blendMultiply(inputimage.rgb, clamp(sucai.rgb * (1.0 / sucai.a), 0.0, 1.0));
#ifdef USE_SEG
    float seg_opacity = (texture2D(segMaskTexture, segCoord)).x;
    if(clamp(segCoord, 0.0, 1.0) != segCoord) seg_opacity = 1.0;
    color = mix(inputimage.rgb, color, seg_opacity);
#endif

#ifdef BLENDFUN_USEABLE
    float alpha = sucai.a * intensity * varOpacity;
    color *= alpha;
    gl_FragColor = vec4(color, alpha);
#else
    float alpha = sucai.a*intensity * varOpacity;
    color = mix(inputimage.rgb, color, alpha);
    gl_FragColor = vec4(color, 1.0);
#endif
}
