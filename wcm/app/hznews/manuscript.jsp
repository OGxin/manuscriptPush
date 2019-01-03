<%@ page import="com.trs.fz.Utils"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.trs.infra.util.CMyString"%>
<%@page import="com.trs.infra.util.MD5"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.IOException"%>
<%@page import="com.trs.infra.common.WCMException"%>
<%@page import="com.trs.infra.util.ExceptionNumber"%>
<%@page import="java.util.Enumeration"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="public_server_nologin.jsp"%>
<%
	String method = request.getMethod();
	request.setCharacterEncoding("UTF-8");
	BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream(),"utf-8"));
	String line = null;
	StringBuilder sb = new StringBuilder();
	while((line = br.readLine())!=null){
		sb.append(line);
	}
	//得到一个字符串，转换成json格式即可
	//JSONObject a = JSONObject.fromObject(sb.toString());
	//读取配置
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
	String msg = "";
	if("POST".equals(method)){
				msg = Utils.ManuscriptPush(sb.toString(), loginUser);
	} else {
		msg = "{\"success\":false,\"msg\":\"method GET not support\"}";
	}
	out.print(msg);
%>