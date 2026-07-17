<%@page import="com.controlcentre.masters.salesmanmaster.checkin.*"%>
<%
String docno = request.getParameter("docno")==null?"":request.getParameter("docno");
String clientname = request.getParameter("clientname")==null?"":request.getParameter("clientname");
String mobile = request.getParameter("mobile")==null?"":request.getParameter("mobile");
String email = request.getParameter("email")==null?"":request.getParameter("email");
String id = request.getParameter("id")==null?"":request.getParameter("id");
ClsCheckinDAO dao= new ClsCheckinDAO();
%> 

 <script type="text/javascript">
 var vnddata=[];
 var id='<%=id%>';
 if(id=="1"){
 	vnddata='<%=dao.getVendorData(docno,clientname,mobile,email,id)%>';
 }
 else{
 	vnddata=[];
 }
        $(document).ready(function () { 
        
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						{name : 'mail1', type: 'String'  },
     						
                          	],
                          	localdata: vnddata,
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
            $("#vendorSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            	filterable:true,
            	showfilterrow:true,
            	sortable:true,
     					
                columns: [
					{ text: 'Doc NO', datafield: 'cldocno', width: '10%' },
					{ text: 'Name', datafield: 'refname', width: '40%' },
					{ text: 'Mobile', datafield: 'per_mob', width: '25%' },
					{ text: 'Mail', datafield: 'mail1', width: '25%'}
			
					
					 

					
					]
            });
    		$('#vendorSearchGrid').on('rowdoubleclick', function (event) 
     		{ 
		       	var rowindex=event.args.rowindex;
		       	$('#cldocno').val($('#vendorSearchGrid').jqxGrid('getcellvalue', rowindex, "cldocno"));
		       	$('#refname').val($('#vendorSearchGrid').jqxGrid('getcellvalue', rowindex, "refname"));
		        $('#accountWindow').jqxWindow('close');
		    }); 	 
		}); 
				       
                       
    </script>
    <div id="vendorSearchGrid"></div>
    
    </body>
</html>