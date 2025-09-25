//////////////////////////////////////////////////////////////////////////////
//
// Workfile: post_blur_vs20.vs
// Created by: Goryh
//
// Blur filter
//
// $Id: post_blur_vs20.vs,v 1.1 2005/05/23 08:32:27 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////

#include "lib.fx"


//
struct VS_OUTPUT_BLUR
{
    float4 Position   : POSITION;
    float2 TexCoord[4]: TEXCOORD0;
};


float 	BlurWidth: register( c0 );
float2 	WindowSize: register( c1 );


// generate texcoords for blur
VS_OUTPUT_BLUR VS_Blur( float4 Position : POSITION, float2 TexCoord : TEXCOORD0 )
{
   VS_OUTPUT_BLUR OUT = (VS_OUTPUT_BLUR)0;
    OUT.Position = Position;
	
	float2 texelSize = BlurWidth / WindowSize;

    
    OUT.TexCoord[0] = TexCoord + texelSize*float2(0,1);
    OUT.TexCoord[1] = TexCoord + texelSize*float2(0,-1);
    OUT.TexCoord[2] = TexCoord + texelSize*float2(1,0);
    OUT.TexCoord[3] = TexCoord + texelSize*float2(-1,0);
    
   
    return OUT;
}