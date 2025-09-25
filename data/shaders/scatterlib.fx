/**
	Scatter only functions
*/
#define pi 3.14159265358
#define scatterEccentricity 0.999995 // Henyey-Greenstein variable

const float scatterTurbidiy = 1.0;
//const float3 SunColor = {1.53, 0.612, 0.153};
//const float3 SunColor = { 1.53 * 2, 0.612 * 2, 0.153 * 2 };
float3 SunColor: USER_FLOAT3_PARAM;
//const float3 SunColor = { 0, 0, 1.5 * 2 };
//const float ScFogStart = 600.f;
float ScFogStart: USER_FLOAT_PARAM; // Not good
//const float ScFogStart = 1500.f;

// These all will be packed in one float4.
// Packing order commented here
// const float InscatterTerrMul = 6.0; // x
// const float OutscatterTerrMul = 100.0; // y

//const float InscatterSkyMul = 1400.0; // z
//const float OutscatterSkyMul = 30.0; // w

float4 PackedArgs: USER_FLOAT4_PARAM;
//float4 PackedArgs = { 9.72, 148.0, 1400,30 };
//const float3 DirFromLight = { -1, -1, 1 };
float3 DirFromLight	: TMP_LIGHT0_DIR;



//------------------------------------------------------------------------------
/**
	RelOptLength()
	
	Calculate the relative optical length from the ground to the top of the
	atmosphere.
	
	@param	cosAngle	cosine of the angle to the zenit
	@return             relative optical length
*/
float
RelOptLength(const float cosAngle)
{
// original: 1.0 / (cosAngle + 0.15 * pow(93.885 - acos(cosAngle)/pi*180.0f, -1.253));
// changed for radiant calculation:
    return 1.0 / (cosAngle + 9.4e-4 * pow(1.6386 - acos(cosAngle), -1.253));
}

//------------------------------------------------------------------------------
/**
	RayleighCoeffTotal()
	
	Calculate the total Rayleigh scattering coefficient (scattering caused by
	molecules) based on standard values for air
	
	@return     total coefficient
*/
float3
RayleighCoeffTotal()
{
//const float n =  1.0003;    // refractive index
//const float N =  2.545e25;  // number of molecules per unit volume in air
//const float pn = 0.0035;    // depolarization factor for air

// original: 8.0*pow(pi, 3.0)*pow(pow(n, 2.0) - 1.0, 2.0)*(6.0 + 3.0*pn)/(3.0 * N)/(6.0 - 7.0*pn) / lambda4;
   return float3(6.95e-6, 1.18e-5, 2.44e-5); // precalculated
}

//------------------------------------------------------------------------------
/**
	RayleighCoeffAngular()
	
	Calculate the angular Rayleigh scattering coefficient (scattering caused by
	molecules) based on standard values for air, the total scattering
	coefficient and the angle to the sun.
	
	@param  coeffTotal  the total scattering coefficient
	@param  cosAngle    cosine of the angle to the sun
	@return             angular scattering coefficient
*/
float3
RayleighCoeffAngular(float3 coeffTotal, float cosAngle)
{
    float tempVal;
    // formula sais tempVal = cosAngle^2, but this looks better:
    if (cosAngle < 0.0)
      tempVal = 0.0;
    else
      tempVal = pow(cosAngle, 6.0);
    return 3.0 / (16.0 * pi) * (1.0 + tempVal) * coeffTotal;
}

//------------------------------------------------------------------------------
/**
	MieCoeffTotal()
	
	Calculate the total Mie scattering coefficient (scattering caused by
	aerosols) based on standard values for air and the turbidity.
	
	@return             total scattering coefficient
*/
float3
MieCoeffTotal()
{
    const float3 K = {0.685, 0.679, 0.656};  // different for red, green and blue
    //const float3 lambda = {650e-9, 570e-9, 475e-9};  // red, green, blue
    const float3 lambda = {0.000000650, 0.000000570, 0.000000475};  // red, green, blue
    float3 lambda2 = pow(lambda, 2.0);

    //float c = lerp(6e-17, 25e-17, scatterTurbidiy);
    float c = lerp(0.00000000000000006, 0.000000000000000025, scatterTurbidiy);
    return 0.434 * c * pow(pi, 3.0) * 4.0 * K / lambda2;
}

//------------------------------------------------------------------------------
/**
	MieCoeffAngular()
	
	Calculate the angular Mie scattering coefficient (scattering caused by
	aerosols) based on standard values for air, the total scattering
	coefficient and the angle to the sun.
	
	@param  coeffTotal  total scattering coefficient
	@param  cosAngle    cosine of the angle to the sun
	@return             angular scattering coefficient
*/
float3
MieCoeffAngular(float3 coeffTotal, float cosAngle)
{
    return 1/(4*pi) * ((1-pow(scatterEccentricity, 2.0)) / 
        pow(1 - 2*scatterEccentricity*cosAngle + pow(scatterEccentricity, 2.0), 1.5)) * coeffTotal;
}

//------------------------------------------------------------------------------
/**
	OutscatterCoeff()
	
	Calculate the coefficient of light outscattered at a path through the air 
	based on the Rayleigh and Mie scattering coefficients and the length of the
	path.
	
	@param  rayleighCoeffTotal  total Rayleigh scattering coefficient
	@param  mieCoeffTotal       total Mie scattering coefficient
	@param  distance            length of the path
	@return                     outscattering coefficient
*/
float3
OutscatterCoeff(float3 rayleighCoeffTotal, float3 mieCoeffTotal, float distance)
{
    return exp(-(rayleighCoeffTotal + mieCoeffTotal) * distance);
}

//------------------------------------------------------------------------------
/**
	InscatterCoeff()
	
	Calculate the coefficient of light scattered in at a path through the air 
	based on the Rayleigh and Mie scattering coefficients and the length of the
	path.
	
	@param  rayleighCoeffTotal      total Rayleigh scattering coefficient
	@param  rayleighCoeffAngular    angular Rayleigh scattering coefficient
	@param  mieCoeffTotal           total Mie scattering coefficient
	@param  mieCoeffAngular         angular Mie scattering coefficient
	@param  outscatterCoeff         coefficient of outscattering
	@return     inscattering coefficient
*/
float3
InscatterCoeff(float3 rayleighCoeffTotal, float3 rayleighCoeffAngular,
    float3 mieCoeffTotal, float3 mieCoeffAngular, float3 outscatterCoeff)
{
    return (rayleighCoeffAngular + mieCoeffAngular) / 
        (rayleighCoeffTotal + mieCoeffTotal) * (1 - outscatterCoeff);
}

//------------------------------------------------------------------------------
/**
	vsAthmoFog()
	
	Calculate athmospheric fog, usable for all objects.
	
	@param  vertPos         [in] vertex position
	@param  modelEyePos     [in] camera position in model space
	@param  modelSunPos     [in] sun position in model space
	@param  inscattered     [out] inscattered light
	@param  outscattered    [out] coefficient of light outscattering
*/
void
vsAthmoFog(in const float3 vertPos,
           in const float3 ViewPos,
           in const float3 SunPos,
           out float3 inscattered,
           out float3 outscattered)
{
    float3 relVertPos = vertPos - ViewPos;
    float relVertDist = length(relVertPos);
    float cosViewSunAngle = dot(relVertPos, SunPos) / relVertDist;
    // prevent the sun from shining through the objects
    cosViewSunAngle = min(cos(radians(2.0)), cosViewSunAngle);

    float3 betaRTotal = 0.5 * RayleighCoeffTotal();
    float3 betaRAngular = RayleighCoeffAngular(betaRTotal, cosViewSunAngle);
    //float3 betaMTotal = 1e-3 * MieCoeffTotal();
    float3 betaMTotal = 0.001 * MieCoeffTotal();
    float3 betaMAngular = MieCoeffAngular(betaMTotal, cosViewSunAngle);
    
    outscattered = OutscatterCoeff( betaRTotal, betaMTotal, relVertDist * PackedArgs.x /*InscatterTerrMul*/ );
    inscattered = PackedArgs.y /*OutscatterTerrMul*/ * lerp(SunColor, 0.3, 1-cosViewSunAngle) *
        InscatterCoeff(betaRTotal, betaRAngular, betaMTotal, betaMAngular, outscattered);
}

//------------------------------------------------------------------------------
/**
	psAthmoFog()
	
	Combine in- and outscattering with texture.
	
	@param  inscatter       [in] color of inscattered light
	@param  outscatter      [in] coefficient of outscattered light
	@param  baseColor       [in] actual color of object
	@return     final object color
*/
float4
psAthmoFog(in const float3 inscatter,
           in const float3 outscatter,
           in const float4 baseColor)
{
    return float4(outscatter * baseColor.rgb + inscatter, baseColor.a);
}

float	CalcFog( float distance )
{
    return 1.0f - saturate( distance / ScFogStart );
}

//------------------------------------------------------------------------------
/**
	vsSky()
	
	Calculate Sky Color( Scattered ).
	
	@param  vertPos         [in] vertex position
	@param  modelSunPos     [in] sun position in model space
	@param  color           [out] color of the sky
*/
void
vsSky( in const float3 vertPos,
      in const float3 modelSunPos,
      out float4 color )
{
    float vertDist = length(vertPos);
    //float cosSunZenitAngle = normalize(modelSunPos).z;
	//float cosSunZenitAngle = modelSunPos.z;
    float cosViewSunAngle = dot( vertPos.xyz , modelSunPos ) / vertDist;
    float cosViewZenitAngle = saturate(-vertPos.y / vertDist);
    float relWay = RelOptLength(cosViewZenitAngle);
    
    float3 betaRTotal = 0.5 * RayleighCoeffTotal();
    float3 betaRAngular = RayleighCoeffAngular(betaRTotal, cosViewSunAngle);
    //float3 betaMTotal = 1e-3 * MieCoeffTotal();
    float3 betaMTotal = 0.001 * MieCoeffTotal();
    float3 betaMAngular = MieCoeffAngular(betaMTotal, cosViewSunAngle);

    float3 outscattered = OutscatterCoeff(betaRTotal, betaMTotal, /*InscatterSkyMul*/PackedArgs.z * relWay);
    color.rgb = PackedArgs.w/*OutscatterSkyMul*/ * lerp(SunColor, 0.3, 1-cosViewSunAngle) *
        InscatterCoeff(betaRTotal, betaRAngular, betaMTotal, betaMAngular, outscattered);
    color.a = 0.5+0.2*pow(1-cosViewZenitAngle, 4);
}

