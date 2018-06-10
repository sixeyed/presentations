<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Document   : Page1
    Created on : 06-Jun-2018, 15:33:38
    Author     : Administrator
-->
<jsp:root version="2.1" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html" xmlns:jsp="http://java.sun.com/JSP/Page" xmlns:webuijsf="http://www.sun.com/webui/webuijsf">
    <jsp:directive.page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"/>
    <f:view>
        <webuijsf:page binding="#{Page1.page1}" id="page1">
            <webuijsf:html binding="#{Page1.html1}" id="html1">
                <webuijsf:head binding="#{Page1.head1}" id="head1">
                    <webuijsf:link binding="#{Page1.link1}" id="link1" url="/resources/stylesheet.css"/>
                </webuijsf:head>
                <webuijsf:body binding="#{Page1.body1}" id="body1" style="-rave-layout: grid">
                    <webuijsf:form binding="#{Page1.form1}" id="form1">
                        <div>
                            <h1>
                            Java JSP App</h1>
                            <h2>
                                Server:  <webuijsf:label binding="#{Page1.lblServer}" id="lblServer"/>
                            </h2>
                        </div>
                        <hr/>
                        <h2>Logging</h2>
                        <div>
                            <h3>java.util.logging config</h3>
                            <table border="1">
                                <tr>
                                    <td>Level</td>
                                    <td>
                                        <webuijsf:label binding="#{Page1.lblLogLevel}" id="lblLogLevel"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Appender</td>
                                    <td>
                                        <webuijsf:label binding="#{Page1.lblLogAppender}" id="lblLogAppender"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Target</td>
                                    <td>
                                        <webuijsf:label binding="#{Page1.lblLogTarget}" id="lblLogTarget"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div>
                            <h3>context environment config</h3>
                            <table border="1">
                                <tr>
                                    <td>LogCount</td>
                                    <td>
                                        <webuijsf:label binding="#{Page1.lblLogCount}" id="lblLogCount"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br/>
                        <div>
                            <webuijsf:button actionExpression="#{Page1.btnLog_action}" binding="#{Page1.btnLog}" id="btnLog" text="Write Logs"/>
                            <i>
                                <webuijsf:label binding="#{Page1.lblLogOutput}" id="lblLogOutput"/>
                            </i>
                        </div>
                        <hr/>
                        <h2>Database Access</h2>
                        <div>
                            <h3>context resource config</h3>
                            <table border="1">
                                <tr>
                                    <td>Server Name</td>
                                    <td>
                                        <webuijsf:label binding="#{Page1.lblDbServer}" id="lblDbServer"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br/>
                        <div>
                            <webuijsf:button actionExpression="#{Page1.btnSql_action}" binding="#{Page1.btnSql}" id="btnSql" text="Execute Sql"/>
                            <i>
                                <webuijsf:label binding="#{Page1.lblSqlOutput}" id="lblSqlOutput"/>
                            </i>
                        </div>
                    </webuijsf:form>
                </webuijsf:body>
            </webuijsf:html>
        </webuijsf:page>
    </f:view>
</jsp:root>
