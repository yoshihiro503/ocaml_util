##########################
#                        #
# Libraries definitions. #
#                        #
##########################

OCAMLLIBS:=-I .

##########################
#                        #
# Variables definitions. #
#                        #
##########################

CAMLLIB:=$(shell $(CAMLBIN)ocamlc.opt -where)
CAMLC:=$(CAMLBIN)ocamlc.opt -c
CAMLOPTC:=$(CAMLBIN)ocamlopt.opt -c
CAMLLINK:=$(CAMLBIN)ocamlc.opt
CAMLOPTLINK:=$(CAMLBIN)ocamlopt.opt

###################################
#                                 #
# Definition of the "all" target. #
#                                 #
###################################

MLFILES:=fromCoq.ml\
  util.ml
CMOFILES:=$(MLFILES:.ml=.cmo)
CMOFILES0:=$(filter-out ,$(CMOFILES))
CMIFILES:=$(MLFILES:.ml=.cmi)
CMIFILES0:=$(filter-out ,$(CMIFILES))
CMXFILES:=$(MLFILES:.ml=.cmx)
CMXSFILES:=$(MLFILES:.ml=.cmxs)
CMXSFILES0:=$(filter-out ,$(CMXSFILES))
OFILES:=$(MLFILES:.ml=.o)

all: $(CMOFILES) $(CMXSFILES) 
####################
#                  #
# Special targets. #
#                  #
####################

.PHONY: all opt byte archclean clean install depend html

%.cmi: %.mli
	$(CAMLC) $(ZDEBUG) $(ZFLAGS) $<

%.cmo: %.ml
	$(CAMLC) $(ZDEBUG) $(ZFLAGS) $(PP) $<

%.cmx: %.ml
	$(CAMLOPTC) $(ZDEBUG) $(ZFLAGS) $(PP) $<

%.cmxs: %.ml
	$(CAMLOPTLINK) $(ZDEBUG) $(ZFLAGS) -shared -o $@ $(PP) $<

%.cmo: %.ml4
	$(CAMLC) $(ZDEBUG) $(ZFLAGS) $(PP) -impl $<

%.cmx: %.ml4
	$(CAMLOPTC) $(ZDEBUG) $(ZFLAGS) $(PP) -impl $<

%.cmxs: %.ml4
	$(CAMLOPTLINK) $(ZDEBUG) $(ZFLAGS) -shared -o $@ $(PP) -impl $<

%.ml.d: %.ml
	$(CAMLBIN)ocamldep -slash $(OCAMLLIBS) $(PP) "$<" > "$@"

byte:
	$(MAKE) all "OPT:=-byte"

opt:
	$(MAKE) all "OPT:=-opt"

clean:
	rm -f $(CMOFILES) $(CMIFILES) $(CMXFILES) $(CMXSFILES) $(OFILES) $(MLFILES:.ml=.cmo) $(MLFILES:.ml=.cmx) *~
	rm -f $(CMOFILES) $(MLFILES:.ml=.cmi) $(MLFILES:.ml=.ml.d) $(MLFILES:.ml=.cmx) $(MLFILES:.ml=.o)
	$(MAKE) -f Makefile.coq clean

archclean:
	rm -f *.cmx *.o

-include $(MLFILES:.ml=.ml.d)
.SECONDARY: $(MLFILES:.ml=.ml.d)


#ocamldoc (HTML)
html: fromCoq.cmi util.cmi
	mkdir -p doc
	ocamldoc -d doc -html fromCoq.mli util.mli


# Verification (optional)
Makefile.coq: Make.coq
	mv -f Makefile.coq Makefile.coq.bak
	$(COQBIN)coq_makefile -f Make.coq -o Makefile.coq

verification: Makefile.coq
	$(MAKE) -f Makefile.coq
	mv coq/fromCoq.ml coq/fromCoq.mli ./
