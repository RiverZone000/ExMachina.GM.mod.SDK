//////////////////////////////////////////////////////////////////////////////
//
// Workfile: post_film_ps11sp.asm
// Created by: Goryh
//
// Old film effect vertex shader SPECIAL EDITION
//	(for cards with D3DPTEXTURECAPS_NONPOW2CONDITIONAL caps flag )
//
// $Id: post_film_ps11sp.asm,v 1.1 2005/07/28 09:07:27 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////

ps_1_1

def c1, 0.3f, 0.59f, 0.11f, 1.0f

tex t0		// shift
tex t1		// frame
tex t2		// scrach
tex t3		// original image

dp3 r0, t3, c1		// apply color transform to get luminance
mul r0, r0, c2
lrp r0, c3, r0, t3	// interpolate between normal and sepia scene

mul r0, r0, t1
mul r0, r0, t2
mul r0, r0, c0