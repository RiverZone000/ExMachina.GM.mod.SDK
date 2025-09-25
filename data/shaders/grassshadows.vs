//////////////////////////////////////////////////////////////////////////////
//
// Workfile: grassShadows.vs
// Created by: Vano
//
// $Id: grassShadows.vs,v 1.4 2005/10/05 08:18:13 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////
#include "lib.fx"

// vertex model*view*projection
float4x4	mViewProj				:	register( c0 ); 

// maximum drawing distance
float 		drawDist				:	register( c6 );

// camera origin (world frame)
float3		ViewPos					:	register( c8 );

// scale to calculate lightmap texcoords
float2   lightmapScale					:	 register( c9 );

// current time
const float timeVal					:	register( c10 );

// texcoord generating matrix
float4x4	textureTransform		:	register( c11 );

// fade start
float		FadeStart				:	register( c15 );

// fade end
float		FadeEnd					:	register( c16 ); 

// grass instances info
float4		grassInstancesInfo[70]	:	register( c20 );

// vertex shader input structure
struct VS_INPUT
{
	float4 Pos 		: POSITION;		// position in object space
	float3 Normal	: NORMAL;		// normal in object space
	float2 Tex0		: TEXCOORD0;	// Texture coord		
};

// Vertex shader output structure
struct VS_OUTPUT
{
	float4 Pos		: POSITION;
	float2 Tex0		: TEXCOORD0;
	float2 Tex1		: TEXCOORD1;
	float2 Tex2		: TEXCOORD2;
	REAL4  Alpha	: COLOR0;
	REAL3   df		: COLOR1;
};

/// grass shadow vertex shader
VS_OUTPUT GrassVS( VS_INPUT v )
{
	VS_OUTPUT o = (VS_OUTPUT)0;

	// Get position
	float4 pos;
	pos.xyz = v.Pos.xyz;

	// shortcuts
	float3 worldPos 	= grassInstancesInfo[ v.Pos.w ].xyz;
	float  scale		= grassInstancesInfo[ v.Pos.w ].w;
	float2 sin_cos_Yaw  = grassInstancesInfo[ v.Pos.w + 1 ].xy;
	
	// rotate around Y axis: ( x, y, z )*rotY = ( x*cosA + z*sinA, y, z*cosA - x*sinA )
	float x = pos.x;
	pos.x = pos.x * sin_cos_Yaw.y + pos.z * sin_cos_Yaw.x;
	pos.z = pos.z * sin_cos_Yaw.y - x * sin_cos_Yaw.x;

	// Calculate alpha  and shake grass
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

		if( v.Tex0.y <= 0.3f )
		{
			float k = 1 - min( camToPosDistance, drawDist ) / drawDist;
  			float2 sc = grassInstancesInfo[ v.Pos.w + 1 ].zw;
			//sincos( 2 * timeVal + worldPos.x, sc.x, sc.y );
			sc *= 0.2f * max( pos.y, 0.0f );
			pos.xz += sc.xy * k;
		}
	}

	// scale
	pos.xyz *= scale;

	// translate
	pos.xyz += worldPos;
	pos.w = 1;

	// Calculate texcoord
	o.Tex0 = v.Tex0;
	o.Tex2 = mul( pos, textureTransform );

	// project position
	o.Pos = mul( pos, mViewProj );
	
	// Caclulate dist factor
	o.df.x  = saturate( 1.f - ( camToPosDistance - FadeStart ) / ( FadeEnd - FadeStart ) );

	// lightmap texcoords
	o.Tex1 = worldPos.xz * lightmapScale;

	return o;
}