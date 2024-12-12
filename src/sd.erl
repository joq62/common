%%%-------------------------------------------------------------------
%%% @author c50 <joq62@c50>
%%% @copyright (C) 2024, c50
%%% @doc
%%%
%%% @end
%%% Created : 11 Jan 2024 by c50 <joq62@c50>
%%%-------------------------------------------------------------------
-module(sd).
  

 
%% API


-export([
	 call_control/2,
	 cast_control/1,
	 cast/2,
	 call/3
	 
	]).

%%%===================================================================
%%% API
%%%===================================================================
%%--------------------------------------------------------------------
%% @doc
%% 
%% @end
%%--------------------------------------------------------------------
call_control(Msg,TimeOut)->
     {ok,Hostname}=net:gethostname(),
    ControlId=list_to_atom(atom_to_list(control)++"@"++Hostname),
    case global:whereis_name(ControlId) of
	undefined->
	    {error,[undefined,ControlId]};
	Pid->
	    Self=self(),
	    Pid!{Self,Msg},
	    receive
		{Pid,Reply}->
		    Reply
	    after 
		TimeOut ->
		    {error,["Timeout in call",ControlId,Msg,TimeOut]}
	    end
    end.

%%--------------------------------------------------------------------
%% @doc
%% 
%% @end
%%--------------------------------------------------------------------
cast_control(Msg)->
     {ok,Hostname}=net:gethostname(),
    ControlId=list_to_atom(atom_to_list(control)++"@"++Hostname),
    case global:whereis_name(ControlId) of
	undefined->
	    {error,[undefined,ControlId]};
	Pid->
	    Self=self(),
	    Pid!{Self,Msg},
	    true
    end.

%%--------------------------------------------------------------------
%% @doc
%% 
%% @end
%%--------------------------------------------------------------------
call(ServerId,Msg,TimeOut)->
    case global:whereis_name(ServerId) of
	undefined->
	    {error,[undefined,ServerId]};
	Pid->
	    Self=self(),
	    Pid!{Self,Msg},
	    receive
		{Pid,Reply}->
		    Reply
	    after 
		TimeOut ->
		    {error,["Timeout in call",ServerId,Msg,TimeOut]}
	    end
    end.

%%--------------------------------------------------------------------
%% @doc
%% 
%% @end
%%--------------------------------------------------------------------
cast(ServerId,Msg)->
    Self=self(),
    case rpc:cast(node(),global,send,[ServerId,{Self,Msg}]) of
	{badrpc,Reason}->
	    {error,[?MODULE,?LINE,badrpc,Reason]};
	Result->
	    Result
    end.



%%%===================================================================
%%% Internal functions
%%%===================================================================
