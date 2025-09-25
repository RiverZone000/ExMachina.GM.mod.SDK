//////////////////////////////////////////////////////////////////////////////
//
// Workfile: landscapeSolid_ps11.vs
// Created by: Goryh
//
//
// $Id: landscape_ps11.vs,v 1.3 2005/10/10 12:45:45 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////

#include "lib.fx"

// vertex model*view*projection (c0 - c3)
float4x4 mViewProj: register( c0 ); 

// world matrix
row_major float4x4 mWorld: register( c4 );

float2 g_FogTerm: register( c8 );

// scale to calculate lightmap texcoords
float2 lightmapScale: register( c9 );

float3 initPos: register( c10 );

// vertex shader output structure
struct VS_OUTPUT
{
	float4 Pos	: POSITION;
	float2 Tex1	: TEXCOORD0;
	float2 Tex2	: TEXCOORD1;
	float2 Tex3	: TEXCOORD2;
	float  fog	: FOG;
};

struct VS_INPUT
{
	float Pos	: POSITION;
	int2 AltPos : TEXCOORD0;
	float2 Tex2	: TEXCOORD1;
};

/// 
VS_OUTPUT LandscapeVS( VS_INPUT In )
{
	VS_OUTPUT o = (VS_OUTPUT)0;
	// unpack vertex pos
	float4 posInfo;

	int indX =  In.AltPos.x / 128;
	int indY =  In.AltPos.x - indX * 128;
	posInfo.x  = initPos.x + initPos.z * indX;
 	posInfo.z  = initPos.y + initPos.z * indY;
	posInfo.y  = In.Pos;

        posInfo.w  = 1;


     	o.Pos = mul( posInfo, mViewProj );

	int texU =  In.AltPos.y / 512;
	int texV =  In.AltPos.y - texU * 512;
	o.Tex1 = float2( texU , texV ) / 64;

	//o.Tex1 = float2( In.AltPos.y , In.AltPos.z ) / 100;
	o.Tex2 = In.Tex2;

	// lightmap coords
	o.Tex3 = mul( posInfo, mWorld ).xz * lightmapScale;

     	// fog terms
	o.fog = VertexFog( o.Pos.z, g_FogTerm );

	return o;
}