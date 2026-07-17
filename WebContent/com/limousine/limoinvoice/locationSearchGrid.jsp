<%@page import="com.limousine.limoinvoice.*" %>
<%ClsLimoInvoiceDAO invoicedao=new ClsLimoInvoiceDAO();%>
<%String gridrowindex=request.getParameter("gridrowindex")==null?"0":request.getParameter("gridrowindex");
String datafield=request.getParameter("datafield")==null?"":request.getParameter("datafield");
%>
 <script type="text/javascript">
 var gridrowindex='<%=gridrowindex%>';
 var datafield='<%=datafield%>';
 var locationsearchdata='<%=invoicedao.getLocationSearchData()%>';
   $(document).ready(function () { 	
       	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name :'doc_no',type:'string'},
     						{name : 'location', type: 'string'}

                 ],               
               localdata:locationsearchdata,
               
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

            
            
            $("#locationSearchGrid").jqxGrid(
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
                            
                            {text: 'Doc No',datafield:'doc_no',width:'20%'},					
                            {text: 'Location',datafield:'location',width:'80%'}
	              ]
            });
       $('#locationSearchGrid').on('rowdoubleclick', function (event) {
    	   var row1=event.args.rowindex;
    	   if(datafield=="pickuplocation"){
    		   	$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'pickuplocation',$('#locationSearchGrid').jqxGrid('getcellvalue',row1,'location'));
       			$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'pickuplocationid',$('#locationSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));   
    	   }
    	   else if(datafield=="dropofflocation"){
   		   	$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'dropofflocation',$('#locationSearchGrid').jqxGrid('getcellvalue',row1,'location'));
   			$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'dropofflocationid',$('#locationSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));   
    	   }
    	   $('#locationwindow').jqxWindow('close');

       });
       
        });
    </script>
    <div id="locationSearchGrid"></div>
