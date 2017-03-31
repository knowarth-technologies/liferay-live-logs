package com.ka.logviewer.portlet;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.ka.logviewer.util.LogViewerConstants;
import com.liferay.application.list.BasePanelApp;
import com.liferay.application.list.PanelApp;
import com.liferay.application.list.constants.PanelCategoryKeys;
import com.liferay.portal.kernel.model.Portlet;

@Component(
		immediate = true,
		property = {
			"panel.app.order:Integer=500",
			"panel.category.key=" + PanelCategoryKeys.CONTROL_PANEL_CONFIGURATION
		},
		service = PanelApp.class
	)
public class LogViewerPanelApp extends BasePanelApp {

	@Override
	public String getPortletId() {
		return LogViewerConstants.PORTLET_NAME;
	}

	@Override
	@Reference(
			target = "(javax.portlet.name=" + LogViewerConstants.PORTLET_NAME + ")",
			unbind = "-"
		)
	public void setPortlet(Portlet portlet) {
		super.setPortlet(portlet);
	}
}
