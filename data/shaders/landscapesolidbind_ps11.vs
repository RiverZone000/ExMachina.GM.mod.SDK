//////////////////////////////////////////////////////////////////////////////
//
// Workfile: landscapeSolid_ps11.vs
// Created by: Goryh
//
//
// $Id: landscapeSolidBind_ps11.vs,v 1.1 2005/10/05 08:18:51 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////

#include "lib.fx"

// vertex model*view*projection (c0 - c3)
float4x4 mViewProj: register( c0 ); 
// camera origin (world frame)
float3 	ViewPos: register( c8 );

float2 g_FogTerm: register( c4 );

float3 initPos: register( c5 );
float3 initTex: register( c6 );
float blendRadius: register( c7 );


// vertex shader output structure
struct VS_OUTPUT
{
	float4 Pos	: POSITION;
	float2 Tex	: TEXCOORD0;
	float4 Col	: COLOR0;
	float  fog	: FOG;
};

/// 
VS_OUTPUT LandscapeVS( float Pos : POSITION, int4 AltPos : TEXCOORD0 )
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

	float camToPosDistance = distance( posInfo.xz, ViewPos.xz );
	float difference = camToPosDistance - 0.95 * blendRadius.x ;
	if( difference > 0 )
	{
		float k = saturate( difference / (0.05 * blendRadius.x) );
		//o.Col = float4( 0.5, 0.5, 0.5, k );
		o.Col = float4( 1, 1, 1, k );
	}
	else	
	{
		o.Col = float4( 1, 1, 1, 0 );
	}
     	// fog terms
	o.fog = VertexFog( o.Pos.z, g_FogTerm );

	return o;
}