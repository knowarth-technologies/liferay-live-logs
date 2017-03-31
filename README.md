# Live Logs
Viewing logs in Linux systems is a tedious task for Liferay developers. As you need to request for credentials from the clients. 
And even after you receive it, as a developer you are expected to go through complete coding to search for errors and can’t save logs that you have checked. 
We have attempted to solve this tricky issue with our custom plug-in development for Liferay.

## Problem

Developers always need access to view Server Logs to troubleshoot issues and errors in production environment. It is risky, time consuming and inconvenient to allow full server access to each developer.
Also, it is difficult to search for each log and their entries and filtering them to solve issues. And It becomes necessary for developers to possess working knowledge of Linux Systems to view and save log data.

## Solution

At KNOWARTH, we have developed a plug-in which allows developers to bypass the whole logging in process and view the Logs. Moreover, a developer can also download logs, search for entries through Log levels and start, stop, clear all log searches within the server.
The Plug-in can be directly accessed through Control Panel. Also, it does not require server credentials to log in and fetch information. These are the features of Log Viewer Plugin: 
1.	Real time log check by applying filters for all log levels (Error, Debug, Info, Trace, All etc.)
2.	Stop and start scroll at any point of time during log session is in on.
3.	Log file download
4.	Word search to locate errors and issues
5.	Previous/Next occurrences in case of multiple find while searching
6.	Supports for http & https

## Deployment steps

1.	Stop the Liferay server
2.	Copy the below jars to the deploy directory of Liferay server
      * log.viewer.portlet-1.0.0.jar
      * com.liferay.websocket.whiteboard-1.0.0.jar
3.	Add below property in portal-ext file.
```
    module.framework.system.packages.extra=\
    com.ibm.crypto.provider,\
    com.ibm.db2.jcc,\
    com.microsoft.sqlserver.jdbc,\
    com.mysql.jdbc,\
    com.p6spy.engine.spy,\
    com.sun.security.auth.module,\
    com.sybase.jdbc4.jdbc,\
    oracle.jdbc,\
    org.postgresql,\
    org.apache.naming.java,\
    org.hsqldb.jdbc,\
    org.mariadb.jdbc,\
    sun.misc,\
    sun.net.util,\
    sun.security.provider,\
    javax.websocket;version="1.1.0",\
    javax.websocket.server;version="1.1.0"
```
4.	Start the server.

By following these easy steps of Plug-in installation, you will be able to view all the system logs as per your convenience and server requirements. 

## Support
Please feel free to contact us on contact@knowarth.com for any issue/suggestions. You can report issues through [Github issues](https://github.com/knowarth-technologies/liferay-live-logs/issues)
