/* This file is part of Zenroom (https://zenroom.dyne.org)
 *
 * Copyright (C) 2017-2019 Dyne.org foundation
 * designed, written and maintained by Denis Roio <jaromil@dyne.org>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 */

#ifndef __ZEN_BIG_TYPES_H__
#define __ZEN_BIG_TYPES_H__
#include <arch.h>

#include <fp12_BLS48.h>
// cascades includes for big_ fp_ fp2_ and fp4_

// instance is in rom_field_XXX.c and included by fp_XXX.h
#define Modulus Modulus_BLS48
#define CURVE_Gx CURVE_Gx_BLS48
#define CURVE_Gy CURVE_Gy_BLS48
#define Montgomery MConst_BLS48 // 0x73435FD from rom_field_BLS48 at 32bit
#if BIGSIZE == 560
// #pragma message "BIGnum CHUNK size: 32bit"
//#include <big_560_29.h>
#define BIG  BIG_560_29
#define DBIG DBIG_560_29
#define MODBYTES MODBYTES_560_29
#define BIGLEN NLEN_560_29
#define DBIGLEN DNLEN_560_29
#define BIG_zero(b) BIG_560_29_zero(b)
#define BIG_fromBytesLen(b,v,l) BIG_560_29_fromBytesLen(b,v,l)
#define BIG_inc(b,n) BIG_560_29_inc(b,n)
#define BIG_norm(b) BIG_560_29_norm(b)
#define BIG_nbits(b) BIG_560_29_nbits(b)
#define BIG_copy(b,a) BIG_560_29_copy(b,a)
#define BIG_rcopy(b,a) BIG_560_29_rcopy(b,a)
#define BIG_shl(b,a) BIG_560_29_shl(b,a)
#define BIG_shr(b,a) BIG_560_29_shr(b,a)
#define BIG_fshl(b,a) BIG_560_29_fshl(b,a)
#define BIG_fshr(b,a) BIG_560_29_fshr(b,a)
#define BIG_dshl(b,a) BIG_560_29_dshl(b,a)
#define BIG_dshr(b,a) BIG_560_29_dshr(b,a)
#define BIG_parity(b) BIG_560_29_parity(b)
#define BIG_isunity(b) BIG_560_29_isunity(b)
#define BIG_toBytes(b,a) BIG_560_29_toBytes(b,a)
#define BIG_comp(l,r) BIG_560_29_comp(l,r)
#define BIG_add(d,l,r) BIG_560_29_add(d,l,r)
#define BIG_sub(d,l,r) BIG_560_29_sub(d,l,r)
#define BIG_mul(d,l,r) BIG_560_29_mul(d,l,r)
#define BIG_mod(x,n) BIG_560_29_mod(x,n)
#define BIG_invmodp(x,y,n) BIG_560_29_invmodp(x,y,n)
#define BIG_monty(d,m,c,s) BIG_560_29_monty(d,m,c,s)
// #define BIG_dmod(a,b,c) BIG_560_29_dmod(a,b,c)
#define BIG_sdiv(x,n) BIG_560_29_sdiv(x,n)
#define BIG_ddiv(d,l,r) BIG_560_29_ddiv(d,l,r)
#define BIG_modmul(x,y,z,n) BIG_560_29_modmul(x,y,z,n)
#define BIG_moddiv(x,y,z,n) BIG_560_29_moddiv(x,y,z,n)
#define BIG_modsqr(x,y,n) BIG_560_29_modsqr(x,y,n)
#define BIG_modneg(x,y,n) BIG_560_29_modneg(x,y,n)
#define BIG_jacobi(x,y) BIG_560_29_jacobi(x,y)
#define BIG_random(m,r) BIG_560_29_random(m,r)
#define BIG_randomnum(m,q,r) BIG_560_29_randomnum(m,q,r)

#define BIG_sqr(x,y) BIG_560_29_sqr(x,y);
#define BIG_dcopy(d,s) BIG_560_29_dcopy(d,s)
#define BIG_sducopy(d,s) BIG_560_29_sducopy(d,s)
#define BIG_sdcopy(d,s) BIG_560_29_sdcopy(d,s)
#define BIG_dnorm(x) BIG_560_29_dnorm(x)
#define BIG_dcomp(l,r) BIG_560_29_dcomp(l,r)
#define BIG_dscopy(d,s) BIG_560_29_dscopy(d,s)
#define BIG_dsub(d,l,r) BIG_560_29_dsub(d,l,r)
#define BIG_dadd(d,l,r) BIG_560_29_dadd(d,l,r)
#define BIG_dmod(d,l,r) BIG_560_29_dmod(d,l,r)
#define BIG_dfromBytesLen(d,o,l) BIG_560_29_dfromBytesLen(d,o,l)
#define BIG_dzero(d) BIG_560_29_dzero(d)
#define BIG_dnbits(d) BIG_560_29_dnbits(d)

#define FP FP_BLS48
#define FP_copy(d,s) FP_BLS48_copy(d,s)
#define FP_redc(x,y) FP_BLS48_redc(x,y)
#define FP_reduce(x) FP_BLS48_reduce(x)
#define FP_mod(d,s) FP_BLS48_mod(d,s)

#define FP12 FP12_BLS48
/* #define FP12_zero(b) FP12_BLS48_zero(b) */
#define FP12_copy(d,s) FP12_BLS48_copy(d,s)
#define FP12_eq(l,r) FP12_BLS48_equals(l,r)
/* #define FP12_cmove(d,s,c) FP12_BLS48_cmove(d,s,c) */
#define FP12_fromOctet(f,o) FP12_BLS48_fromOctet(f,o)
#define FP12_toOctet(o,f) FP12_BLS48_toOctet(o,f)
#define FP12_mul(l, r) FP12_BLS48_mul(l, r)
/* #define FP12_imul(d, l, r) FP12_BLS48_imul(d, l, r) */
#define FP12_sqr(d, s) FP12_BLS48_sqr(d, s)
/* #define FP12_add(d, l, r) FP12_BLS48_add(d, l, r)
#define FP12_sub(d, l, r) FP12_BLS48_sub(d, l, r) */
#define FP12_div2(d, s) FP12_BLS48_div2(d,s)
#define FP12_pow(r, x, b) FP12_BLS48_pow(r,x,b)
// #define FP12_pinpow(r, x, b) FP12_BLS48_pinpow(r,x,b)

// #define FP12_sqrt(d,s) FP12_BLS48_sqrt(d,s)
// #define FP12_neg(d,s) FP12_BLS48_neg(d,s)
// #define FP12_reduce(f) FP12_BLS48_reduce(f)
// #define FP12_norm(f) FP12_BLS48_norm(f)
// #define FP12_qr(f) FP12_BLS48_qr(f)
#define FP12_inv(d,s) FP12_BLS48_inv(d,s)

#endif // _H_
