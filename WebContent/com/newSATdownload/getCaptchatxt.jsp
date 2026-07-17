 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
      <%@page import="com.NewSatDownload.SATdownloadDAO" %>
       <% SATdownloadDAO DAO=new SATdownloadDAO(); %> 

 <% String txtcaptcha =request.getParameter("txtcaptcha")==null?"0":request.getParameter("txtcaptcha").toString();
 //System.out.println("sssssssssssssssssssssssssssssssss"+txtcaptcha);%>

 <script type="text/javascript">
 var data;
 /* alert("getcaptchatxt=========="); */
  <% if(txtcaptcha!=" "){ %> 
 data= '<%=DAO.loadCaptchatext(txtcaptcha)%>';
    <%}%> 
</script>
