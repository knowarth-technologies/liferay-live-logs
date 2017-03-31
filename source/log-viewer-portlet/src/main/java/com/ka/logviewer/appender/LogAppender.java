package com.ka.logviewer.appender;

import java.io.IOException;

import org.apache.log4j.AppenderSkeleton;
import org.apache.log4j.Layout;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.spi.LoggingEvent;

import com.ka.logviewer.websocket.LogViewerWebSocket;
import com.liferay.portal.kernel.util.StringUtil;

public class LogAppender extends AppenderSkeleton {

	@Override
	public void close() {
		this.closed = true;
	}

	@Override
	public boolean requiresLayout() {
		return true;
	}
	
	@Override
	public void setLayout(Layout layout) {
		
		super.setLayout(layout);
	}

	@Override
	protected void append(LoggingEvent event) {
		Layout appLayout = new PatternLayout("%d{ABSOLUTE} %-5p [%c{1}:%L] %m%n");
		String message = appLayout.format(event);
		try {
			LogViewerWebSocket.socket_session.getBasicRemote().sendText(message);
			if(event.getThrowableInformation() != null) {
				LogViewerWebSocket.socket_session.getBasicRemote().sendText(
						StringUtil.merge(event.getThrowableStrRep(),"</br>"));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
