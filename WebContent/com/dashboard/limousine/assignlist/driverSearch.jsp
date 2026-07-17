<%@ page import="com.dashboard.limousine.assignlist.*" %>
<%ClsLimoAssignListDAO assigndao=new ClsLimoAssignListDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<script type="text/javascript">
	var id='<%=id%>';
	var driverdata=[];
	if(id=="1"){
		driverdata='<%=assigndao.getDriver(id)%>';
	}
	$(document).ready(function () { 	
    
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'number'  },
                            {name : 'sal_code', type: 'string'  },
                            {name : 'sal_name', type: 'string'  },
     						{name : 'lic_no', type: 'string'    },
     						{name : 'lic_exp_dt', type: 'date'    },
     						{name : 'authority', type: 'string'    },
     						{name : 'mobno', type: 'string'    }
                        ],
                		
                       
                       localdata: driverdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#driverSearch").jqxGrid(
            {
                width: '100%',
                height: 338,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                            { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  },
                              
                            { text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
                            { text: 'Code', datafield: 'sal_code', width: '10%'},
                            { text: 'Name', datafield: 'sal_name', width: '40%'},
							{ text: 'License#', datafield: 'lic_no', width: '15%' },
							{ text: 'License Expiry', datafield: 'lic_exp_dt', cellsformat: 'dd.MM.yyyy',width: '10%' },
							{ text: 'Mob No', datafield: 'mobno', width: '21%' }
							   
						]
            });
            
          $('#driverSearch').on('rowdoubleclick', function (event) {
            	
                var rowBoundIndex= event.args.rowindex;
                document.getElementById("driver").value= $('#driverSearch').jqxGrid('getcellvalue',rowBoundIndex, "sal_name"); 
                document.getElementById("hiddriver").value= $('#driverSearch').jqxGrid('getcellvalue',rowBoundIndex, "doc_no"); 
              $('#driversearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="driverSearch"></div>
 