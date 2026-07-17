<html>
<% String contextPath=request.getContextPath();%>
<head>

<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/jqx-10.1.6/jqx.base.css" rel="stylesheet"  type="text/css" />
<link href="<%=contextPath%>/css/table.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/myButton.css" media="screen" rel="stylesheet" type="text/css" /> 
<link href="<%=contextPath%>/css/jqx-10.1.6/jqx.mobile.css" media="screen" rel="stylesheet" type="text/css" /> 
<link href="<%=contextPath%>/css/jqx-10.1.6/jqx.energyblue.css" media="screen" rel="stylesheet" type="text/css" />  
    <script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxcore.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/demos.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxdatetimeinput.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxcalendar.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxmenu.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxtabs.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxbuttons.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxscrollbar.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxgrid.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxgrid.selection.js"></script> 
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxgrid.columnsresize.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxgrid.edit.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxgrid.sort.js"></script> 
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxgrid.pager.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxgrid.filter.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxgrid.grouping.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxdata.js"></script> 
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/globalize.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxpanel.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxlistbox.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxcheckbox.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxtooltip.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/globalize.js"></script>  
	<script type="text/javascript" src="<%=contextPath%>/js/jqxwindow.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxtree.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxgrid.aggregates.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxexpander.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jquery.easyui.min.js"></script>
	
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxdatatable.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxtreegrid.js"></script>
	
	<%-- <script type="text/javascript" src="<%=contextPath%>/js/alert/jquery-1.4.4.min.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/alert/jquery.easyui.min.js"></script>--%>
	
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxchart.core.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxdraw.js"></script>
	<%--<script type="text/javascript" src="<%=contextPath%>/js/jqxslider.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxradiobutton.js"></script> --%>
	
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/icon.css">
  	
  	<script type="text/javascript" src="<%=contextPath%>/js/additional-methods.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery.validate.min.js"></script>
	
	<script type="text/javascript" src="<%=contextPath%>/js/pace.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxdata.export.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxgrid.export.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/jqxinput.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/exportExcel.js"></script>
	
</head> 
</html>
