<%@page import="com.dashboard.audit.ClsAudit" %>
<% ClsAudit ca=new ClsAudit();%>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String check=request.getParameter("check")==null?"0":request.getParameter("check").trim();%>  

<script type="text/javascript">
        
		var data;
		var temp='<%=branchval%>';
		
		if(temp!='NA'){
		   data='<%=ca.vehStockCheckAudit(branchval,check)%>'; 
		}
	$(document).ready(function () {
		
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		{name : 'date' , type: 'date' },
						{name : 'doc_no', type: 'int'  },
						{name : 'user_name', type: 'string'  },
						{name : 'branchname', type: 'string'  },
						{name : 'brhid', type: 'int'  },
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
		            
	            });
    
    
    $("#jqxVehStockGrid").jqxGrid(
    {
        width: '98%',
        height: 202,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        editable: false,
       
        columns: [
               
					{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '15%' },
					{ text: 'Doc No', datafield: 'doc_no',  width: '10%'},
					{ text: 'User Name', datafield: 'user_name', width: '45%' },
					{ text: 'Branch', datafield: 'branchname', width: '30%'  },
					{ text: 'Branch Id', datafield: 'brhid', hidden: true, width: '10%'  },
			     ]
    
    });
    
    $("#overlay, #PleaseWait").hide();
    
    $('#jqxVehStockGrid').on('rowdoubleclick', function (event) { 
    	  var rowindex1=event.args.rowindex;
    	  document.getElementById("txtdocno").value=$('#jqxVehStockGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
    	  document.getElementById("txtbranchid").value = $('#jqxVehStockGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
    	  $("#jqxVehStockDetailGrid").jqxGrid('disabled', false);
    	  $("#overlay, #PleaseWait").show();
    	  
          $("#auditDetailDiv").load("auditDetailGrid.jsp?docno="+$('#jqxVehStockGrid').jqxGrid('getcellvalue', rowindex1, 'doc_no')+"&check=1");
       }); 

    
});

</script>
<div id="jqxVehStockGrid"></div>