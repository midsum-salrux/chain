/-  cw=clockwork
/+  dbug
|%
+$  versioned-state
$%  state-0
==
+$  state-0
$:  %0
    start-time=@da
    count=@ud
    stop=$~(%.y ?)
==
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
+*  this      .
    hd  ~(. +> bowl)
::
++  on-leave  |~(* `this)
++  on-fail   |~(* `this)
++  on-save   !>(state)
++  on-load   |=  old-state=vase
  =/  prev  !<(state-0 old-state)
  [~ this(state prev)]
++  on-init  [~ this]
++  on-peek  |=(=(pole knot) ~)
++  on-poke
  |=  [=mark =vase]
  ?.  .=(src.bowl our.bowl)  [~ this]
  ?.  ?=(%noun mark)  [~ this]
  ?+  q.vase  [~ this]
      [%start @da]
    :-  :~((timer-card +.q.vase))
    this(stop %.n, start-time +.q.vase, count 0)
      %stop
    [~ this(stop %.y)]
  ==
  ::
++  on-watch
  |=  =(pole knot)
  ~&  ["clockstep: on-watch" pole]
  :: Only allow %tick subscriptions from our own %clockwork agent
  ?.  .=(src.bowl our.bowl)  !!
  ?.  .=(/gall/clockwork sap.bowl)  !!
  ?.  ?=([%tick ~] pole)  !!  [~ this]
++  on-agent  |=([=wire =sign:agent:gall] [~ this])
++  on-arvo
  |=  [=(pole knot) =sign-arvo]
  ?.  ?=(%behn -.sign-arvo)  [~ this]
  ?+  pole  [~ this]
      [%delta ~]
    ?:  stop  [~ this]
    ?:  (gth (add start-time (mul delta:cw +(count))) now.bowl)
      :_  this(count +(count))
      ~[fact-card:hd (timer-card:hd (add start-time (mul delta:cw count)))]
    =/  new-count  (div (sub now.bowl start-time) delta:cw)
    :_  this(count new-count)
    ~[fact-card:hd (timer-card:hd (add start-time (mul delta:cw new-count)))]
  ==
--
|_  =bowl:gall
++  timer-card
  |=  =time  ^-  card
  [%pass /delta %arvo %b %wait (add delta:cw time)]
++  fact-card  ^-  card
  [%give %fact ~[/tick] [%noun !>(count)]]
--
