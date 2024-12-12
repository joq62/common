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
call(ServerId,Msg,TimeOut)->
    Self=self(),
    case rpc:call(node(),global,send,[ServerId,{Self,Msg}],5000) of
	{badrpc,Reason}->
	    {error,[?MODULE,?LINE,badrpc,Reason]};
	Pid ->
	    ok,
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