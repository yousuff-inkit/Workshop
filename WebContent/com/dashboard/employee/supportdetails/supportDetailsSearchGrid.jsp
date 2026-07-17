<%@page import="com.dashboard.employee.supportdetails.ClsSupportDetails" %>
<%ClsSupportDetails csd=new ClsSupportDetails(); %>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <script type="text/javascript">
 
	var data3='<%=csd.supportNameLoading()%>';
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no', type: 'int'   },
 						{name : 'name', type: 'string'   }
                    ],
            		localdata: data3, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#supportSearch").jqxGrid(
        {
        	width: '100%',
        	height: 350,
            source: dataAdapter,
            selectionmode: 'singlerow',
            showfilterrow: true, 
            filterable: true, 
 			editable: false,
 			columnsresize: true,
            
            columns: [
						{  text: 'No.', sortable: false, filterable: false, editable: false,
						    groupable: false, draggable: false, resizable: false,datafield: '',
						    columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
						    cellsrenderer: function (row, column, value) {
							   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						   }  
						},  
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Name', datafield: 'name', width: '90%' },
					]
        });
        
	        $('#supportSearch').on('rowdoubleclick', function (event) {
	            var rowindex1 = event.args.rowindex;
	        	document.getElementById("txtsupportname").value = $('#supportSearch').jqxGrid('getcellvalue', rowindex1, "name");
	        	document.getElementById("txtsupportid").value = $('#supportSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	        	
	            $('#supportDetailsWindow').jqxWindow('close');  
	        });  
    });
</script>

<div id="supportSearch"></div>
    