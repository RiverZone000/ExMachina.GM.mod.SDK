//////////////////////////////////////////////////////////////////////////////
//
// Workfile: waterTest_vs11.vs
// Created by: Plus
//
// simple water vs11 shader w/ reflection/refraction 
// and per-vertex fresnel term
//
// so far, it's just a dummy, with no any perturbation
// (I have failed to archive it using hlsl...)
//
// $Id: water_dumb.vs,v 1.1 2005/10/24 06:39:38 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////

#include "lib.fx"

// vertex model*view*projection
float4x4 mViewProj: register( c0 ); 

//const float2 g_FogTerm: register( c9 );
float2 g_FogTerm: register( c9 );

float distBetwVert: register( c17 );
/**
	vertices are packed:

	x - x offset from the begining of a water tile
	y - z offset from the begining of a water tile
	z - water tile index into waterTilesInfo[] array
 */

/**
	water tile info:

	x - starting x position (world frame)
	y - water height (world frame)
	z - starting z position (world frame)
 */
float4 waterTilesInfo[512]: register( c20 );


// vertex shader input structure
struct VS_INPUT
{
	int3 PackedPosInfo : POSITION;	// x, z, tileNum, 
};


// vertex shader output structure
struct VS_OUTPUT
{
	float4 Pos	: POSITION;
	float  fog	: FOG;
};


/// 
VS_OUTPUT WaterVS( VS_INPUT v )
{
	VS_OUTPUT o = (VS_OUTPUT)0;

	// unpack vertex pos
	int	tileInd = v.PackedPosInfo.z;
	float4	waterTileInfo = waterTilesInfo[tileInd];
	float4	worldPos;
	worldPos.xyz = waterTileInfo.xyz;
	worldPos.xz += distBetwVert * v.PackedPosInfo.xy;
	worldPos.w = 1;

	// project position
	o.Pos = mul( worldPos, mViewProj );
	
	// fog terms
	o.fog = VertexFog( o.Pos.z, g_FogTerm );

	return o;
	}