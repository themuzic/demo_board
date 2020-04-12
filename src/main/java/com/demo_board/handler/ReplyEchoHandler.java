package com.demo_board.handler;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.demo_board.model.domain.Member;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class ReplyEchoHandler extends TextWebSocketHandler{
//	thread-safe collections
//	List<WebSocketSession> connectedSessions = Collections.synchronizedList(new ArrayList<>());
//	Map<K,V> map = new ConcurrentHashMap<K,V>();
//	Queue<E> queue = new ConcurrentQueue<E>();
	
//	List<WebSocketSession> connectedSessions = new ArrayList<>();
	private Map<String, WebSocketSession> userSessions = new ConcurrentHashMap<>();
	// client가 서버에 접속 했을 때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String senderId = getUserId(session);
		userSessions.put(senderId, session);
	}
	
	// message를 보냈을 때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		String senderId = getUserId(session);
//		for(String key : connectedSessions.keySet()) {
//			connectedSessions.get(key).sendMessage(new TextMessage(senderId + ": " + message.getPayload()));
//		}
		// protocol: cmd,댓글작성자,게시글작성자,게시글번호 (ex: reply,user2,user1,234)
		JsonObject jsonObj = (JsonObject) JsonParser.parseString(message.getPayload());;
		
		if(jsonObj != null) {
			String boardWriter = jsonObj.get("boardWriter").getAsString();
			WebSocketSession boardWriterSession = userSessions.get(boardWriter);
			if(jsonObj.get("cmd").getAsString().equals("reply") && boardWriterSession != null) {
				TextMessage tempMsg = new TextMessage("<input type='hidden' id='goNumber' value='"+jsonObj.get("boardNo").getAsInt()+"'>"+
						jsonObj.get("replyWriter").getAsString()+"님이 댓글을 작성했습니다.");
				boardWriterSession.sendMessage(tempMsg);
			}
		}
	}
	
	private String getUserId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		Member user = (Member)httpSession.get("loginUser");
		if(user != null) {
			return String.valueOf(user.getId());
		} else {
			return session.getId();
		}
	}

	// 연결이 close됐을 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		super.afterConnectionClosed(session, status);
	}
	
}
