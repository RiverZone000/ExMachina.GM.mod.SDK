//////////////////////////////////////////////////////////////////////////////
//
// Workfile: decals.vs
// Created by: Vano
//
// $Id: decals.vs,v 1.1 2005/11/11 09:17:36 vano Exp $
//
//////////////////////////////////////////////////////////////////////////////

#include "lib.fx" 

float2	  g_FogTerm : register( c0 );

//float3 LightDir: register( c4 ); 

float4x4  matrices[ 60 ]: register( c10 );

// vertex shader input structure
struct VS_INPUT
{
	float3 Pos 	: POSITION;		// position in object space
	float2 Tex0	: TEXCOORD0;	// diffuse texcoords
	int2   index: TEXCOORD1;	// matrix index		
};

// Vertex shader output structure
struct VS_OUTPUT
{
	float4 Pos	: POSITION;
	float2 Tex0	: TEXCOORD0;
	float  fog	: FOG;
};

/// 
VS_OUTPUT DecalsVS( VS_INPUT v )
{
	VS_OUTPUT o = (VS_OUTPUT)0;

	// Calculate position
	o.Pos			= mul( float4( v.Pos, 1 ), matrices[ v.index.x ] );
	// Calculate texcoord
	o.Tex0			= v.Tex0;
	//Calculate fog value
	o.fog			= VertexFog( o.Pos.z, g_FogTerm );
	 
	return o;
}