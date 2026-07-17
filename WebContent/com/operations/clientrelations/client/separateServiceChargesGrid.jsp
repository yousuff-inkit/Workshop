<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<% ClsClientDAO DAO= new ClsClientDAO(); %>
<% String docNo = request.getParameter("txtclientdocno4")==null?"0":request.getParameter("txtclientdocno4"); 
   String defaultsevicecharge = request.getParameter("defaultsevicecharge")==null?"0":request.getParameter("defaultsevicecharge");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 
<% String contextPath=request.getContextPath();%>
<script type="text/javascript">
        var data5;      
        $(document).ready(function () { 	
           
           var temp5='<%=docNo%>';
           var tempcheck5='<%=check%>';
            
            <%--  if(temp5>0)
          	 {   
           	     data5='<%=DAO.separateServiceChargeGridReloading(docNo,check)%>';      
          	 } else if(tempcheck5=='2'){
          		data5='<%=DAO.separateServiceChargeGridLoading(defaultsevicecharge,check)%>';
          	 } --%>
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'desc1', type: 'string'  },
     						{name : 'doc_no', type: 'int'    },
     						{name : 'salik', type: 'number'    },
     						{name : 'traffic', type: 'number'    }
     								
                 ],
                 localdata: data5,
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#separateServiceChargeGridId").jqxGrid(
            {
                width: '100%',
                height: 80,
                source: dataAdapter,
                editable: true,
                enableAnimations: true,
                selectionmode: 'singlecell',
                
                columns: [							
							{ text: 'Doc No', datafield: 'doc_no', hidden: true, width: '10%' },
							{ text: 'Service Charge', datafield: 'desc1', editable: false, width: '50%' },
							{ text: 'Salik', datafield: 'salik', cellsformat: 'd2', width: '25%', cellsalign: 'right', align: 'right',
								cellbeginedit: function (row) {
									if(document.getElementById("hidchckseparatesrvcdefault").value==1)
							         {
							              return false;
							         }}
							},
							{ text: 'Traffic', datafield: 'traffic', cellsformat: 'd2', width: '25%', cellsalign: 'right', align: 'right',
								cellbeginedit: function (row) {
									if(document.getElementById("hidchckseparatesrvcdefault").value==1)
							         {
							              return false;
							         }}
							},
	              ]
            });
            
          	if(temp5>0){  
        	  $("#separateServiceChargeGridId").jqxGrid({ disabled: true});
       	  	} 
            
        });
        
</script>
<div id="separateServiceChargeGridId"></div>
