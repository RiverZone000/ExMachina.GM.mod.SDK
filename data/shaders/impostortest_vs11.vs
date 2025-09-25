//////////////////////////////////////////////////////////////////////////////
//
// Workfile: impostorTest_vs11.vs
// Created by: Plus
//
// $Id: impostorTest_vs11.vs,v 1.3 2005/06/20 13:28:00 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////


#include "lib.fx"

// vertex model*view*projection
float4x4 mViewProj: register( c0 ); 
float4x4 mBillboard: register( c4 );
const float2 g_FogTerm: register( c9 );


// current time
//const float timeVal: register( c10 );


//float3 	LightDir: register( c5 );

// maximum drawing distance
//float 	drawDist: register( c6 );


// camera origin (world frame)
//float3 	ViewPos: register( c8 );

float4  InstancesInfo[60]: register( c20 );


// vertex shader input structure
struct VS_INPUT
{
	float3 Pos 	: POSITION;		// (x, y, instance)
	float2 Tex0	: TEXCOORD0;		// diffuse texcoords
};


// Vertex shader output structure
struct VS_OUTPUT
{
	float4 Pos	: POSITION;
	float2 Tex0	: TEXCOORD0;
	float  fog	: FOG;
};


/// 
VS_OUTPUT ImpostorVS( VS_INPUT v )
{
	VS_OUTPUT o = (VS_OUTPUT)0;

	// 
	float3 worldPos;
	worldPos.xy = v.Pos.xy;
	worldPos.z = 0;
	worldPos = mul( worldPos, (float3x3)mBillboard ); 
	worldPos *= InstancesInfo[ v.Pos.z ].w / 10000.f;
	worldPos += InstancesInfo[ v.Pos.z ];

	// 
	float4 pos;
	pos.xyz = worldPos.xyz;
	pos.w = 1;

	//float spriteAngle = acos( dot( worldPos, float3( 0, 0, 1 ) ) );
	int num = InstancesInfo[ v.Pos.z ].w % 99.99998f;
	int a = num % 4.99998f;
	int b = num / 5.f;
	
	// project position
	o.Pos = mul( pos, mViewProj );
	o.Tex0 = v.Tex0 * 0.19921875f;   // 0.19921875 == 51 / 256; 51 == 256 / 5
	o.Tex0.x += 0.19921875f * a;
	o.Tex0.y += 0.19921875f * b;

	// fog terms
	o.fog = VertexFog( o.Pos.z, g_FogTerm );

	return o;
}