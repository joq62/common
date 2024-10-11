%%% -------------------------------------------------------------------
%%% @author  : Joq Erlang
%%% @doc: : 
%%% Created :
%%% Node end point  
%%% Creates and deletes Pods
%%% 
%%% API-kube: Interface 
%%% Pod consits beams from all services, app and app and sup erl.
%%% The setup of envs is
%%% -------------------------------------------------------------------
-module(all).      
 
-export([start/0]).


-define(GitPath,"https://github.com/joq62/application_specs.git").
-define(RepoDir,"application_specs").

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include("log.api").
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME,?LINE}]),
    
    ok=setup(),
    ok=test1(),
    


    timer:sleep(2000),
    io:format("Test OK !!! ~p~n",[?MODULE]),
    rpc:call(node(),init,stop,[],5000),
    timer:sleep(4000),
    init:stop(),
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test1()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
  
    lib_git:delete(?RepoDir),
    {error,["RepoDir doesnt exists, need to clone"]}=lib_git:is_repo_updated(?RepoDir),
    ok=lib_git:clone(?GitPath),
    true=lib_git:is_repo_updated(?RepoDir),
    {error,["Failed to clone ","https://github.com/joq62/application_specs.git"]}=lib_git:clone(?GitPath),
    true=lib_git:is_repo_updated(?RepoDir),
    {error,["Failed to clone ","https://github.com/joq62/glurk.git"]}=lib_git:clone("https://github.com/joq62/glurk.git"),
    
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------

setup()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),

    ok.
