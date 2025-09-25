//////////////////////////////////////////////////////////////////////////////
//
// Workfile: waterTest_ps11.asm
// Created by: Plus
//
// simple water ps11 shader w/ reflection/refraction 
// and per-vertex fresnel term
//
// (I have failed to archive it using hlsl...)
//
// $Id: waterTest_ps11.asm,v 1.8 2005/06/02 13:16:38 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////

ps_1_1

//tex 	t0	// ripple (reflection)
//tex 	t1	// ripple (refraction)
//texbem  t2, t0	// reflection
//texbem	t3, t1	// refraction
//lrp	r0, v0, t2, t3	// lerp( reraction, reflection, fresnel )


tex 	t0		// ripple (reflection)
tex 	t1		// ripple (refraction)
texbem  t2, t0		// reflection
texbem	t3, t1		// refraction
mul	r0, t2, c0      // c0 - reflection tint color
mul	r1, t3, c1	// c1 - refraction tint color
lrp_sat	r0, v0, r0, r1	// lerp( reraction, reflection, fresnel )
//mov	r0, t3


//tex 	t0	// ripple
//tex 	t1	// ripple
//texbem  t2, t0	// reflection
//texbem	t3, t1	// refraction
//lrp	r0, v0, t2, t3	// lerp( reraction, reflection, fresnel )
//mov r0, t1