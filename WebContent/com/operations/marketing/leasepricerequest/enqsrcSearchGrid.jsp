<%@page import="com.operations.marketing.leasepricerequest.ClsLeasepriceRequestDAO" %>
<%
String id = request.getParameter("id")==null?"0":request.getParameter("id");
ClsLeasepriceRequestDAO viewDAO=new ClsLeasepriceRequestDAO();
%> 

 <script type="text/javascript">
 var id='<%=id%>';
 var enqdata=[];
if(id=="1"){
	enqdata='<%=viewDAO.getEnqsrcData(id)%>';
}
        $(document).ready(function () { 
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'doc_no', type: 'number'  },
     						{name : 'date', type: 'date'  },
     						{name : 'txtname', type: 'String'  }, 
     						{name : 'txtmobile', type: 'String'  }
      						
                          	],
                          	localdata: enqdata,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#enqSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
             	filterable:true,
             	showfilterrow:true,
     					
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Name', datafield: 'txtname', width: '55%' }, 
					{ text: 'Mobile', datafield: 'txtmobile', width: '20%'}
					
					
					
					]
            });
    
           
   /*          $("#Jqxclientsearch").jqxGrid('addrow', null, {}); */
				            
	           $('#enqSearchGrid').on('rowdoubleclick', function (event) 
	            		{ 
	              	var rowindex1=event.args.rowindex;
	                document.getElementById("enqsrc").value= $('#enqSearchGrid').jqxGrid('getcellvalue', rowindex1, "txtname");
	               	document.getElementById("hidenqsrc").value=$('#enqSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
	                $('#enqsrcwindow').jqxWindow('close');
	           }); 	 
	           
        }); 
				       
                       
    </script>
    <div id="enqSearchGrid"></div>
    