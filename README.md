部署手册：
将wcm文件夹复制到WCM安装目录下的Tomcat/webapps下覆盖原wcm目录。

配置手册：
1、打开wcm/WEB-INF/classes/com/trs/fz/hznews.properties文件
	1、channelCode:按既定要求修改channelCode(jrhzw)
	2、url:状态回写的方正接口的URL(http://192.168.2.133:8081/status/update)
	3、websiteid,channelid:所请求栏目树的父站点或父栏目,若websiteid为空则返回channelid下的所有栏目，两个参数不能同时为空。
	4、channelid：所请求栏目数的父栏目，可填写多个父栏目ID，多个父栏目ID之间需要用,(英文逗号)隔开
2、重启wcm服务

目录文件说明：
channeltree.jsp :同步栏目接口
changestate.jsp :稿件状态变更接口
manuscript.jsp  :推送稿件接口
public_server_nologin.jsp: 实现免登录
Tomcat\webapps\wcm\WEB-INF\classes\com\trs\fz\Utils.classes :稿件推送业务逻辑代码
