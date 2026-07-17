    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.project.servicereportlist.serviceReportListDAO" %>
<%
serviceReportListDAO sd=new serviceReportListDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String contrctid =request.getParameter("contrctid")==null?"0":request.getParameter("contrctid").toString();%>
  <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
  <% String assgrpid =request.getParameter("assgrpid")==null?"0":request.getParameter("assgrpid").toString();%>

 <script type="text/javascript">
 var data,projectlistexcel;
 
 var rendererstring=function (aggregates){
	  	var value=aggregates['sum'];
	  	
	  	if(typeof(value)=='undefined'){
	  		value=0;
	  	}
	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
		}
	  	var rendererstring1=function (aggregates){
	  	var value1=aggregates['sum1'];
	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
	  }
 
 
 var bb='<%=rds%>';
	if(bb!='0'){
 data= '<%= sd.loadGridData(fromdate,todate,rds,barchval,contrctid,clientid,assgrpid)%>';
 servicereportlistexcel= '<%= sd.loadGridExcel(fromdate,todate,rds,barchval,contrctid,clientid,assgrpid)%>';
	}
	else{
		bb=1;
	}
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cldocno', type: 'String'  },
     						{name : 'costomer', type: 'String'  },
     						{name : 'contrtype', type: 'String' },
     						{name : 'contrno', type: 'String' },
     						{name : 'siteadd', type: 'String' },
     						{name : 'schno', type: 'number' },
     						{name : 'wrkper', type: 'String' },
     						{name : 'sl', type: 'number' },
     						{name : 'chkrect', type: 'String' },
     						{name : 'rect', type: 'String' },
     						{name : 'grpcode', type: 'String' },
     						{name : 'name', type: 'String' }
     					     						
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '99%',
                height: 545,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 25,
                sortable: true,
                //Add row method
                columns: [
                    { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	   
					{ text: 'Code', datafield: 'cldocno', width: '8%' },
					{ text: 'Customer',  datafield: 'costomer', width: '8%' },
					{ text: 'Contract Type', datafield: 'contrtype', width: '15%' },
					{ text: 'Contract No.', datafield: 'contrno', width: '15%' },
					{ text: 'Site Area', datafield: 'siteadd', width: '15%' },
					{ text: 'Schedule No.', datafield: 'schno', width: '15%' },
					{ text: 'Complete %', datafield: 'wrkper', width: '10%' },
					{ text: 'Rectification', datafield: 'chkrect', width: '15%' },
					{ text: 'Rectification description', datafield: 'rect', width: '10%' },
					{ text: 'Assign Group', datafield: 'grpcode', width: '10%' },
					{ text: 'Assign Member', datafield: 'name', width: '10%' },
					
					
	              ]
            });
            if(bb==1)
        	{
        	 $("#jqxloaddataGrid").jqxGrid('addrow', null, {});
        	}

                 $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxloaddataGrid"></div>
