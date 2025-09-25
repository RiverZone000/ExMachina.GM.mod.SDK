//////////////////////////////////////////////////////////////////////////////
//
// Workfile: grassTest_vs11.vs
// Created by: Plus
//
// $Id: grassTest_vs11.vs,v 1.9 2005/10/05 08:18:13 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////


#include "lib.fx"

// vertex model*view*projection
float4x4 mViewProj: register( c0 ); 

float3 	LightDir: register( c5 );

// maximum drawing distance
float 	drawDist: register( c6 );


// camera origin (world frame)
float3 	ViewPos: register( c8 );

// scale to calculate lightmap texcoords
float2   lightmapScale: register( c9 );


//float4x4 mViewInv: register( c9 ); 


float4  grassInstancesInfo[236]: register( c20 );


// vertex shader input structure
struct VS_INPUT
{
	float4 Pos 	: POSITION;		// position in object space
	float3 Normal	: NORMAL;		// normal in object space
	float2 Tex0	: TEXCOORD0;		// diffuse texcoords
	//float  Instance	: TEXCOORD1;		
};


// Vertex shader output structure
struct VS_OUTPUT
{
	float4 Pos	: POSITION;
	float2 Tex0	: TEXCOORD0;
	float2 Tex1	: TEXCOORD1;
	REAL4  Alpha	: COLOR0;
	//float4 Clr	: COLOR0;
	//float  fog	: FOG;
};


/// 
VS_OUTPUT GrassVS( VS_INPUT v )
{
	VS_OUTPUT o = (VS_OUTPUT)0;

	float4 pos;
	pos.xyz = v.Pos.xyz;

	//pos.xyz = mul( pos.xyz, (float3x3)mViewInv );

	// shortcuts
	float3 worldPos = grassInstancesInfo[ v.Pos.w ].xyz;
	float  scale		= grassInstancesInfo[ v.Pos.w ].w;
	float2 sin_cos_Yaw = grassInstancesInfo[ v.Pos.w + 1 ].xy;
	//float2 sin_cos_Yaw = float2( 0, 1 );
	
	// rotate around Y axis: ( x, y, z )*rotY = ( x*cosA + z*sinA, y, z*cosA - x*sinA )
	float x = pos.x;
	pos.x = pos.x * sin_cos_Yaw.y + pos.z * sin_cos_Yaw.x;
	pos.z = pos.z * sin_cos_Yaw.y - x * sin_cos_Yaw.x;


	// calculate alpha  and shake grass
	float camToPosDistance = distance( worldPos, ViewPos );
	float difference = camToPosDistance - 0.75 * drawDist;
	if( difference > 0 )
	{
		float k = saturate( difference / (0.25 * drawDist ) );
		o.Alpha = REAL4( 0, 0, 0, k );
		
	}
	else
	{
		o.Alpha = REAL4( 0, 0, 0, 0 );

		//if( pos.y > 1.5f )
		if( v.Tex0.y <= 0.3f )
		{
			float k = 1 - min( camToPosDistance, drawDist ) / drawDist;
			float2 sc = grassInstancesInfo[ v.Pos.w + 1 ].zw;
			sc *= 0.2f * max( pos.y, 0.0f );
			pos.xz += sc.xy * k;
		}
		//pos.xyz *= 1 - o.Alpha.a;
	}

	// scale
	pos.xyz *= scale;

	// translate
	pos.xyz += worldPos;
	pos.w = 1;

	//o.Alpha = 0;

	// project position
	o.Pos = mul( pos, mViewProj );
	o.Tex0 = v.Tex0;

	// lightmap texcoords
	o.Tex1 = worldPos.xz * lightmapScale;

	return o;
}