package com.demo_board;

import org.springframework.context.annotation.Configuration;

import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.demo_board.handler.ReplyEchoHandler;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer{

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(new ReplyEchoHandler(), "/replyEcho")
				.addInterceptors(new HttpSessionHandshakeInterceptor())
				.setAllowedOrigins("*");
	}

}
