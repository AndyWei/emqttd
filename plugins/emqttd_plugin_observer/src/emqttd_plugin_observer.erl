%%%-------------------------------------------------------------------
%%% @author ping
%%% @copyright (C) 2016, Joyy Inc. All rights reserved.
%%% @doc
%%%
%%% @end
%%% Created : 25. Apr 2016 8:35 PM
%%%-------------------------------------------------------------------

%% @doc emqttd plugin observer
-module(emqttd_plugin_observer).

-include("../../../include/emqttd.hrl").
-include("../../../include/emqttd_protocol.hrl").

-export([load/1, unload/0]).

%% Hooks functions
-export([on_message_publish/2]).

-define(KAFKA_TOPIC, <<"onlyu.im">>).
-define(LOG(Format, Args), lager:info("emqttd_plugin_observer: " ++ Format, Args)).

%% @doc invoked when the plugin start
load(Env) ->
    ?LOG("Observer load with Env - ~p", [Env]),
    emqttd:hook('message.publish', fun ?MODULE:on_message_publish/2, [Env]).

%% @doc invoked when the plugin stop
unload() ->
    ?LOG("Observer unload", 0),
    emqttd:unhook('message.publish', fun ?MODULE:on_message_publish/2).

%% Hooks
%% @doc observe the system messages
on_message_publish(Message = #mqtt_message{topic = <<"$SYS/", _/binary>>}, _Env) ->
    % do nothing
    {ok, Message};

%% @doc observe the will message
on_message_publish(Message = #mqtt_message{topic = <<"will">>}, _Env) ->
    % do nothing
    {ok, Message};

%% @doc observe the signaling message: online
on_message_publish(Message = #mqtt_message{topic = <<"$SIG/", _/binary>>}, _Env) ->
    % do nothing
    {ok, Message};

%% @doc observe the user messages
on_message_publish(Message, _Env) ->
    ?LOG("on_message_publish - ~p", [Message]),
    sink(Message),
    {ok, Message}.

%% Handlers
%% @doc sink message to kafka
sink(#mqtt_message{payload = Payload}) ->
    ok = ekaf:publish(?KAFKA_TOPIC, Payload),
    ok.