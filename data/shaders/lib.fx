//

// helpers to declare 
#include "libSamplers.fx"


// 
#define SPACE_OBJECT 	1
#define SPACE_WORLD 	2
#define SPACE_VIEW 	3


#ifdef NV3x
#	define REAL	half
#	define REAL2	half2
#	define REAL3	half3
#	define REAL4	half4
#	define REAL3x3	half3x3
#	define REAL3x4	half3x4
#	define REAL4x3	half4x3
#	define REAL4x4	half4x4
#else
#	define REAL	float
#	define REAL2	float2
#	define REAL3	float3
#	define REAL4	float4
#	define REAL3x3	float3x3
#	define REAL3x4	float3x4
#	define REAL4x3	float4x3
#	define REAL4x4	float4x4
#endif



// (1-step Newton-Raphson re-normalization correction)
float3 normalizeApprox( const float3 v )
{
	return (1 - saturate(dot(v.xyz, v.xyz))) * (v*0.5) + v; 
}


// bx2
float3 bx2( const float3 v )
{
 	return ( v - 0.5 ) * 2;
}


// pow( f, 16 ) approximation for ps_1_1/ps_1_4
float pow16( const float f )
{
	/**
		actual code:
		
		def c0, 4.0f, 1.0f, 0.0f, -0.75f  
		mad_x4_sat r1.w, r1.w, r1.w, c0.w 
	 */
	return saturate( 4*(f*f - 0.75f) );
}


// convert to tangent space (v, tangent, binormal & normal should be in the same space)
float3 toTangentSpace( const float3 v, const float3 tangent, const float3 binormal, const float3 normal )
{
	return float3( dot( v, tangent ), dot( v, binormal ), dot( v, normal ) );
}


//
float VertexFog( const float Z, const float2 FogTerm )
{
	//return saturate( ( FogTerm.x - Z ) / FogTerm.y );
	return saturate( ( FogTerm.x - Z ) * FogTerm.y );
}

// test constants
//float3 SKY_COLOR		=	float3( 183.0/255.0, 188.0/255.0, 202.0/255.0 );
//float3 GROUND_COLOR		=	float3( 52.0/255.0, 52.0/255.0, 61.0/255.0 );
//float3 SPECULAR_COLOR	=	float3( 1, 1, 1 );