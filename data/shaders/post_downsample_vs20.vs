//////////////////////////////////////////////////////////////////////////////
//
// Workfile: post_downsample_vs20.vs
// Created by: Plus
//
// Downsample shader for bloom/blur filter
//
// $Id: post_downsample_vs20.vs,v 1.1 2005/05/23 08:32:28 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////


#include "lib.fx"


//
struct VS_OUTPUT_DOWNSAMPLE
{
    float4 Position   : POSITION;
    float2 TexCoord   : TEXCOORD0;
};

// generate texture coordinates to sample 4 neighbours
VS_OUTPUT_DOWNSAMPLE VS_Downsample( float4 Position : POSITION, float2 TexCoord : TEXCOORD0 )
{
	VS_OUTPUT_DOWNSAMPLE OUT;

	OUT.Position = Position;
	OUT.TexCoord = TexCoord;

	return OUT;
}