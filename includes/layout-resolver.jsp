<%--
  ~ Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com) All Rights Reserved.
  ~
  ~ WSO2 Inc. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
--%>

<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.net.URLDecoder" %>

<%-- Change the layout name to activate another layout --%>
<%
    String layout = "default";
%>

<%-- Activate the "custom" layout if exists --%>
<%
    String relyingParty = request.getParameter("relyingParty"); 
    String tenantDomain1 = request.getParameter("tenantDomain"); 
    String callingTenant = tenantDomain1;    
    if (tenantDomain1.equals("carbon.super")) {
        if (request.getParameter("state") != null && !request.getParameter("state").equals("")) {
            String[] stateValues = URLDecoder.decode(request.getParameter("state"), "UTF-8").split("=");
            callingTenant = stateValues[1];
        }
    }     
    if (config.getServletContext().getResource("extensions/layouts/"+callingTenant+"/body.ser") != null) {
        layout = callingTenant;
    } 
%>

<%-- Layout Resolving Part --%>
<%
    String layoutFileRelativePath;
    Map<String, Object> layoutData = new HashMap<String, Object>();
    if (!layout.equals(tenantDomain1)) {
        if (layout.equals("default")) {
            layoutFileRelativePath = "includes/layouts/" + layout + "/body.ser";
        } else {
            layoutFileRelativePath = "extensions/layouts/" + layout + "/body.ser";
            if (config.getServletContext().getResource(layoutFileRelativePath) == null) {
                layout = "default";
                layoutFileRelativePath = "includes/layouts/default/body.ser";
            }
        }
    } else {
        layoutFileRelativePath = "extensions/layouts/"+tenantDomain1+"/body.ser";
    }
%>
