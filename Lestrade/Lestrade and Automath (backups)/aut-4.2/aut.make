#   File:       aut.make
#   Target:     aut
#   Sources:    alloc.c
#               check.c
#               compile.c
#               domain.c
#               excerpt.c
#               exp.c
#               ident.c
#               item.c
#               main.c
#               par.c
#               parse.c
#               print.c
#               same.c
#               scan.c
#               type.c
#               value.c
#   Created:    Thursday, January 7, 1999 09:31:21 PM


MAKEFILE     = aut.make
�MondoBuild� = {MAKEFILE}  # Make blank to avoid rebuilds when makefile is modified
Includes     =
Sym�PPC      = 
ObjDir�PPC   =
Sym�68K      = 
ObjDir�68K   =

PPCCOptions  = {Includes} {Sym�PPC} -opt speed 

COptions     = {Includes} {Sym�68K} -model far 

Objects�PPC  = �
		"{ObjDir�PPC}alloc.c.x" �
		"{ObjDir�PPC}check.c.x" �
		"{ObjDir�PPC}compile.c.x" �
		"{ObjDir�PPC}domain.c.x" �
		"{ObjDir�PPC}excerpt.c.x" �
		"{ObjDir�PPC}exp.c.x" �
		"{ObjDir�PPC}ident.c.x" �
		"{ObjDir�PPC}item.c.x" �
		"{ObjDir�PPC}main.c.x" �
		"{ObjDir�PPC}par.c.x" �
		"{ObjDir�PPC}parse.c.x" �
		"{ObjDir�PPC}print.c.x" �
		"{ObjDir�PPC}same.c.x" �
		"{ObjDir�PPC}scan.c.x" �
		"{ObjDir�PPC}type.c.x" �
		"{ObjDir�PPC}value.c.x"

Objects�68K  = �
		"{ObjDir�68K}alloc.c.o" �
		"{ObjDir�68K}check.c.o" �
		"{ObjDir�68K}compile.c.o" �
		"{ObjDir�68K}domain.c.o" �
		"{ObjDir�68K}excerpt.c.o" �
		"{ObjDir�68K}exp.c.o" �
		"{ObjDir�68K}ident.c.o" �
		"{ObjDir�68K}item.c.o" �
		"{ObjDir�68K}main.c.o" �
		"{ObjDir�68K}par.c.o" �
		"{ObjDir�68K}parse.c.o" �
		"{ObjDir�68K}print.c.o" �
		"{ObjDir�68K}same.c.o" �
		"{ObjDir�68K}scan.c.o" �
		"{ObjDir�68K}type.c.o" �
		"{ObjDir�68K}value.c.o"


aut �� {�MondoBuild�} {Objects�PPC}
	PPCLink �
		-o {Targ} {Sym�PPC} �
		{Objects�PPC} �
		-t 'MPST' �
		-c 'MPS ' �
		"{SharedLibraries}InterfaceLib" �
		"{SharedLibraries}StdCLib" �
		"{SharedLibraries}MathLib" �
		"{PPCLibraries}StdCRuntime.o" �
		"{PPCLibraries}PPCCRuntime.o" �
		"{PPCLibraries}PPCToolLibs.o"


aut �� {�MondoBuild�} {Objects�68K}
	Link �
		-o {Targ} -d {Sym�68K} �
		{Objects�68K} �
		-t 'MPST' �
		-c 'MPS ' �
		-model far �
		"{Libraries}Stubs.o" �
		"{Libraries}MathLib.o" �
		#"{CLibraries}Complex.o" �
		"{CLibraries}StdCLib.o" �
		"{Libraries}MacRuntime.o" �
		"{Libraries}IntEnv.o" �
		"{Libraries}ToolLibs.o" �
		"{Libraries}Interface.o"


"{ObjDir�PPC}alloc.c.x" � {�MondoBuild�} alloc.c
	{PPCC} alloc.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}check.c.x" � {�MondoBuild�} check.c
	{PPCC} check.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}compile.c.x" � {�MondoBuild�} compile.c
	{PPCC} compile.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}domain.c.x" � {�MondoBuild�} domain.c
	{PPCC} domain.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}excerpt.c.x" � {�MondoBuild�} excerpt.c
	{PPCC} excerpt.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}exp.c.x" � {�MondoBuild�} exp.c
	{PPCC} exp.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}ident.c.x" � {�MondoBuild�} ident.c
	{PPCC} ident.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}item.c.x" � {�MondoBuild�} item.c
	{PPCC} item.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}main.c.x" � {�MondoBuild�} main.c
	{PPCC} main.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}par.c.x" � {�MondoBuild�} par.c
	{PPCC} par.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}parse.c.x" � {�MondoBuild�} parse.c
	{PPCC} parse.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}print.c.x" � {�MondoBuild�} print.c
	{PPCC} print.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}same.c.x" � {�MondoBuild�} same.c
	{PPCC} same.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}scan.c.x" � {�MondoBuild�} scan.c
	{PPCC} scan.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}type.c.x" � {�MondoBuild�} type.c
	{PPCC} type.c -o {Targ} {PPCCOptions}

"{ObjDir�PPC}value.c.x" � {�MondoBuild�} value.c
	{PPCC} value.c -o {Targ} {PPCCOptions}


"{ObjDir�68K}alloc.c.o" � {�MondoBuild�} alloc.c
	{C} alloc.c -o {Targ} {COptions}

"{ObjDir�68K}check.c.o" � {�MondoBuild�} check.c
	{C} check.c -o {Targ} {COptions}

"{ObjDir�68K}compile.c.o" � {�MondoBuild�} compile.c
	{C} compile.c -o {Targ} {COptions}

"{ObjDir�68K}domain.c.o" � {�MondoBuild�} domain.c
	{C} domain.c -o {Targ} {COptions}

"{ObjDir�68K}excerpt.c.o" � {�MondoBuild�} excerpt.c
	{C} excerpt.c -o {Targ} {COptions}

"{ObjDir�68K}exp.c.o" � {�MondoBuild�} exp.c
	{C} exp.c -o {Targ} {COptions}

"{ObjDir�68K}ident.c.o" � {�MondoBuild�} ident.c
	{C} ident.c -o {Targ} {COptions}

"{ObjDir�68K}item.c.o" � {�MondoBuild�} item.c
	{C} item.c -o {Targ} {COptions}

"{ObjDir�68K}main.c.o" � {�MondoBuild�} main.c
	{C} main.c -o {Targ} {COptions}

"{ObjDir�68K}par.c.o" � {�MondoBuild�} par.c
	{C} par.c -o {Targ} {COptions}

"{ObjDir�68K}parse.c.o" � {�MondoBuild�} parse.c
	{C} parse.c -o {Targ} {COptions}

"{ObjDir�68K}print.c.o" � {�MondoBuild�} print.c
	{C} print.c -o {Targ} {COptions}

"{ObjDir�68K}same.c.o" � {�MondoBuild�} same.c
	{C} same.c -o {Targ} {COptions}

"{ObjDir�68K}scan.c.o" � {�MondoBuild�} scan.c
	{C} scan.c -o {Targ} {COptions}

"{ObjDir�68K}type.c.o" � {�MondoBuild�} type.c
	{C} type.c -o {Targ} {COptions}

"{ObjDir�68K}value.c.o" � {�MondoBuild�} value.c
	{C} value.c -o {Targ} {COptions}

