//////////////////////////////////////////////////////////////////////////////
//
// Workfile: post_blur_vs11.vs
// Created by: Goryh
//
// Old film effect vertex shader
//
// $Id: post_film_vs11.vs,v 1.2 2005/06/30 10:23:22 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////
#include "lib.fx"


struct VS_OUTPUT
{
    float4 TexCoordA  : TEXCOORD0;
    float4 TexCoordB  : TEXCOORD1;
    float4 TexCoordC  : TEXCOORD2;
    float4 TexCoordD  : TEXCOORD3;
};


float4 	TimeShift: register( c0 );
float4  FrameVis: register( c1 );

VS_OUTPUT VS_Film( float4 Position : POSITION, float4 TexCoord : TEXCOORD0, out float4 outPos : POSITION )
{
    const float4 con = {1.f , 0.5f ,1.f, 1.0f };
    outPos = Position;

    VS_OUTPUT  OUT; 
     

    OUT.TexCoordB = TexCoord * FrameVis.x + ( (1.f - FrameVis.x) / 2 );

    OUT.TexCoordC = TexCoord;

    OUT.TexCoordD = TexCoord;

    float tmp = TexCoord.y + frac( TimeShift );
    OUT.TexCoordD.y = tmp;
	
    OUT.TexCoordA = OUT.TexCoordD * con;
	
    return OUT;
}