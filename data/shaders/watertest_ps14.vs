//////////////////////////////////////////////////////////////////////////////
//
// Workfile: waterTest_vs14.vs
// Created by: Plus
//
// simple water vs11 shader w/ reflection/refraction 
// and per-vertex fresnel term
//
// so far, it's just a dummy, with no any perturbation
// (I have failed to archive it using hlsl...)
//
// $Id: waterTest_ps14.vs,v 1.5 2005/10/05 08:18:14 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////


#include "lib.fx"


// vertex model*view*projection
float4x4 mViewProj: register( c0 ); 
// texture model*view*projection
float4x4 mTexture: register( c4 );

// camera origin (world frame)
float4 ViewPos: VIEW_POS: register( c8 );

const float2 g_FogTerm: register( c9 );

// current time
const float timeVal: register( c10 );

// real distance between two neighbour vertices in water cell
//const float distBetweenVerts: register( c11 );

// fresnel constants
const float fresnelBias: register( c12 );
const float fresnelScale: register( c13 );
const float fresnelPower: register( c14 );


// == 1.0f / numVertsInWaterTileEdge
const float numVertsInWaterTileEdgeRec: register( c16 );

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
float4 waterTilesInfo[256]: register( c20 );


// vertex shader input structure
struct VS_INPUT
{
	int3 PackedPosInfo : POSITION;	// x, z, tileNum, 
};


// vertex shader output structure
struct VS_OUTPUT
{
	float4 Pos	: POSITION;
	float2 Tex	: TEXCOORD0;
	float2 Tex1	: TEXCOORD1;
	float4 TexRefl	: TEXCOORD2;
	float4 TexRefr	: TEXCOORD3;
	float4 Fresnel	: COLOR0;
	float  fog	: FOG;
};


/// 
VS_OUTPUT WaterVS( VS_INPUT v )
{
	VS_OUTPUT o = (VS_OUTPUT)0;

	// unpack vertex pos
	int	tileInd = v.PackedPosInfo.z;
	float4 waterTileInfo = waterTilesInfo[tileInd];
	float4 worldPos;
	worldPos.xyz = waterTileInfo.xyz;
	worldPos.xz += distBetwVert * v.PackedPosInfo.xy;
	worldPos.w = 1;

	float2 TexShiftRipple = float2( timeVal * 0.12, timeVal * 0.06 );
	float2 NoiseCoords;
	NoiseCoords.xy = v.PackedPosInfo.xy * numVertsInWaterTileEdgeRec;
	o.Tex = (NoiseCoords + TexShiftRipple) * 1;
	o.Tex1 =  o.Tex * 5;

	// project position
	o.Pos = mul( worldPos, mViewProj );
	
	// project texcoords
	float4 texCoords = mul( worldPos, mTexture );
	//texCoords *= 1/texCoords.w;

	// shifting for synch
        //texCoords.x -= .020;
	o.TexRefl = texCoords;
	o.TexRefr = texCoords;
        o.TexRefl.w *= 1.115f;
	// fog terms
	o.fog = VertexFog( o.Pos.z, g_FogTerm );

	// calc fresnel factor (reflection coefficient)
	float3 eyeDir = normalize( worldPos - ViewPos );
	o.Fresnel = fresnelBias + fresnelScale * pow( 1 + eyeDir.y, fresnelPower );
	return o;
}