//////////////////////////////////////////////////////////////////////////////
//
// Workfile: post_composite_vs11.vs
// Created by: Plus
//
// Final composite shader for bloom filter
//
// $Id: post_composite_vs11.vs,v 1.1 2005/05/23 08:32:27 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////

#include "lib.fx"


//
struct VS_OUTPUT
{
	float4 Position   : POSITION;
	float2 TexCoord0  : TEXCOORD0;
	float2 TexCoord1  : TEXCOORD1;
};


//
float 	downsampleScale: register( c0 );
float2 	WindowSize: register( c1 );


//
VS_OUTPUT VS_Quad( float4 Position : POSITION, float2 TexCoord : TEXCOORD0 )
{
    VS_OUTPUT OUT;
    
    float2 texelSize = 1.0 / WindowSize;
    OUT.Position = Position;

    OUT.TexCoord0 = TexCoord;// + texelSize*0.5;
    OUT.TexCoord1 = TexCoord;// + texelSize*0.5/downsampleScale;
    return OUT;
}