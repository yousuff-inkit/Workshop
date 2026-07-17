<%@page import="com.controlcentre.masters.salesmanmaster.insurancesurvivor.ClsInsuranceSurvivorDAO"%>
<%
String docno = request.getParameter("docno")==null?"":request.getParameter("docno");
String clientname = request.getParameter("clientname")==null?"":request.getParameter("clientname");
String mobile = request.getParameter("mobile")==null?"":request.getParameter("mobile");
String email = request.getParameter("email")==null?"":request.getParameter("email");
String dtype = request.getParameter("dtype")==null?"":request.getParameter("dtype");
ClsInsuranceSurvivorDAO dao= new ClsInsuranceSurvivorDAO();
%> 

 <script type="text/javascript">
 var vnddata='<%=dao.getVendorData(docno,clientname,mobile,email)%>';
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
            
            
     					
                columns: [
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '10%' },
					{ text: 'NAME', datafield: 'refname', width: '40%' },
					{ text: 'MOB', datafield: 'per_mob', width: '25%' },
					{ text: 'Mail', datafield: 'mail1', width: '25%'}
			
					
					 

					
					]
            });
    		$('#vendorSearchGrid').on('rowdoubleclick', function (event) 
     		{ 
		       	var rowindex=event.args.rowindex;
		       	var dtype='<%=request.getParameter("dtype")==null?"":request.getParameter("dtype")%>';
		       	if(dtype=="WRB"){
		       		$('#txtaccno').val($('#vendorSearchGrid').jqxGrid('getcellvalue', rowindex, "cldocno"));
			       	$('#txtaccname').val($('#vendorSearchGrid').jqxGrid('getcellvalue', rowindex, "refname"));
		       	}
		       	else{
			       	$('#cldocno').val($('#vendorSearchGrid').jqxGrid('getcellvalue', rowindex, "cldocno"));
			       	$('#clientname').val($('#vendorSearchGrid').jqxGrid('getcellvalue', rowindex, "refname"));		       		
		       	}
		        $('#accountWindow').jqxWindow('close');
		    }); 	 
		}); 
				       
                       
    </script>
    <div id="vendorSearchGrid"></div>
    
    </body>
</html>