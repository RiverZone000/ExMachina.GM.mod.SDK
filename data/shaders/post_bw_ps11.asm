//////////////////////////////////////////////////////////////////////////////
//
// Workfile: post_bw_ps11.asm
// Created by: Plus
//
// Converts colored scene to black'n'white
//
// (I have failed to archive it using hlsl...)
//
// $Id: post_bw_ps11.asm,v 1.2 2005/05/23 08:32:27 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////


// c0 - effect intensity

ps_1_1

//
def c1, 0.3f, 0.59f, 0.11f, 1.0f
//def c2, 0.9f, 0.7f, 0.3f, 1.0f

tex t0			// sample scene texture
dp3 r0, t0, c1		// apply color transform to get luminance
mul r0, r0, c2
lrp r0, c0, r0, t0	// interpolate between normal and B&W scene