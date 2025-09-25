//////////////////////////////////////////////////////////////////////////////
//
// Workfile: post_bw_ps11.vs
// Created by: Plus
//
// Converts colored scene to black'n'white
//
// $Id: post_bw_ps11.vs,v 1.1 2004/09/20 07:45:42 plus Exp $
//
//////////////////////////////////////////////////////////////////////////////


#include "lib.fx"


//
struct VS_OUTPUT
{
	float4 Position   : POSITION;
	float2 TexCoord0  : TEXCOORD0;
};


//
//float 	downsampleScale: register( c0 );
//float2 	WindowSize: register( c1 );


//
VS_OUTPUT VS_Quad( float3 Position : POSITION, float2 TexCoord : TEXCOORD0 )
{
	VS_OUTPUT OUT;
	//float2 texelSize = 1.0 / WindowSize;
	OUT.Position = float4( Position, 1 );

	// don't want bilinear filtering on original scene:
	OUT.TexCoord0 = TexCoord;// + texelSize * 0.5f;
	//OUT.TexCoord1 = TexCoord + texelSize * 0.5f / downsampleScale;

	return OUT;
}