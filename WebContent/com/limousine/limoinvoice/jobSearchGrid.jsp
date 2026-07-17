
<%@page import="com.limousine.limoinvoice.*" %>
<%ClsLimoInvoiceDAO invoicedao=new ClsLimoInvoiceDAO();%>
<%String gridrowindex=request.getParameter("gridrowindex")==null?"0":request.getParameter("gridrowindex");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String guest=request.getParameter("guest")==null?"":request.getParameter("guest");
String jobtype=request.getParameter("jobtype")==null?"":request.getParameter("jobtype");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
 <script type="text/javascript">
 var gridrowindex='<%=gridrowindex%>';
 var id='<%=id%>';
 var jobsearchdata=[];
 if(id=="1"){
	 jobsearchdata='<%=invoicedao.getJobSearchData(client,guest,jobtype,id)%>';
 }
   $(document).ready(function () { 	
       	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name :'jobdocno',type:'string'},
     						{name :'bookdocno', type: 'string'},
     						{name :'jobtype', type: 'string'},
     						{name :'jobname',type:'string'}

                 ],               
               localdata:jobsearchdata,
               
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

            
            
            $("#jobSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                selectionmode: 'singlerow',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
 
				},
                
                columns: [
                            
                            {text: 'Doc No',datafield:'jobdocno',width:'25%'},					
                            { text: 'Booking Doc No',datafield:'bookdocno',width:'25%'},
							{ text: 'Job Type', datafield: 'jobtype', width: '25%'},
							{ text: 'Job Name',datafield:'jobname',width:'25%'}
	              ]
            });
       $('#jobSearchGrid').on('rowdoubleclick', function (event) {
    	   var row1=event.args.rowindex;
    		$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'jobnametemp',$('#jobSearchGrid').jqxGrid('getcellvalue',row1,'jobname'));
    		$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'jobdocno',$('#jobSearchGrid').jqxGrid('getcellvalue',row1,'jobdocno'));
    		$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'bookdocno',$('#jobSearchGrid').jqxGrid('getcellvalue',row1,'bookdocno'));
    	   $('#jobwindow').jqxWindow('close');

       });
       
        });
    </script>
    <div id="jobSearchGrid"></div>
