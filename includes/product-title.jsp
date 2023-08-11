<%--
  ~ Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~ WSO2 Inc. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~    http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
--%>

<%@ include file="localize.jsp" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.AuthenticationEndpointUtil" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.net.URLDecoder" %>

<%
    String logo = "libs/themes/default/assets/images/branding/logo.svg";
    String title = "";
    String relyingParty = request.getParameter("relyingParty"); 
    String tenantDomain1 = request.getParameter("tenantDomain"); 
    String callingTenant = tenantDomain1;
    
    if (tenantDomain1.equals("carbon.super")) {
        String[] stateValues = URLDecoder.decode(request.getParameter("state"), "UTF-8").split("=");
        callingTenant = stateValues[1];
    }  
    if (callingTenant.equals("carbon.super")) {
      logo = "libs/themes/default/assets/images/branding/logo.svg";
      title = "";
    } else {
      if (config.getServletContext().getResource("extensions/layouts/"+callingTenant+"/assets/logo.png") != null) {
        logo = "extensions/layouts/"+callingTenant+"/assets/logo.png";
        String absolutePath = getServletContext().getRealPath("extensions/layouts/"+callingTenant+"/assets/title.txt");
        FileReader fr = new FileReader(absolutePath);
        try {
          BufferedReader br = new BufferedReader(fr);
          String line = br.readLine();
          if (line == null) {
            title = "";
          } else {
            title = line;
          }
        } catch (IOException e) {
          title = "";
          e.printStackTrace();
        }
      }
    }
%>

<div class="product-title" data-testid="product-title">
    <div class="theme-icon inline auto transparent product-logo portal-logo">
      <img src="<%=logo%>" ></img>
      <p class="fp-logo-name"> <%=title%></p>
    </div>
</div>
