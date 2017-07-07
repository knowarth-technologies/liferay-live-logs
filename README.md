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

### Environment

* Server: Liferay CE 7.0 GA4
* Java:   JDK 1.8

By deploying this plugin you will be able to view all the system logs as per your convenience and server requirements. 

## Support
Please feel free to contact us on contact@knowarth.com for any issue/suggestions. You can report issues through [Github issues](https://github.com/knowarth-technologies/liferay-live-logs/issues)
