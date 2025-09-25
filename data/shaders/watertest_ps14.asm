//////////////////////////////////////////////////////////////////////////////
//
// Workfile: waterTest_ps14.asm
// Created by: Plus
//
// simple water ps14 shader w/ reflection/refraction 
// and per-vertex fresnel term
//
// (I have failed to archive it using hlsl...)
//
// $Id: waterTest_ps14.asm,v 1.6 2005/07/26 05:47:06 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////

ps_1_4

def 	c0, 0.015, 2,  0, 0
def 	c1, 0.015, 0, 0, 0
def     c2, 0.05156950672, 0.05156950672, 0, 0
def 	c3, 0.14, 0.14, 0.86, 1
def 	c4, 0.85, 1, 1, 1
def 	c7, -0.5, -0.5, 0, 0

// dsdt reflection
texld	r0, t0

// dsdt refraction
texld	r1, t1

// projective coords
texcrd	r2.xy, t2_dw.xyw
texcrd  r3.xy, t3_dw.xyw


// perturb reflection and refraction coords by constant displacement
mad     r1.xy, r1, c0.y, c7
mad     r0.xy, r0, c0.y, c7

add     r2.xy, r2, c2

mad	r4.xy, r1, c1.x, r3
mad	r0.xy, r0, c0.x, r2


// stuff something into z so that texld will deal
mov	r0.z, c0.x
mov	r4.z, c0.x

phase

texld	r2, r0		// refraction
texld	r3, r4		// reflection

// tint reflection
mul	r2.rgb, r2, c5
// tint refraction
mul	r3.rgb, r3, c6

//lrp	r1, c4.r, r2, c3
//lrp	r0, v0, r1, r3	// lerp( reraction, reflection, fresnel )

lrp	r0, v0, r2, r3	// lerp( reraction, reflection, fresnel )