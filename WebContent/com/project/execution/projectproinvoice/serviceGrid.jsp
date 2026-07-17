<%@page import="com.project.execution.projectproInvoice.ClsProjectProInvoiceDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsProjectProInvoiceDAO DAO= new ClsProjectProInvoiceDAO(); %>
 <%
  String trno=request.getParameter("pjinvtrno")==null?"0":request.getParameter("pjinvtrno").trim().toString();
 
 %>
    <script type="text/javascript">
    var servdata;
    var trno='<%=trno%>';
    var bb;
     if(trno>0){
		
    	servdata = '<%=DAO.serviceGridLoad(session,trno)%>';
    	bb=3;
    	
  }
     else{
    	 bb=5;
     }
    
    
        $(document).ready(function () { 	
         var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'dtype' , type: 'String' },
                          
     						{name : 'date', type: 'date'  },
     						{name : 'docno', type: 'String'  },
     						{name : 'amount', type: 'String'  },
     						
     						{name : 'descp', type: 'String'  },
     						{name : 'lfee', type: 'String'  }
                          	],
                 localdata: servdata,
                
                
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
            $("#serviceGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable:true,
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc Type', datafield: 'dtype', width: '16%',editable:false },
					
					{ text: 'Doc No', datafield: 'docno', width: '10%',editable:false},
					{ text: 'Date', datafield: 'date', width: '10%',editable:false,cellsformat:'dd.MM.yyyy' },
					{text: 'Description',datafield:'descp',width:'40%',editable:false},
					{text: 'Amount',datafield:'amount',width:'10%'},
					{text: 'Legal Fee',datafield:'lfee',width:'10%'}
					
					]
            });
            if($('#mode').val()=='view'){
       		 $("#serviceGrid").jqxGrid({ disabled: true});
       		
           }
           /*  $('#serviceGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="stype"))
	    	   {
 		    	 getserType(rowBoundIndex);
	    	   }
 		    			
            		});
       */
       if(bb==5)
    	   {
           $("#serviceGrid").jqxGrid('addrow', null, {});
    	   }
    	 
      
        });
    </script>
    <div id="serviceGrid"></div>
