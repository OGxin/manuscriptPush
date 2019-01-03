<%@page import="com.trs.fz.Utils"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.trs.components.wcm.content.persistent.Channel"%>
<%@page import="java.util.List"%>
<%@page import="com.trs.infra.util.CMyString"%>
<%@page import="com.trs.infra.util.MD5"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.IOException"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.trs.components.wcm.content.persistent.WebSite" %>
<%@include file="public_server_nologin.jsp"%>
<%
	final String channelCode = "";
	String msg = "";
	
	
	Properties properties = new Properties();
	FileInputStream in = null;
	try {
		in = new FileInputStream(this.getClass().getResource("/").getPath()+"com/trs/fz/hznews.properties");
		properties.load(in);
	} catch (FileNotFoundException e1) {
		e1.printStackTrace();
	} catch (IOException e) {
		e.printStackTrace();
	} finally {
		try {
	if(in!=null){
		in.close();
	}
		} catch (IOException e) {
	e.printStackTrace();
		}
	}
	StringBuffer result = new StringBuffer();
		String websiteid = properties.getProperty("websiteid", "");
		String channelid = properties.getProperty("channelid", "");
		
		if(!"".equals(websiteid)){
	WebSite webSite = WebSite.findById(Integer.parseInt(websiteid));
	List channels = webSite.getChildren(loginUser);
	result.append("{columns:["+Utils.channelTree(channels, loginUser, 0)+"]}");
	msg = result.toString();
		} else {
		result.append("{columns:[");
	if(!"".equals(channelid)){
		String[] channelids=channelid.split(",");
		for(int i=0;i<channelids.length;i++){
		Channel channel = Channel.findById(Integer.parseInt(channelids[i]));
		List channels = channel.getChildren(loginUser);
		result.append(Utils.channelTree(channels, loginUser, 0));
		if(i!=channelids.length-1){
			result.append(",");
		}
		}
		result.append("]}");
		msg = result.toString();
	} else {
		msg = "{\"success\":false,\"msg\":\"CHANNELID OR WEBSITEID IS NOT SET\"}";
	}
		}
	

		out.print(msg);
%>