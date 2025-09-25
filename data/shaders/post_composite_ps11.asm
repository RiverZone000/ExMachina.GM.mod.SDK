//////////////////////////////////////////////////////////////////////////////
//
// Workfile: post_composite_ps11.asm
// Created by: Goryh
//
// Composite final image
//
// $Id: post_composite_ps11.asm,v 1.1 2005/05/23 08:32:27 goryh Exp $
//
//////////////////////////////////////////////////////////////////////////////

ps_1_1
					

tex t0
tex t1
	
			
mul r0, t1, c1
			
mad r0, t0, c0, r0

			
mul_x2 r1, c2, t1.w
add r0, r0, r1