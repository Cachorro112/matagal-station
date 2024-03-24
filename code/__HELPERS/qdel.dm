// This is a bit hacky, we do it to avoid people relying on a return value for the macro
// If you need that you should use QDEL_IN_STOPPABLE instead
#define QDEL_IN(item, time) ; \
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(qdel), (time) > GC_FILTER_QUEUE ? WEAKREF(item) : item), time);
#define QDEL_IN_STOPPABLE(item, time) addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(qdel), (time) > GC_FILTER_QUEUE ? WEAKREF(item) : item), time, TIMER_STOPPABLE)
#define QDEL_IN_CLIENT_TIME(item, time) addtimer(CALLBACK(GLOBAL_PROC, PROC_REF(qdel), item), time, TIMER_STOPPABLE | TIMER_CLIENT_TIME)
#define QDEL_NULL(item) qdel(item); item = null
#define QDEL_LIST(L) if(L) { for(var/I in L) qdel(I); L.Cut(); }
#define QDEL_LIST_IN(L, time) addtimer(CALLBACK(GLOBAL_PROC, PROC_REF(______qdel_list_wrapper), L), time, TIMER_STOPPABLE)
#define QDEL_LIST_ASSOC(L) if(L) { for(var/I in L) { qdel(L[I]); qdel(I); } L.Cut(); }
#define QDEL_LIST_ASSOC_VAL(L) if(L) { for(var/I in L) qdel(L[I]); L.Cut(); }

/proc/______qdel_list_wrapper(list/L) //the underscores are to encourage people not to use this directly.
	QDEL_LIST(L)
