//////////////////////////////////////////////////////////////////////////////
//
// Workfile: landscapeSolid_ps11.vs
// Created by: Goryh
//
//
// $Id: landscapeSolid_ps11.vs,v 1.4 2005/10/05 08:18:13 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////

#include "lib.fx"

// vertex model*view*projection (c0 - c3)
float4x4 mViewProj: register( c0 ); 

float2 g_FogTerm: register( c4 );

float3 initPos: register( c5 );
float3 initTex: register( c6 );


// vertex shader output structure
struct VS_OUTPUT
{
	float4 Pos	: POSITION;
	float2 Tex	: TEXCOORD0;
	float  fog	: FOG;
};

/// 
VS_OUTPUT LandscapeVS( float Pos : POSITION, int2 AltPos : TEXCOORD0 )
{
	VS_OUTPUT o = (VS_OUTPUT)0;

	// unpack vertex pos
	float4 posInfo;
	int indX =  AltPos.x / 128;
	int indY =  AltPos.x - indX * 128;
	posInfo.x  = initPos.x + initPos.z * indX;
 	posInfo.z  = initPos.y + initPos.z * indY;
	posInfo.y  = Pos.x;
        posInfo.w  = 1;

     	o.Pos = mul( posInfo, mViewProj );

	o.Tex.x  = initTex.x + initTex.z * indX;
 	o.Tex.y  = -initTex.y - initTex.z * indY;

     	// fog terms
	o.fog = VertexFog( o.Pos.z, g_FogTerm );

	return o;
}