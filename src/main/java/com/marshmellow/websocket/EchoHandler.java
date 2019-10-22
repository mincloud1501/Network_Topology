package com.marshmellow.websocket;

import java.util.ArrayList;
import java.util.List;

import com.marshmellow.example.VO.ChatVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler {
	private Logger logger = LoggerFactory.getLogger(EchoHandler.class);

	/**
	 * 서버에 연결한 사용자들을 저장하는 리스트.
	 */
	private List<WebSocketSession> connectedUsers;

	public EchoHandler() {
		connectedUsers = new ArrayList<WebSocketSession>();
	}

	/**
	 * 접속과 관련되어 있는 Event Method
	 *
	 * @param WebSocketSession
	 *            접속한 사용자
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		// 서버에 접속한 사용자를 제한함
		if (connectedUsers.size() > 4) {
			session.close();
			return;
		}

		logger.info(session.getLocalAddress().getHostName() + "님이 접속했습니다.");
		logger.info("연결 IP : " + session.getLocalAddress().getAddress());
		connectedUsers.add(session);
	}

	/**
	 * 두 가지 이벤트를 처리함. 1. Send : client -> server로 메시지를 보냄 2. Emit : server ->
	 * all client로 메시지를 보냄
	 *
	 * @param WebSocketSession
	 *            메시지를 보낸 클라이언트
	 * @param TextMessage
	 *            메시지의 내용
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// convertMessage는 ChatVO의 메소드
		// 파라미터로 넘어온 JSON 타입의 데이터를 자바 객체로 넣어주는 역활을 한다.
		ChatVO chatVO = ChatVO.convertMessage(message.getPayload());
		String hostName = "";

		for (WebSocketSession webSocketSession : connectedUsers) {
			if (chatVO.getType().equals("all")) {
				if (!session.getId().equals(webSocketSession.getId())) {
					webSocketSession.sendMessage(new TextMessage(
							session.getRemoteAddress().getHostName() + " -> " ));
				}
			}
			// 귓속말 전송
			else {
				hostName = webSocketSession.getRemoteAddress().getHostName();
				if (chatVO.getTo().equals(hostName)) {
					webSocketSession.sendMessage(new TextMessage("<span style='color:red;'>"
							+ session.getRemoteAddress().getHostName() + " -> " + "</span>"));
					break;
				}
			}
		}
	}

	/**
	 * 클라이언트가 서버와 연결을 끊음.
	 *
	 * @param WebSocketSession
	 *            연결을 끊은 클라이언트
	 * @param CloseStatus
	 *            연결 상태 (확인 필요함..)
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		connectedUsers.remove(session);
		for (WebSocketSession webSocketSession : connectedUsers) {
			if (!session.getId().equals(webSocketSession.getId())) {
				webSocketSession
						.sendMessage(new TextMessage(webSocketSession.getRemoteAddress().getHostName() + "퇴장했습니다."));
			}
		}
		logger.info(session.getId() + "님이 퇴장했습니다.");
	}
}