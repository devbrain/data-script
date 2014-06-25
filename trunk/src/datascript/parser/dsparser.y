%token_type {int}  
   
%left PLUS MINUS.   
%left DIVIDE TIMES.  
      
%include {   
#include <stdio.h>  
#include <assert.h>

#if defined (__clang__)
#pragma clang diagnostic ignored "-Wunused-macros"
#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wunused-parameter"

#elif defined(__GNUC__) 
	#if (__GNUC__ >= 4) && (__GNUC_MINOR__ >= 6)
		#pragma GCC diagnostic ignored "-Wmissing-prototypes"
		#pragma GCC diagnostic ignored "-Wunused-parameter"	
	#endif
#endif


}  
    

     
%syntax_error {  
   printf( "Syntax error!\n");
}   
	      
program ::= expr(A).   { printf ( "Result=%d\n", A);}
	         
expr(A) ::= expr(B) MINUS  expr(C).   { A = B - C; }  
expr(A) ::= expr(B) PLUS  expr(C).   { A = B + C; }  
expr(A) ::= expr(B) TIMES  expr(C).   { A = B * C; }  
expr(A) ::= expr(B) DIVIDE expr(C).  { 

	          if(C != 0){
		             A = B / C;
	               }else{
	                  printf( "divide by zero\n");
	             }
}  /* end of DIVIDE */

expr(A) ::= INTEGER(B). { A = B; } 

