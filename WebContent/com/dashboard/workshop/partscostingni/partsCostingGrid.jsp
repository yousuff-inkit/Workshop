<%@ page import="com.dashboard.workshop.partscosting.ClsPartsCostingDAO" %>
	
<%
String fromdate = request.getParameter("from")==null?"":request.getParameter("from").trim();
String todate = request.getParameter("to")==null?"":request.getParameter("to").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
String estno = request.getParameter("estno")==null?"0":request.getParameter("estno").trim();

ClsPartsCostingDAO pcdao=new ClsPartsCostingDAO();
%>
 <script type="text/javascript">
 
 var data1;
 var pcexceldata;
 var temp=<%=check%>
 if(temp==1){
	 data1='<%=pcdao.masterReload(fromdate,todate,cldocno,estno)%>';
	 pcexceldata='<%=pcdao.excelReload(fromdate,todate,cldocno,estno)%>';
 }
 else{
	 data1=[];
	 pcexceldata=[];
 }
		$(document).ready(function () { 
            var source =
            {
                datatype: "json",
                datafields: [
                       
										{name : 'date', type: 'date'   },	
										{name : 'time', type: 'time'  },
                   						{name : 'reptype', type: 'string'  },
                   						{name : 'customer', type: 'string'    },
                   						{name : 'regno', type: 'string'    },
                   						{name : 'pcode', type: 'date'    },
                   						{name : 'brand', type: 'string'    },
                   						{name : 'model', type: 'string'    },
                   						
                   						{name : 'gipdate', type: 'string'},	
										{name : 'expdelivery', type: 'date'  },
                   						{name : 'dtime', type: 'time'  },
                   						{name : 'description', type: 'string'    },
                   						{name : 'useropen', type: 'string'    },
                   						{name : 'estimatedby', type: 'string'    },
                   						{name : 'estno', type: 'string'    },
                   						{name : 'estdate', type: 'date'    },
                   						{name : 'approval', type: 'string'    },
                   						{name : 'jobno', type: 'string'    }
                   						
                   						
                   						
                   				//	 t.postdocno
                   						
                   					// rano dtypedesc
                   						
                   						
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#partsCostingGridId").jqxGrid(
            {
                width: '98%',
                height: 290,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates: false,
                showfilterrow: true,
                selectionmode: 'singlerow',
                editable: false,
                
                
                columns: [
								{ text: 'Estimation No', datafield: 'estno', width: '7%'},
								{ text: 'Est Date', datafield: 'estdate', width: '7%' },
								{ text: 'Job no', datafield: 'jobno', width: '5%' },
								{ text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy' },
							  { text: 'Time', datafield: 'time', width: '6%',cellsformat:'HH:mm' }, 
							  { text: 'Repair Type', datafield: 'reptype', width: '6%' },  
							  { text: 'Customer Name', datafield: 'customer', width: '8%' },
							  { text: 'Reg No', datafield: 'regno', width: '5%' },
							  { text: 'P.code', datafield: 'pcode', width: '6%'},
							  { text: 'Brand', datafield: 'brand', width: '7%' },
							  { text: 'Model', datafield: 'model', width: '7%' },
							  
							  { text: 'Days-GIP Date', datafield: 'gipdate', width: '7%'},
							  { text: 'Exp. Delivery', datafield: 'expdelivery', width: '7%',cellsformat:'dd.MM.yyyy' },
							  { text: 'Del. Time', datafield: 'dtime', width: '6%',cellsformat:'HH:mm' }, 
							  { text: 'Description', datafield: 'description', width: '20%' },  
							  { text: 'User Open', datafield: 'useropen', width: '8%' },
							  { text: 'Estimated By', datafield: 'estimatedby', width: '10%' },
							  
							  { text: 'Approval status', datafield: 'approval', width: '8%' }
							  
														
	              ]
            });
            $('#partsCostingGridId').on('rowdoubleclick', function (event){ 
        	  	var rowindex1=event.args.rowindex;
        	  	document.getElementById("hidestm").value=$("#partsCostingGridId").jqxGrid('getcellvalue', rowindex1, "estno");
        	  	document.getElementById("hidjobno").value=$("#partsCostingGridId").jqxGrid('getcellvalue', rowindex1, "jobno");
        	  	funpartsload($('#partsCostingGridId').jqxGrid('getcellvalue', rowindex1, "estno"));
             });	 
             
         
            
            $("#overlay, #PleaseWait").hide();
        	
            
        });
    </script>
    <div id="partsCostingGridId"></div>


